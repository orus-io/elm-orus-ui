module OUI.Showcase.Icons exposing (book, withChapter)

import Effect exposing (Effect)
import Element exposing (Element)
import List.Extra as List
import OUI.Explorer as Explorer
import OUI.Icon as Icon exposing (Icon)
import OUI.Material as Material
import OUI.Text as Text
import OUI.TextField as TextField


withChapter : String -> List ( String, Icon ) -> Explorer.Book Model Msg -> Explorer.Book Model Msg
withChapter title iconList =
    Explorer.withChapter <| iconChapter title iconList


capitalize : String -> String
capitalize =
    String.split "_"
        >> List.map
            (\s ->
                String.toUpper (String.left 1 s)
                    ++ String.dropLeft 1 s
            )
        >> String.join " "


iconChapter : String -> List ( String, Icon ) -> Explorer.Shared -> Model -> Element msg
iconChapter title iconList shared model =
    Element.column [ Element.spacing 20, Element.paddingXY 20 0, Element.width <| Element.maximum 1200 <| Element.fill ] <|
        [ Text.titleLarge title
            |> Material.text shared.theme
        , iconList
            |> List.filter (\( label, _ ) -> String.contains model.filter label)
            |> List.map
                (\( label, icon ) ->
                    Element.column
                        [ Element.spacing 25
                        , Element.width <| Element.px 128
                        , Element.height <| Element.px 128
                        ]
                        [ Material.icon shared.theme
                            [ Element.centerX
                            , Element.centerY
                            ]
                          <|
                            Icon.withSize 40 icon
                        , Element.el
                            [ Element.centerX
                            , Element.centerY
                            ]
                          <|
                            Material.text shared.theme <|
                                Text.bodySmall <|
                                    capitalize label
                        ]
                )
            |> Element.wrappedRow [ Element.centerX ]
        ]


filterChapter : Explorer.Shared -> Model -> Element (Explorer.BookMsg Msg)
filterChapter shared model =
    TextField.new "Search icon" (Explorer.bookMsg << FilterChange) model.filter
        |> TextField.onFocusBlur (Explorer.bookMsg <| FilterFocus True) (Explorer.bookMsg <| FilterFocus False)
        |> TextField.withFocused model.filterFocused
        |> Material.textField shared.theme [ Element.width Element.fill ]
        |> Element.el [ Element.padding 20, Element.width Element.fill ]


book : String -> Explorer.Book Model Msg
book title =
    Explorer.statefulBook
        title
        { init = init
        , update = update
        , subscriptions = \_ _ -> Sub.none
        }
        |> Explorer.withChapter filterChapter


type alias Model =
    { filter : String
    , filterFocused : Bool
    }


type Msg
    = FilterChange String
    | FilterFocus Bool


init : Explorer.Shared -> ( Model, Effect Explorer.SharedMsg Msg )
init _ =
    { filter = ""
    , filterFocused = False
    }
        |> Effect.withNone


update : Explorer.Shared -> Msg -> Model -> ( Model, Effect Explorer.SharedMsg Msg )
update _ msg model =
    case msg of
        FilterFocus focused ->
            { model | filterFocused = focused }
                |> Effect.withNone

        FilterChange filter ->
            { model | filter = filter }
                |> Effect.withNone
