module OUI.Explorer exposing
    ( BookMsg, Page, Route, Shared, SharedMsg, Explorer
    , addBook, book, category, event, explorer, finalize
    , withMarkdownChapter, withStaticChapter
    )

{-|

@docs BookMsg, Page, Route, Shared, SharedMsg, Explorer
@docs addBook, book, category, event, explorer, finalize
@docs withMarkdownChapter, withStaticChapter

-}

import Browser
import Effect
import Element exposing (Element)
import Element.Background as Background
import Markdown.Parser
import Markdown.Renderer
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


{-| The shared state
-}
type alias Shared =
    { lastEvents : List String }


{-| Shared state message
-}
type SharedMsg
    = Event String


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
        catPrefix =
            case expl.categories of
                [] ->
                    "/"

                ( cat, _ ) :: _ ->
                    "/" ++ cat ++ "/"
    in
    { app =
        expl.app
            |> Spa.addPublicPage ( mapView, mapView )
                (\route ->
                    if route == catPrefix ++ b.title then
                        Just route

                    else
                        Nothing
                )
                (\_ ->
                    Spa.Page.element
                        { init = \_ -> ( (), Effect.none )
                        , update = \(SharedMsg msg) () -> ( (), Effect.fromShared msg )
                        , view =
                            \_ ->
                                { title = b.title
                                , content =
                                    b.chapters
                                        |> List.reverse
                                        |> Element.column [ Element.spacing 20 ]
                                }
                        , subscriptions = \_ -> Sub.none
                        }
                )
    , categories =
        case expl.categories of
            ( cat, pages ) :: tail ->
                ( cat, b.title :: pages ) :: tail

            [] ->
                [ ( "", [ b.title ] ) ]
    }


{-| A stateless book
-}
type alias Book msg =
    { title : String
    , chapters : List (Element msg)
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
            (case
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
withStaticChapter : Element msg -> Book msg -> Book msg
withStaticChapter body b =
    { b
        | chapters = body :: b.chapters
    }


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
        { toRoute = \url -> url.path
        , init = \() _ -> ( { lastEvents = [] }, Cmd.none )
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
                            [ categories
                                |> List.concatMap
                                    (\( cat, books ) ->
                                        Element.text cat
                                            :: List.map
                                                (\name ->
                                                    Element.link
                                                        [ Element.padding 10
                                                        , Element.width Element.fill
                                                        ]
                                                        { url =
                                                            case cat of
                                                                "" ->
                                                                    "/" ++ name

                                                                s ->
                                                                    "/" ++ s ++ "/" ++ name
                                                        , label = Element.text name
                                                        }
                                                )
                                                books
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
                                    , Background.color <| Element.rgb255 200 200 200
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
                            , Background.color <| Element.rgb255 255 255 255
                            , Element.scrollbarY
                            ]
                    ]
                }
        }
        expl.app
        |> Browser.application
