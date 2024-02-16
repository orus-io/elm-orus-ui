module OUI.Showcase.Tabs exposing (Model, Msg, book)

import Effect exposing (Effect)
import Element exposing (Element)
import OUI.Badge as Badge exposing (Badge)
import OUI.Explorer as Explorer exposing (withChapter)
import OUI.Icon as Icon exposing (Icon)
import OUI.Material
import OUI.Tabs


type alias Entry =
    { label : String
    , icon : Maybe Icon
    , badge : Maybe Badge
    }


entries : List ( Int, Entry )
entries =
    [ ( 0, { label = "Hi", icon = Just Icon.clear, badge = Just <| Badge.number 5 } )
    , ( 1, { label = "There", icon = Just Icon.light_mode, badge = Nothing } )
    , ( 2, { label = "Youpi", icon = Nothing, badge = Just Badge.small } )
    , ( 3, { label = "Trala", icon = Just Icon.dark_mode, badge = Just <| Badge.label "la" } )
    ]


type alias Model =
    { selected : Int
    }


type Msg
    = OnClick Int


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Tabs"
        { init = \_ -> { selected = 0 } |> Effect.withNone
        , update = update
        , subscriptions = \_ _ -> Sub.none
        }
        |> withChapter tabs


tabs : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
tabs { theme } model =
    let
        base : OUI.Tabs.Tabs Int Entry Msg
        base =
            OUI.Tabs.new .label OnClick
                |> OUI.Tabs.withItems entries
                |> OUI.Tabs.withIcon .icon
                |> OUI.Tabs.withBadge .badge
                |> OUI.Tabs.withSelected model.selected
    in
    Element.column [ Element.spacing 50, Element.padding 50 ]
        [ base
            |> OUI.Material.tabs theme [ Element.width <| Element.px 500 ]
        , base
            |> OUI.Tabs.secondary
            |> OUI.Material.tabs theme [ Element.width <| Element.px 500 ]
        ]
        |> Element.map Explorer.bookMsg


update : Explorer.Shared themeExt -> Msg -> Model -> ( Model, Effect shared msg )
update _ msg model =
    case msg of
        OnClick key ->
            { model | selected = key }
                |> Effect.withNone
