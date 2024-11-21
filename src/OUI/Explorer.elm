module OUI.Explorer exposing
    ( Explorer, explorer, explorerWithTheme
    , Book, BookMsg, addBook, book, statefulBook, bookMsg
    , ColorSchemeType, setColorTheme, addColorTheme
    , selectColorScheme, getColorTheme, getSelectedColorTheme
    , withMarkdownChapter, withStaticChapter, withChapter
    , Page, Route, Shared, SharedMsg
    , setTheme, category, logEvent, logEffect, finalize
    )

{-|


# Explorers

@docs Explorer, explorer, explorerWithTheme


# Books

@docs Book, BookMsg, addBook, book, statefulBook, bookMsg


# Colorschemes

@docs ColorSchemeType, setColorTheme, addColorTheme
@docs selectColorScheme, getColorTheme, getSelectedColorTheme


# Chapters

@docs withMarkdownChapter, withStaticChapter, withChapter


# Other

@docs Page, Route, Shared, SharedMsg

@docs setTheme, category, logEvent, logEffect, finalize

-}

import Browser.Navigation
import Effect exposing (Effect)
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Html.Attributes
import Json.Decode
import Json.Encode
import Markdown.Parser
import Markdown.Renderer
import OUI.Button as Button
import OUI.Icon as Icon
import OUI.Material as Material
import OUI.Material.Color as Color
import OUI.Material.Markdown
import OUI.Material.Theme as Theme exposing (Theme)
import OUI.Menu as Menu
import OUI.MenuButton as MenuButton
import OUI.Navigation
import OUI.Switch as Switch
import OUI.Text
import Spa
import Spa.Page
import Spa.PageStack


{-| The explorer routes are simple strings
-}
type alias Route =
    String


{-| A explorer page
-}
type alias Page msg =
    { title : String
    , content : Element msg
    }


{-| Color scheme light/dark
-}
type ColorSchemeType
    = Light
    | Dark


{-| The shared state
-}
type alias Shared themeExt =
    { navKey : Browser.Navigation.Key
    , lastEvents : List String
    , theme : Theme themeExt
    , colorThemeList : List Color.Theme
    , selectedColorScheme : ( Int, ColorSchemeType )
    , selectedBook : String
    , colorThemeButton : MenuButton.State
    }


type alias InitialShared themeExt =
    { theme : Theme themeExt
    , colorThemeList : List Color.Theme
    , selectedColorScheme : ( Int, ColorSchemeType )
    }


{-| Shared state message
-}
type SharedMsg
    = Event String
    | SelectColorScheme Int ColorSchemeType
    | ColorThemeButtonMsg (MenuButton.Msg Int SharedMsg)
    | OnBookClick String
    | OnRouteChange String


defaultView : Page msg
defaultView =
    { title = "Invalid"
    , content = Element.text "invalid view"
    }


mapView : (msg -> msg1) -> Page msg -> Page msg1
mapView mapper abook =
    { title = abook.title
    , content = Element.map mapper abook.content
    }


{-| explorer type definition
-}
type Explorer themeExt current previous currentMsg previousMsg
    = Explorer
        { app : Spa.Builder Route () (Shared themeExt) SharedMsg (Page (Spa.PageStack.Msg Route currentMsg previousMsg)) current previous currentMsg previousMsg
        , categories : List ( String, List String )
        , initialShared : InitialShared themeExt
        }


{-| creates an empty Explorer
-}
explorer : Explorer () () () () ()
explorer =
    explorerWithTheme Theme.defaultTheme


{-| creates an empty Explorer with a customized theme type
-}
explorerWithTheme :
    Theme themeExt
    -> Explorer themeExt () () () ()
explorerWithTheme theme =
    Explorer
        { app =
            Spa.init
                { defaultView = defaultView
                , extractIdentity = always Nothing
                }
        , categories = []
        , initialShared =
            { theme = theme
            , colorThemeList = [ Color.defaultTheme ]
            , selectedColorScheme =
                ( 0, Light )
            }
        }


{-| sets the theme
-}
setTheme :
    Theme themeExt
    -> Explorer themeExt c p cm pm
    -> Explorer themeExt c p cm pm
