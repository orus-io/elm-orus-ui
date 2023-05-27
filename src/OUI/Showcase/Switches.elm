module OUI.Showcase.Switches exposing (Model, Msg, book)

import Dict exposing (Dict)
import Effect
import Element exposing (Element)
import OUI
import OUI.Explorer as Explorer
import OUI.Icon exposing (check, clear)
import OUI.Material as Material
import OUI.Switch as Switch


book : Explorer.Book Model Msg
book =
    Explorer.statefulBook "Switch"
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


onChange : String -> Bool -> Explorer.BookMsg Msg
onChange name selected =
    Explorer.logEvent <|
        name
            ++ " changes to "
            ++ (if selected then
                    "'selected'"

                else
                    "'unselected'"
               )


checkbox : Explorer.Shared -> Model -> Element (Explorer.BookMsg Msg)
checkbox { theme } { switches } =
    Element.column [ Element.spacing 30, Element.width <| Element.px 300 ]
        [ Element.text "Switches"
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Element.text "Primary color"
            , Switch.new (Dict.get "primary" switches |> Maybe.withDefault True)
                |> Switch.onChange (Explorer.bookMsg << SetSwitch "primary")
                |> Material.switch theme [ Element.alignRight ]
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Element.text "Disabled"
            , Switch.new (Dict.get "primary" switches |> Maybe.withDefault True)
                |> Material.switch theme [ Element.alignRight ]
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Element.text "With icons"
            , Switch.new (Dict.get "icons" switches |> Maybe.withDefault True)
                |> Switch.onChange (Explorer.bookMsg << SetSwitch "icons")
                |> Switch.withIconUnselected clear
                |> Switch.withIconSelected check
                |> Material.switch theme [ Element.alignRight ]
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Element.text "Secondary color"
            , Switch.new (Dict.get "secondary" switches |> Maybe.withDefault True)
                |> Switch.withColor OUI.Secondary
                |> Switch.onChange (Explorer.bookMsg << SetSwitch "secondary")
                |> Material.switch theme [ Element.alignRight ]
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Element.text "Error color"
            , Switch.new (Dict.get "error" switches |> Maybe.withDefault True)
                |> Switch.onChange (Explorer.bookMsg << SetSwitch "error")
                |> Switch.withColor OUI.Error
                |> Material.switch theme [ Element.alignRight ]
            ]
        ]
