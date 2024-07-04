module OUI.Showcase.Slider exposing (Model, Msg, book)

import Dict exposing (Dict)
import Effect
import Element exposing (Element)
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Material as Material
import OUI.Slider as Slider
import OUI.Text as Text


type alias Model =
    { sliders : Dict String Float }


type Msg
    = SetValue String Float


fmtFloat : Float -> String
fmtFloat value =
    value
        * 1000
        |> round
        |> String.fromInt
        |> (\s ->
                String.dropRight 3 s ++ "." ++ String.right 3 s
           )


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Slider"
        { init =
            \_ ->
                { sliders = Dict.empty }
                    |> Effect.withNone
        , update =
            \_ (SetValue name value) model ->
                { model
                    | sliders = Dict.insert name value model.sliders
                }
                    |> Effect.withNone
        , subscriptions = \_ _ -> Sub.none
        }
        |> Explorer.withChapter slider


slider : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
slider { theme } { sliders } =
    let
        add : String -> Slider.Slider (Explorer.BookMsg Msg)
        add name =
            Slider.new (Dict.get name sliders |> Maybe.withDefault 30)
                |> Slider.onChange (Explorer.bookMsg << SetValue name)

        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30 ]
        [ divider
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleSmall "Continuous"
                |> Material.text theme
                |> Element.el [ Element.width (Element.px 100) ]
            , add "continue"
                |> Material.slider theme
                    [ Element.centerY
                    , Element.width <| Element.px 250
                    ]
            , Dict.get "continue" sliders
                |> Maybe.withDefault 30
                |> fmtFloat
                |> Text.bodyLarge
                |> Material.text theme
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleSmall "With steps"
                |> Material.text theme
                |> Element.el [ Element.width (Element.px 100) ]
            , add "steps"
                |> Slider.withStep 1
                |> Material.slider theme
                    [ Element.centerY
                    , Element.width <| Element.px 250
                    ]
            , Dict.get "steps" sliders
                |> Maybe.withDefault 30
                |> String.fromFloat
                |> Text.bodyLarge
                |> Material.text theme
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleSmall "Discrete"
                |> Material.text theme
                |> Element.el [ Element.width (Element.px 100) ]
            , add "discrete"
                |> Slider.withDiscreteStep 10
                |> Material.slider theme
                    [ Element.centerY
                    , Element.width <| Element.px 250
                    ]
            , Dict.get "discrete" sliders
                |> Maybe.withDefault 30
                |> String.fromFloat
                |> Text.bodyLarge
                |> Material.text theme
            ]
        , Element.row [ Element.spacing 30, Element.width Element.fill ]
            [ Text.titleSmall "Read-only"
                |> Material.text theme
                |> Element.el [ Element.width (Element.px 100) ]
            , Slider.new (Dict.get "readonly" sliders |> Maybe.withDefault 30)
                |> Slider.withDiscreteStep 10
                |> Material.slider theme
                    [ Element.centerY
                    , Element.width <| Element.px 250
                    ]
            , Dict.get "readonly" sliders
                |> Maybe.withDefault 30
                |> String.fromFloat
                |> Text.bodyLarge
                |> Material.text theme
            ]
        ]