setTheme theme (Explorer expl) =
    let
        shared : InitialShared themeExt
        shared =
            expl.initialShared
    in
    Explorer
        { expl
            | initialShared = { shared | theme = theme }
        }


{-| takes a color theme sets it as default
-}
setColorTheme :
    Color.Theme
    -> Explorer themeExt c p cm pm
    -> Explorer themeExt c p cm pm
setColorTheme colorTheme (Explorer expl) =
    let
        shared : InitialShared themeExt
        shared =
            expl.initialShared
    in
    Explorer
        { expl
            | initialShared = { shared | colorThemeList = [ colorTheme ] }
        }


{-| adds a color theme to the list of selectable color themes
-}
addColorTheme :
    Color.Theme
    -> Explorer themeExt c p cm pm
    -> Explorer themeExt c p cm pm
addColorTheme colorTheme (Explorer expl) =
    let
        shared : InitialShared themeExt
        shared =
            expl.initialShared
    in
    Explorer
        { expl
            | initialShared = { shared | colorThemeList = shared.colorThemeList ++ [ colorTheme ] }
        }


{-| Add a category to a Explorer

All subsequent books will be added to this category, until a new category is
added.

-}
category :
    String
    -> Explorer themeExt current previous currentMsg previousMsg
    -> Explorer themeExt current previous currentMsg previousMsg
category name (Explorer expl) =
    Explorer
        { expl
            | categories = ( name, [] ) :: expl.categories
        }


{-| Add a book to the current category
-}
addBook :
    Book themeExt model msg
    -> Explorer themeExt current previous currentMsg previousMsg
    -> Explorer themeExt model (Spa.PageStack.Model Spa.SetupError current previous) (BookMsg msg) (Spa.PageStack.Msg Route currentMsg previousMsg)
addBook b (Explorer expl) =
    let
        cat : String
        cat =
            expl.categories
                |> List.head
                |> Maybe.map Tuple.first
                |> Maybe.withDefault ""
    in
    Explorer
        { app =
            expl.app
                |> Spa.addPublicPage ( mapView, mapView )
                    (\route ->
                        if route == bookPath cat b.title then
                            Just route

                        else
                            Nothing
                    )
                    (\shared ->
                        Spa.Page.element
                            { init =
                                \_ ->
                                    b.init shared
                                        |> Tuple.mapSecond (Effect.map BookMsg)
                            , update =
                                \msg model ->
                                    case msg of
                                        SharedMsg subMsg ->
                                            ( model, Effect.fromShared subMsg )

                                        BookMsg subMsg ->
                                            b.update shared subMsg model
                                                |> Tuple.mapSecond (Effect.map BookMsg)
                            , view =
                                \model ->
                                    { title = b.title
                                    , content =
                                        b.chapters
                                            |> List.reverse
                                            |> List.map (\v -> v shared model)
                                            |> Element.column
                                                [ Element.spacing 20
                                                , Element.width Element.fill
                                                , Element.height Element.fill
                                                ]
                                    }
                            , subscriptions =
                                \model ->
                                    b.subscriptions shared model
                                        |> Sub.map BookMsg
                            }
                    )
        , categories =
            case expl.categories of
                ( cat_, pages ) :: tail ->
                    ( cat_, b.title :: pages ) :: tail

                [] ->
                    [ ( "", [ b.title ] ) ]
        , initialShared = expl.initialShared
        }


{-| A stateless book
-}
type alias Book themeExt model msg =
    { title : String
    , init : Shared themeExt -> ( model, Effect SharedMsg msg )
    , update : Shared themeExt -> msg -> model -> ( model, Effect SharedMsg msg )
    , subscriptions : Shared themeExt -> model -> Sub msg
    , chapters : List (Shared themeExt -> model -> Element (BookMsg msg))
    }


{-| A stateless book message
-}
type BookMsg msg
    = SharedMsg SharedMsg
    | BookMsg msg


{-| A simple log event

The passed string will be logged in the log event window

-}
logEvent : String -> BookMsg msg
logEvent value =
    SharedMsg <| Event value


{-| A simple log event, as a Effect

The passed string will be logged in the log event window

Same as 'logEvent', but for update/init

-}
logEffect : String -> Effect SharedMsg msg
logEffect =
    Event >> Effect.fromShared


