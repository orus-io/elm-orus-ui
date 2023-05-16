module OUI.Explorer exposing (..)

import Browser
import Element exposing (Element)
import Markdown.Parser
import Markdown.Renderer
import Spa
import Spa.Page
import Spa.PageStack


type alias Route =
    String


type alias Page msg =
    { title : String
    , content : Element msg
    }


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


type alias Explorer shared sharedMsg current previous currentMsg previousMsg =
    { app : Spa.Builder Route () shared sharedMsg (Page (Spa.PageStack.Msg Route currentMsg previousMsg)) current previous currentMsg previousMsg
    , categories : List ( String, List String )
    }


explorer : Explorer shared sharedMsg () () () ()
explorer =
    { app =
        Spa.init
            { defaultView = defaultView
            , extractIdentity = always Nothing
            }
    , categories = []
    }


category :
    String
    -> Explorer shared sharedMsg current previous currentMsg previousMsg
    -> Explorer shared sharedMsg current previous currentMsg previousMsg
category name expl =
    { expl
        | categories = ( name, [] ) :: expl.categories
    }


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
                    Spa.Page.static
                        { title = b.title
                        , content =
                            b.chapters
                                |> List.reverse
                                |> Element.column [ Element.spacing 20 ]
                        }
                )
    , categories =
        case expl.categories of
            ( cat, pages ) :: tail ->
                ( cat, b.title :: pages ) :: tail

            [] ->
                [ ( "", [ b.title ] ) ]
    }


type alias Book msg =
    { title : String
    , chapters : List (Element msg)
    }


book : String -> Book msg
book title =
    { title = title
    , chapters = []
    }


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


withStaticChapter : Element msg -> Book msg -> Book msg
withStaticChapter body b =
    { b
        | chapters = body :: b.chapters
    }


finalize expl =
    let
        categories =
            expl.categories
                |> List.map (Tuple.mapSecond List.reverse)
                |> List.reverse
    in
    Spa.application mapView
        { toRoute = \url -> url.path
        , init = \() _ -> ( (), Cmd.none )
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        , protectPage = \s -> "/"
        , toDocument =
            \_ b ->
                { title = b.title
                , body =
                    [ Element.column []
                        [ Element.el
                            [ Element.padding 15
                            ]
                          <|
                            Element.text "Orus UI Explorer"
                        , Element.row []
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
                                    ]
                            , b.content
                            ]
                        ]
                        |> Element.layout []
                    ]
                }
        }
        expl.app
        |> Browser.application
