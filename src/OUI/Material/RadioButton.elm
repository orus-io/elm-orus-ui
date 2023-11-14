module OUI.Material.RadioButton exposing (Theme, defaultTheme, render)

import Color
import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import OUI
import OUI.Material.Color exposing (toElementColor)
import OUI.RadioButton
import OUI.Utils.ARIA as ARIA


type alias Theme =
    { containerWidth : Int
    , containerHeight : Int
    , containerShape : Int
    , contentSize : Int
    , stateLayerSize : Int
    , borderWidth : Int

    -- , iconAlignment = Center-aligned
    -- , targetSize = 48
    }


defaultTheme : Theme
defaultTheme =
    { containerWidth = 20
    , containerHeight = 20
    , containerShape = 10
    , contentSize = 10
    , stateLayerSize = 40
    , borderWidth = 2

    -- , iconAlignment = Center-aligned
    -- , targetSize = 48
    }


render :
    OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> OUI.RadioButton.RadioButton { hasAction : (), withSelected : () } msg
    -> Element msg
render colorscheme theme attrs radiobutton =
    let
        properties :
            { selected : Bool
            , onChange : Maybe (Bool -> msg)
            , color : OUI.Color
            }
        properties =
            OUI.RadioButton.properties radiobutton

        aria : List (Attribute msg)
        aria =
            ARIA.roleRadioButton properties.selected
                |> ARIA.toElementAttributes

        isDisabled : Bool
        isDisabled =
            properties.onChange == Nothing

        isError : Bool
        isError =
            properties.color == OUI.Error

        ( focusedAndHoveredColor, pressedColor ) =
            case ( isDisabled, properties.selected ) of
                ( True, _ ) ->
                    ( OUI.Material.Color.getOnSurfaceColor properties.color colorscheme
                    , OUI.Material.Color.getOnSurfaceColor properties.color colorscheme
                    )

                ( False, True ) ->
                    ( OUI.Material.Color.getColor properties.color colorscheme
                    , OUI.Material.Color.getOnSurfaceColor properties.color colorscheme
                    )

                ( False, False ) ->
                    ( OUI.Material.Color.getOnSurfaceColor properties.color colorscheme
                    , OUI.Material.Color.getColor properties.color colorscheme
                    )

        mainColor : Color.Color
        mainColor =
            case ( isDisabled, isError ) of
                ( False, True ) ->
                    OUI.Material.Color.getColor properties.color colorscheme

                ( False, _ ) ->
                    OUI.Material.Color.getColor properties.color colorscheme

                ( True, _ ) ->
                    OUI.Material.Color.getOnSurfaceColor properties.color colorscheme
                        |> OUI.Material.Color.setAlpha 0.38
    in
    Input.button
        (aria
            ++ attrs
            ++ [ Element.width <| Element.px theme.stateLayerSize
               , Element.height <| Element.px theme.stateLayerSize
               , Border.rounded <| theme.stateLayerSize // 2
               , Element.focused
                    [ focusedAndHoveredColor
                        |> OUI.Material.Color.setAlpha OUI.Material.Color.focusStateLayerOpacity
                        |> OUI.Material.Color.toElementColor
                        |> Background.color
                    ]
               , Element.mouseOver
                    [ focusedAndHoveredColor
                        |> OUI.Material.Color.setAlpha OUI.Material.Color.hoverStateLayerOpacity
                        |> OUI.Material.Color.toElementColor
                        |> Background.color
                    ]
               , Element.mouseDown
                    [ pressedColor
                        |> OUI.Material.Color.setAlpha OUI.Material.Color.pressStateLayerOpacity
                        |> OUI.Material.Color.toElementColor
                        |> Background.color
                    ]
               ]
        )
        { onPress = properties.onChange |> Maybe.map (\msg -> msg <| not properties.selected)
        , label =
            Element.el
                [ Element.width <| Element.px theme.containerWidth
                , Element.height <| Element.px theme.containerHeight
                , Element.centerX
                , Element.centerY
                ]
            <|
                if properties.selected then
                    Element.el
                        [ Element.width <| Element.px theme.containerWidth
                        , Element.height <| Element.px theme.containerHeight
                        , Border.width theme.borderWidth
                        , Border.rounded theme.containerShape
                        , Border.color <| toElementColor mainColor
                        ]
                    <|
                        Element.el
                            [ Element.width <| Element.px theme.contentSize
                            , Element.height <| Element.px theme.contentSize
                            , Background.color <| toElementColor mainColor
                            , Border.color <| toElementColor mainColor
                            , Border.rounded theme.containerShape
                            , Element.centerX
                            , Element.centerY
                            ]
                            Element.none

                else
                    Element.el
                        [ Element.width <| Element.px theme.containerWidth
                        , Element.height <| Element.px theme.containerHeight
                        , Border.width theme.borderWidth
                        , Border.rounded theme.containerShape
                        , Border.color <| toElementColor mainColor
                        ]
                    <|
                        Element.none
        }
