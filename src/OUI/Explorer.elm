module OUI.Explorer exposing
    ( Book, BookMsg, Page, Route, Shared, SharedMsg, Explorer
    , addBook, book, category, event, explorer, finalize
    , withMarkdownChapter, withStaticChapter
    )

{-|

@docs Book, BookMsg, Page, Route, Shared, SharedMsg, Explorer
@docs addBook, book, category, event, explorer, finalize
@docs withMarkdownChapter, withStaticChapter

-}

import Browser
import Effect
import Element exposing (Element)
import Element.Background as Background
import Element.Font as Font
import Markdown.Parser
import Markdown.Renderer
import OUI.Button as Button
import OUI.Material as Material
import OUI.Material.Color as Color
import OUI.Material.Theme as Theme exposing (Theme)
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
    Book BookMsg
    -> Explorer Shared SharedMsg current previous currentMsg previousMsg
    -> Explorer Shared SharedMsg () (Spa.PageStack.Model Spa.SetupError current previous) BookMsg (Spa.PageStack.Msg Route currentMsg previousMsg)
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
                        { init = \_ -> ( (), Effect.none )
                        , update = \(SharedMsg msg) () -> ( (), Effect.fromShared msg )
                        , view =
                            \_ ->
                                { title = b.title
                                , content =
                                    b.chapters
                                        |> List.reverse
                                        |> List.map (\v -> v shared)
                                        |> Element.column [ Element.spacing 20 ]
                                }
                        , subscriptions = \_ -> Sub.none
                        }
                )
    , categories =
        case expl.categories of
            ( cat_, pages ) :: tail ->
                ( cat_, b.title :: pages ) :: tail

            [] ->
                [ ( "", [ b.title ] ) ]
    }


{-| A stateless book
-}
type alias Book msg =
    { title : String
    , chapters : List (Shared -> Element msg)
    }


{-| A stateless book message
-}
type BookMsg
    = SharedMsg SharedMsg


{-| A simple event

The passed string will be logged in the event window

-}
event : String -> BookMsg
event value =
    SharedMsg <| Event value


{-| Creates a new empty book
-}
book : String -> Book msg
book title =
    { title = title
    , chapters = []
    }


{-| Add a mardown chapter to a book
-}
withMarkdownChapter : String -> Book msg -> Book msg
withMarkdownChapter markdown b =
    { b
        | chapters =
            (\_ ->
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
withStaticChapter : (Shared -> Element msg) -> Book msg -> Book msg
withStaticChapter body b =
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


{-| Finalize a explorer and returns Program
-}
finalize :
    Explorer Shared SharedMsg current previous currentMsg previousMsg
    ->
        Platform.Program
            ()
            (Spa.Model String Shared current previous)
            (Spa.Msg SharedMsg (Spa.PageStack.Msg String currentMsg previousMsg))
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
            \() _ ->
                ( { lastEvents = []
                  , theme = Theme.defaultTheme
                  , colorSchemeList = [ ( Color.defaultLightScheme, Color.defaultDarkScheme ) ]
                  , selectedColorScheme = ( 0, Light )
                  }
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
                        ( { shared
                            | theme =
                                { theme
                                    | colorscheme = colorScheme
                                }
                            , selectedColorScheme = ( realIndex, type_ )
                          }
                        , Cmd.none
                        )
        , subscriptions = \_ -> Sub.none
        , protectPage = \s -> "/"
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
                            [ ([ Button.new
                                    |> Button.onClick
                                        (Spa.mapSharedMsg
                                            (SelectColorScheme
                                                (Tuple.first shared.selectedColorScheme)
                                                (Tuple.second shared.selectedColorScheme
                                                    |> invertColorSchemeType
                                                )
                                            )
                                        )
                                    |> Button.withText "Dark/Light"
                                    |> Material.renderButton shared.theme []
                               ]
                                ++ (categories
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
        |> Browser.application
