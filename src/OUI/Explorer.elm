module OUI.Explorer exposing
    ( Book, BookMsg, Page, Route, Shared, SharedMsg, Explorer
    , setTheme, setColorScheme, addBook, book, statefulBook, category, bookMsg, logEvent, explorer, finalize
    , withMarkdownChapter, withStaticChapter, withChapter
    , ColorSchemeType
    )

{-|

@docs Book, BookMsg, Page, Route, Shared, SharedMsg, Explorer
@docs setTheme, setColorScheme, addBook, book, statefulBook, category, bookMsg, logEvent, explorer, finalize
@docs withMarkdownChapter, withStaticChapter, withChapter

-}

import Effect exposing (Effect)
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Json.Decode
import Markdown.Parser
import Markdown.Renderer
import OUI.Icon as Icon
import OUI.Material as Material
import OUI.Material.Color as Color
import OUI.Material.Theme as Theme exposing (Theme)
import OUI.Switch as Switch
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


type ColorSchemeType
    = Light
    | Dark


invertColorSchemeType : ColorSchemeType -> ColorSchemeType
invertColorSchemeType t =
    case t of
        Light ->
            Dark

        Dark ->
            Light


{-| The shared state
-}
type alias Shared =
    { lastEvents : List String
    , theme : Theme
    , colorSchemeList : List ( Color.Scheme, Color.Scheme )
    , selectedColorScheme : ( Int, ColorSchemeType )
    }


{-| Shared state message
-}
type SharedMsg
    = Event String
    | SelectColorScheme Int ColorSchemeType


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


{-| -}
type alias Explorer shared sharedMsg current previous currentMsg previousMsg =
    { app : Spa.Builder Route () shared sharedMsg (Page (Spa.PageStack.Msg Route currentMsg previousMsg)) current previous currentMsg previousMsg
    , categories : List ( String, List String )
    , initialShared : Shared
    }


{-| creates an empty Explorer
-}
explorer : Explorer shared sharedMsg () () () ()
explorer =
    { app =
        Spa.init
            { defaultView = defaultView
            , extractIdentity = always Nothing
            }
    , categories = []
    , initialShared =
        { lastEvents = []
        , theme = Theme.defaultTheme
        , colorSchemeList = [ ( Color.defaultLightScheme, Color.defaultDarkScheme ) ]
        , selectedColorScheme =
            ( 0, Light )
        }
    }


{-| set the theme
-}
setTheme :
    Theme.Theme
    -> Explorer shared sharedMsg c p cm pm
    -> Explorer shared sharedMsg c p cm pm
setTheme theme expl =
    let
        shared =
            expl.initialShared
    in
    { expl
        | initialShared = { shared | theme = theme }
    }


{-| setColorScheme
-}
setColorScheme :
    Color.Scheme
    -> Color.Scheme
    -> Explorer shared sharedMsg c p cm pm
    -> Explorer shared sharedMsg c p cm pm
setColorScheme light dark expl =
    let
        shared =
            expl.initialShared
    in
    { expl
        | initialShared = { shared | colorSchemeList = [ ( light, dark ) ] }
    }


{-| Add a category to a Explorer

All subsequent books will be added to this category, until a new category is
added.

-}
category :
    String
    -> Explorer shared sharedMsg current previous currentMsg previousMsg
    -> Explorer shared sharedMsg current previous currentMsg previousMsg
category name expl =
    { expl
        | categories = ( name, [] ) :: expl.categories
    }


{-| Add a book to the current category
-}
addBook :
    Book model msg
    -> Explorer Shared SharedMsg current previous currentMsg previousMsg
    -> Explorer Shared SharedMsg model (Spa.PageStack.Model Spa.SetupError current previous) (BookMsg msg) (Spa.PageStack.Msg Route currentMsg previousMsg)