{-| wrap a book msg into a `BookMsg msg`. This is needed in views.
-}
bookMsg : msg -> BookMsg msg
bookMsg =
    BookMsg


{-| build a Explorer.SharedMsg that changes the currently selected color scheme
-}
selectColorScheme : Int -> ColorSchemeType -> SharedMsg
selectColorScheme i t =
    SelectColorScheme i t


{-| Creates a new static book
-}
book : String -> Book themeExt () ()
book title =
    { title = title
    , init = \_ -> () |> Effect.withNone
    , update = \_ () () -> ( (), Effect.none )
    , subscriptions = \_ () -> Sub.none
    , chapters = []
    }


{-| Creates a new stateful book
-}
statefulBook :
    String
    ->
        { init : Shared themeExt -> ( model, Effect SharedMsg msg )
        , update : Shared themeExt -> msg -> model -> ( model, Effect SharedMsg msg )
        , subscriptions : Shared themeExt -> model -> Sub msg
        }
    -> Book themeExt model msg
statefulBook title { init, update, subscriptions } =
    { title = title
    , init = init
    , update = update
    , subscriptions = subscriptions
    , chapters = []
    }


{-| Add a mardown chapter to a book
-}
withMarkdownChapter : String -> Book themeExt model msg -> Book themeExt model msg
withMarkdownChapter markdown b =
    { b
        | chapters =
            (\shared _ ->
                case
                    Markdown.Parser.parse markdown
                        |> Result.mapError (List.map Markdown.Parser.deadEndToString >> String.join ", ")
                        |> Result.andThen
                            (Markdown.Renderer.render (OUI.Material.Markdown.renderer shared.theme))
                of
                    Ok value ->
                        value
                            |> Element.column [ Element.spacing 15 ]

                    Err err ->
                        Element.text <| "Error rendering markdown: " ++ err
            )
                :: b.chapters
    }


{-| Add a static content chapter to a book
-}
withStaticChapter : (Shared themeExt -> Element (BookMsg msg)) -> Book themeExt model msg -> Book themeExt model msg
withStaticChapter body b =
    { b
        | chapters = (\shared _ -> body shared) :: b.chapters
    }


{-| Add a chapter to a book
-}
withChapter : (Shared themeExt -> model -> Element (BookMsg msg)) -> Book themeExt model msg -> Book themeExt model msg
withChapter body b =
    { b
        | chapters = body :: b.chapters
    }


bookPath : String -> String -> String
bookPath cat title =
    "/"
        ++ (if cat == "" then
                ""

            else
                String.replace "/" "_" cat ++ "/"
           )
        ++ String.replace "/" "_" title
        |> String.replace " " "_"


type alias Flags =
    { dark_mode : Bool
    }


decodeFlags : Json.Decode.Decoder Flags
decodeFlags =
    Json.Decode.map Flags
        (Json.Decode.oneOf
            [ Json.Decode.field "dark_mode" Json.Decode.bool
            , Json.Decode.succeed False
            ]
        )


{-| return the color theme with the given index
-}
getColorTheme : Int -> Shared themeExt -> Color.Theme
getColorTheme i shared =
    shared.colorThemeList
        |> List.drop i
        |> List.head
        |> Maybe.withDefault Color.defaultTheme


{-| return the currently selected color theme
-}
getSelectedColorTheme : Shared themeExt -> Color.Theme
getSelectedColorTheme shared =
    getColorTheme (shared.selectedColorScheme |> Tuple.first) shared


changeColorScheme : Int -> ColorSchemeType -> Shared themeExt -> Shared themeExt
changeColorScheme index type_ shared =
    let
        realIndex : Int
        realIndex =
            if index < 0 then
                0

            else if index >= List.length shared.colorThemeList then
                List.length shared.colorThemeList - 1

            else
                index

        colorScheme : Color.Scheme
        colorScheme =
            shared.colorThemeList
                |> (if realIndex > 0 then
                        List.drop realIndex

                    else
                        identity
                   )
                |> List.head
                |> Maybe.map
                    (\colorTheme ->
                        case type_ of
                            Light ->
                                colorTheme.schemes.light

                            Dark ->
                                colorTheme.schemes.dark
                    )
                |> Maybe.withDefault Color.defaultLightScheme
    in
    { shared
        | theme = shared.theme |> Theme.withColorscheme colorScheme
        , selectedColorScheme = ( realIndex, type_ )
    }


