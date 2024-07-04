module OUI.Showcase.Switches exposing (Model, Msg, book)

import Dict exposing (Dict)
import Effect
import Element exposing (Element)
import OUI
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Icon exposing (check, clear)
import OUI.Material as Material
import OUI.Switch as Switch
import OUI.Text as Text


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Switches"
        { init =
            \_ ->
                { switches = Dict.empty }
                    |> Effect.withNone
        , update =
            \_ (SetSwitch name selected) model ->
                { model
                    | switches = Dict.insert name selected model.switches
                }
                    |> Effect.withNone
        , subscriptions = \_ _ -> Sub.none
        }
        |> Explorer.withChapter checkbox


type alias Model =
    { switches : Dict String Bool
    }


type Msg
    = SetSwitch String Bool


checkbox : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
checkbox { theme } { switches } =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30, Element.width <| Element.px 300 ]
        [ divider
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleMedium "Primary color" |> Material.text theme
            , Switch.new (Dict.get "primary" switches |> Maybe.withDefault True)
                |> Switch.onChange (Explorer.bookMsg << SetSwitch "primary")
                |> Material.switch theme [ Element.alignRight ]
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleMedium "Disabled" |> Material.text theme
            , Switch.new (Dict.get "primary" switches |> Maybe.withDefault True)
                |> Material.switch theme [ Element.alignRight ]
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleMedium "With icon" |> Material.text theme
            , Switch.new (Dict.get "icons" switches |> Maybe.withDefault True)
                |> Switch.onChange (Explorer.bookMsg << SetSwitch "icons")
                |> Switch.withIconUnselected clear
                |> Switch.withIconSelected check
                |> Material.switch theme [ Element.alignRight ]
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleMedium "Secondary color" |> Material.text theme
            , Switch.new (Dict.get "secondary" switches |> Maybe.withDefault True)
                |> Switch.withColor OUI.Secondary
                |> Switch.onChange (Explorer.bookMsg << SetSwitch "secondary")
                |> Material.switch theme [ Element.alignRight ]
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleMedium "Error color" |> Material.text theme
            , Switch.new (Dict.get "error" switches |> Maybe.withDefault True)
                |> Switch.onChange (Explorer.bookMsg << SetSwitch "error")
                |> Switch.withColor OUI.Error
                |> Material.switch theme [ Element.alignRight ]
            ]
        ]