addBook b expl =
    let
        cat =
            expl.categories
                |> List.head
                |> Maybe.map Tuple.first
                |> Maybe.withDefault ""
    in
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
                                    SharedMsg sharedMsg ->
                                        ( model, Effect.fromShared sharedMsg )

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
                                        |> Element.column [ Element.spacing 20 ]
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
type alias Book model msg =
    { title : String
    , init : Shared -> ( model, Effect SharedMsg msg )
    , update : Shared -> msg -> model -> ( model, Effect SharedMsg msg )
    , subscriptions : Shared -> model -> Sub msg
    , chapters : List (Shared -> model -> Element (BookMsg msg))
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


{-| wrap a book msg into a `BookMsg msg`. This is needed in views.
-}
bookMsg : msg -> BookMsg msg
bookMsg =
    BookMsg


{-| Creates a new static book
-}
book : String -> Book () ()
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
        { init : Shared -> ( model, Effect SharedMsg msg )
        , update : Shared -> msg -> model -> ( model, Effect SharedMsg msg )
        , subscriptions : Shared -> model -> Sub msg
        }
    -> Book model msg
statefulBook title { init, update, subscriptions } =
    { title = title
    , init = init
    , update = update
    , subscriptions = subscriptions
    , chapters = []
    }


{-| Add a mardown chapter to a book
-}
withMarkdownChapter : String -> Book model msg -> Book model msg
withMarkdownChapter markdown b =
    { b
        | chapters =
            (\_ _ ->
                case
                    Markdown.Parser.parse markdown
                        |> Result.mapError (List.map Markdown.Parser.deadEndToString >> String.join ", ")
                        |> Result.andThen
                            (Markdown.Renderer.render Markdown.Renderer.defaultHtmlRenderer)
                of
                    Ok value ->
                        value
                            |> List.map Element.html
                            |> Element.column []

                    Err err ->
                        Element.text <| "Error rendering markdown: " ++ err
            )
                :: b.chapters
    }


{-| Add a static content chapter to a book
-}
withStaticChapter : (Shared -> Element (BookMsg msg)) -> Book model msg -> Book model msg
withStaticChapter body b =
    { b
        | chapters = (\shared _ -> body shared) :: b.chapters
    }


{-| Add a chapter to a book
-}
withChapter : (Shared -> model -> Element (BookMsg msg)) -> Book model msg -> Book model msg
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


changeColorScheme : Int -> ColorSchemeType -> Shared -> Shared
changeColorScheme index type_ shared =
    let
        realIndex =
            if index < 0 then
                0

            else if index >= List.length shared.colorSchemeList then
                List.length shared.colorSchemeList - 1

            else
                index

        colorScheme =
            shared.colorSchemeList
                |> (if realIndex > 0 then
                        List.take realIndex

                    else
                        identity
                   )
                |> List.head
                |> Maybe.map
                    (\( light, dark ) ->
                        case type_ of
                            Light ->
                                light

                            Dark ->
                                dark
                    )
                |> Maybe.withDefault Color.defaultLightScheme

        theme =
            shared.theme
    in
    { shared
        | theme =
            { theme
                | colorscheme = colorScheme
            }
        , selectedColorScheme = ( realIndex, type_ )
    }


{-| Finalize a explorer and returns Program
-}
finalize :
    Explorer Shared SharedMsg current previous currentMsg previousMsg
    -> Spa.Application Json.Decode.Value Shared SharedMsg String current previous currentMsg previousMsg
finalize expl =
    let
        categories =
            expl.categories
                |> List.map (Tuple.mapSecond List.reverse)
                |> List.reverse
    in
    Spa.application mapView
        { toRoute = \url -> url.fragment |> Maybe.withDefault "/"
        , init =
            \flags _ ->
                let
                    dFlags =
                        Json.Decode.decodeValue decodeFlags flags
                            |> Result.withDefault { dark_mode = False }
                in
                ( expl.initialShared
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
                                    |> List.take 10
                          }
                        , Cmd.none
                        )

                    SelectColorScheme index type_ ->
                        ( changeColorScheme index type_ shared
                        , Cmd.none
                        )
        , subscriptions = \_ -> Sub.none
        , protectPage = \_ -> "/"
        , toDocument =
            \shared b ->
                { title = b.title
                , body =
                    [ Element.column
                        [ Element.height Element.fill
                        , Element.width Element.fill
                        ]
                        [ Element.el
                            [ Element.padding 15
                            , Element.width Element.fill
                            ]
                          <|
                            Element.text "Orus UI Explorer"
                        , Element.row
                            [ Element.height Element.fill
                            , Element.width Element.fill
                            ]
                            [ Element.row
                                [ Element.width Element.fill
                                ]
                                [ Element.text "Light/Dark"
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
                                :: (categories
                                        |> List.concatMap
                                            (\( cat, books ) ->
                                                Element.text cat
                                                    :: List.map
                                                        (\name ->
                                                            Element.link
                                                                [ Element.padding 10
                                                                , Element.width Element.fill
                                                                ]
                                                                { url = "#" ++ bookPath cat name
                                                                , label = Element.text name
                                                                }
                                                        )
                                                        books
                                            )
                                   )
                                |> Element.column
                                    [ Element.padding 10
                                    , Element.alignTop
                                    , Element.width <| Element.px 200
                                    , Element.height Element.fill
                                    ]
                            , Element.column
                                [ Element.width Element.fill
                                , Element.height Element.fill
                                ]
                                [ b.content
                                    |> Element.el
                                        [ Element.scrollbarY
                                        , Element.height Element.fill
                                        , Element.width Element.fill
                                        ]
                                , Element.column
                                    [ Element.height <| Element.px 200
                                    , Element.width Element.fill
                                    , Background.color <| Color.toElementColor shared.theme.colorscheme.surfaceContainerLow
                                    ]
                                  <|
                                    List.map Element.text shared.lastEvents
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
                            , Background.color <| Color.toElementColor shared.theme.colorscheme.surface
                            , Font.color <| Color.toElementColor shared.theme.colorscheme.onSurface
                            , Element.scrollbarY
                            ]
                    ]
                }
        }
        expl.app