{-| Finalize a explorer and returns Program
-}
finalize :
    Explorer themeExt current previous currentMsg previousMsg
    -> Spa.Application Json.Decode.Value (Shared themeExt) SharedMsg String current previous currentMsg previousMsg
finalize (Explorer expl) =
    let
        categories : List ( String, List String )
        categories =
            expl.categories
                |> List.map (Tuple.mapSecond List.reverse)
                |> List.reverse

        allBooks : List String
        allBooks =
            categories
                |> List.concatMap
                    (\( cat, books ) ->
                        books
                            |> List.map (bookPath cat)
                    )

        firstCategory : String
        firstCategory =
            categories
                |> List.head
                |> Maybe.map Tuple.first
                |> Maybe.withDefault ""

        firstBook : String
        firstBook =
            allBooks
                |> List.head
                |> Maybe.withDefault ""
    in
    expl.app
        |> Spa.beforeRouteChange OnRouteChange
        |> Spa.application mapView
            { toRoute = \url -> url.fragment |> Maybe.withDefault "/"
            , init =
                \flags key ->
                    let
                        dFlags : { dark_mode : Bool }
                        dFlags =
                            Json.Decode.decodeValue decodeFlags flags
                                |> Result.withDefault { dark_mode = False }
                    in
                    ( { navKey = key
                      , lastEvents = []
                      , theme = expl.initialShared.theme
                      , colorThemeList = expl.initialShared.colorThemeList
                      , selectedColorScheme = expl.initialShared.selectedColorScheme
                      , selectedBook = ""
                      , colorThemeButton = MenuButton.init "color-theme-button"
                      }
                        |> changeColorScheme 0
                            (if dFlags.dark_mode then
                                Dark

                             else
                                Light
                            )
                    , Cmd.none
                    )
            , update =
                \msg shared ->
                    case msg of
                        Event value ->
                            ( { shared
                                | lastEvents =
                                    value
                                        :: shared.lastEvents
                                        |> List.take 5
                              }
                            , Cmd.none
                            )

                        ColorThemeButtonMsg buttonMsg ->
                            let
                                ( state, cmd ) =
                                    MenuButton.update buttonMsg shared.colorThemeButton
                            in
                            ( { shared
                                | colorThemeButton = state
                              }
                            , cmd
                            )

                        SelectColorScheme index type_ ->
                            ( changeColorScheme index type_ shared
                            , Cmd.none
                            )

                        OnBookClick path ->
                            ( shared
                            , Browser.Navigation.pushUrl shared.navKey <| "#" ++ path
                            )

                        OnRouteChange route ->
                            ( { shared | selectedBook = route }
                            , if
                                (allBooks
                                    |> List.filter ((==) route)
                                    |> List.head
                                )
                                    /= Nothing
                              then
                                Cmd.none

                              else
                                Browser.Navigation.pushUrl shared.navKey <| "#" ++ firstBook
                            )
            , subscriptions = \_ -> Sub.none
            , protectPage = \_ -> "/"
            , toDocument =
                \shared b ->
                    let
                        colorscheme : Color.Scheme
                        colorscheme =
                            Theme.colorscheme shared.theme
                    in
                    { title = b.title
                    , body =
                        [ Element.column
                            [ Element.height Element.fill
                            , Element.width Element.fill
                            ]
                            [ Element.row
                                [ Element.height Element.fill
                                , Element.width Element.fill
                                ]
                                [ Element.column
                                    [ Element.alignTop
                                    , Element.height Element.fill
                                    ]
                                    [ OUI.Navigation.new (Spa.mapSharedMsg << OnBookClick)
                                        |> OUI.Navigation.withHeader "Orus UI Explorer"
                                        |> OUI.Navigation.withSelected shared.selectedBook
                                        |> (\nav ->
                                                categories
                                                    |> List.foldl
                                                        (\( cat, books ) ->
                                                            (if cat /= firstCategory then
                                                                OUI.Navigation.addDivider

                                                             else
                                                                identity
                                                            )
                                                                >> OUI.Navigation.addSectionHeader cat
                                                                >> (\bn ->
                                                                        books
                                                                            |> List.foldl
                                                                                (\bookName ->
                                                                                    OUI.Navigation.addEntry (bookPath cat bookName) bookName Icon.blank
                                                                                )
                                                                                bn
                                                                   )
                                                        )
                                                        nav
                                           )
                                        |> Material.navigation shared.theme []
                                    , Element.row
                                        [ Element.width Element.fill
                                        , Element.padding 15
                                        , Element.spacing 15
                                        , colorscheme.surfaceContainerHigh
                                            |> Color.toElementColor
                                            |> Background.color
                                        ]
                                        [ OUI.Text.labelMedium "Color theme:"
                                            |> Material.text shared.theme
                                            |> Element.el
                                                [ Element.alignLeft
                                                ]
                                        , MenuButton.new ColorThemeButtonMsg
                                            (\i ->
                                                SelectColorScheme i
                                                    (Tuple.second shared.selectedColorScheme)
                                            )
                                            (Button.new
                                                (getSelectedColorTheme shared |> .name)
                                            )
                                            (Menu.new
                                                (\i ->
                                                    getColorTheme i shared
                                                        |> .name
                                                )
                                                |> Menu.addItems (List.range 0 (List.length shared.colorThemeList - 1))
                                            )
                                            |> MenuButton.alignTop
                                            |> Material.menuButton shared.theme
                                                shared.colorThemeButton
                                                [ Element.centerX
                                                ]
                                            |> Element.map Spa.mapSharedMsg
                                        , Switch.new
                                            (Tuple.second shared.selectedColorScheme
                                                == Dark
                                            )
                                            |> Switch.onChange
                                                (\dark ->
                                                    SelectColorScheme
                                                        (Tuple.first shared.selectedColorScheme)
                                                        (if dark then
                                                            Dark

                                                         else
                                                            Light
                                                        )
                                                        |> Spa.mapSharedMsg
                                                )
                                            |> Switch.withIconSelected Icon.dark_mode
                                            |> Switch.withIconUnselected Icon.light_mode
                                            |> Material.switch shared.theme
                                                [ Element.alignRight
                                                ]
                                        ]
                                    ]
                                , Element.column
                                    [ Element.width Element.fill
                                    , Element.height Element.fill
                                    , Element.padding 20
                                    ]
                                    [ OUI.Text.displayLarge b.title
                                        |> Material.text shared.theme
                                        |> Element.el
                                            [ Element.paddingXY 0 30
                                            ]
                                    , b.content
                                        |> Element.el
                                            [ Element.scrollbarY
                                            , Element.height Element.fill
                                            , Element.width Element.fill
                                            ]
                                    , Element.column
                                        [ Element.height <| Element.shrink
                                        , Element.width Element.fill
                                        , Background.color <| Color.toElementColor colorscheme.surfaceContainerLow
                                        , Element.padding 15
                                        , Element.spacing 8
                                        ]
                                      <|
                                        List.indexedMap
                                            (\i event ->
                                                Element.text event
                                                    |> Element.el
                                                        [ colorscheme.onSurface
                                                            |> Color.setAlpha (1.0 - toFloat i / 5.0)
                                                            |> Color.toElementColor
                                                            |> Font.color
                                                        ]
                                            )
                                            shared.lastEvents
                                    ]
                                ]
                            ]
                            |> Element.layoutWith
                                { options =
                                    [ Element.focusStyle
                                        { borderColor = Nothing
                                        , backgroundColor = Nothing
                                        , shadow = Nothing
                                        }
                                    ]
                                }
                                [ Element.height Element.fill
                                , Element.width Element.fill
                                , Background.color <| Color.toElementColor colorscheme.surface
                                , Font.color <| Color.toElementColor colorscheme.onSurface
                                , Element.scrollbarY
                                , Element.htmlAttribute <|
                                    Html.Attributes.style "-webkit-tap-highlight-color" "transparent"
                                ]
                        ]
                    }
            }
