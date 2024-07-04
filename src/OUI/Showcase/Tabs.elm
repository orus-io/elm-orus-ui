module OUI.Showcase.Tabs exposing (Model, Msg, book)

import Effect exposing (Effect)
import Element exposing (Element)
import OUI.Badge as Badge exposing (Badge)
import OUI.Explorer as Explorer exposing (withChapter)
import OUI.Icon as Icon exposing (Icon)
import OUI.Material as Material
import OUI.Tabs
import OUI.Text as Text


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
    { primarySelected : Int
    , secondarySelected : Int
    }


type Msg
    = OnClickPrimary Int
    | OnClickSecondary Int


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Tabs"
        { init = \_ -> { primarySelected = 0, secondarySelected = 0 } |> Effect.withNone
        , update = update
        , subscriptions = \_ _ -> Sub.none
        }
        |> withChapter tabs


tabs : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
tabs { theme } model =
    let
        primary : OUI.Tabs.Tabs Int Entry Msg
        primary =
            OUI.Tabs.new .label OnClickPrimary
                |> OUI.Tabs.withItems entries
                |> OUI.Tabs.withIcon .icon
                |> OUI.Tabs.withBadge .badge
                |> OUI.Tabs.withSelected model.primarySelected

        secondary : OUI.Tabs.Tabs Int Entry Msg
        secondary =
            OUI.Tabs.new .label OnClickSecondary
                |> OUI.Tabs.withItems entries
                |> OUI.Tabs.withIcon .icon
                |> OUI.Tabs.withBadge .badge
                |> OUI.Tabs.withSelected model.secondarySelected
                |> OUI.Tabs.secondary
    in
    Element.column [ Element.spacing 30, Element.padding 50 ]
        [ Text.titleLarge "Primary tabs" |> Material.text theme
        , primary
            |> Material.tabs theme [ Element.width <| Element.px 500 ]
        , Text.titleLarge "Secondary tabs" |> Material.text theme
        , secondary
            |> Material.tabs theme [ Element.width <| Element.px 500 ]
        ]
        |> Element.map Explorer.bookMsg


update : Explorer.Shared themeExt -> Msg -> Model -> ( Model, Effect shared msg )
update _ msg model =
    case msg of
        OnClickPrimary key ->
            { model | primarySelected = key }
                |> Effect.withNone

        OnClickSecondary key ->
            { model | secondarySelected = key }
                |> Effect.withNone
