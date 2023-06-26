module OUI.Showcase.Icons exposing (book, withChapter)

import Effect exposing (Effect)
import Element exposing (Element)
import List.Extra as List
import OUI.Explorer as Explorer
import OUI.Icon exposing (Icon)
import OUI.Material as Material
import OUI.Material.Theme as Theme
import OUI.Text as Text
import OUI.TextField as TextField


withChapter : String -> List ( String, Icon ) -> Explorer.Book Model Msg -> Explorer.Book Model Msg
withChapter title iconList =
    Explorer.withChapter <| iconChapter title iconList


iconChapter : String -> List ( String, Icon ) -> Explorer.Shared -> Model -> Element msg
iconChapter title iconList shared model =
    Element.column [ Element.spacing 10 ] <|
        (Text.titleLarge title
            |> Material.text shared.theme
        )
            :: (iconList
                    |> List.filter (\( label, _ ) -> String.contains model.filter label)
                    |> List.map
                        (\( label, icon ) ->
                            Element.column [ Element.spacing 10 ]
                                [ Material.icon shared.theme [ Element.centerX ] icon
                                , Element.text label
                                ]
                        )
                    |> List.greedyGroupsOf 10
                    |> List.map
                        (Element.row [ Element.spacing 20 ])
               )


filterChapter : Explorer.Shared -> Model -> Element (Explorer.BookMsg Msg)
filterChapter shared model =
    TextField.new "Search icon" (Explorer.bookMsg << FilterChange) model.filter
        |> TextField.onFocusBlur (Explorer.bookMsg <| FilterFocus True) (Explorer.bookMsg <| FilterFocus False)
        |> TextField.withFocused model.filterFocused
        |> Material.textField shared.theme [ Element.width Element.fill ]


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
