module OUI.Material.Checkbox exposing (Theme, defaultTheme, render)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import OUI
import OUI.Checkbox
import OUI.Material.Color exposing (toElementColor)
import OUI.Material.Icon as Icon
import OUI.Utils.ARIA as ARIA


type alias Theme =
    { containerWidth : Int
    , containerHeight : Int
    , containerShape : Int
    , iconSize : Int
    , stateLayerSize : Int

    -- , iconAlignment = Center-aligned
    -- , targetSize = 48
    }


defaultTheme : Theme
defaultTheme =
    { containerWidth = 18
    , containerHeight = 18
    , containerShape = 2
    , iconSize = 18
    , stateLayerSize = 40

    -- , iconAlignment = Center-aligned
    -- , targetSize = 48
    }


render :
    OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> OUI.Checkbox.Checkbox { hasAction : (), withChecked : () } msg
    -> Element msg
render colorscheme theme attrs checkbox =
    let
        properties =
            OUI.Checkbox.properties checkbox

        aria =
            ARIA.roleCheckbox properties.checked
                |> ARIA.toElementAttributes

        ( frontColor, backColor, borderColor ) =
            case ( properties.onChange, properties.color ) of
                ( Just _, OUI.Error ) ->
                    ( OUI.Material.Color.getOnColor properties.color colorscheme
                    , OUI.Material.Color.getColor properties.color colorscheme
                    , colorscheme.error
                    )

                ( Just _, _ ) ->
                    ( OUI.Material.Color.getOnColor properties.color colorscheme
                    , OUI.Material.Color.getColor properties.color colorscheme
                    , colorscheme.onSurface
                    )

                ( Nothing, _ ) ->
                    ( colorscheme.surface
                    , colorscheme.onSurface
                        |> OUI.Material.Color.setAlpha 0.38
                    , colorscheme.onSurface
                        |> OUI.Material.Color.setAlpha 0.38
                    )
    in
    Input.button
        (aria
            ++ [ Element.width <| Element.px theme.stateLayerSize
               , Element.height <| Element.px theme.stateLayerSize
               , Border.rounded <| theme.stateLayerSize // 2
               , Element.focused
                    [ colorscheme.onSurface
                        |> OUI.Material.Color.setAlpha OUI.Material.Color.focusStateLayerOpacity
                        |> OUI.Material.Color.toElementColor
                        |> Background.color
                    ]
               , Element.mouseDown
                    [ colorscheme.onSurface
                        |> OUI.Material.Color.setAlpha OUI.Material.Color.pressStateLayerOpacity
                        |> OUI.Material.Color.toElementColor
                        |> Background.color
                    ]
               , Element.mouseOver
                    [ colorscheme.onSurface
                        |> OUI.Material.Color.setAlpha OUI.Material.Color.hoverStateLayerOpacity
                        |> OUI.Material.Color.toElementColor
                        |> Background.color
                    ]
               ]
        )
        { onPress = properties.onChange |> Maybe.map (\msg -> msg <| not properties.checked)
        , label =
            Element.el
                [ Element.width <| Element.px theme.containerWidth
                , Element.height <| Element.px theme.containerHeight
                , Element.centerX
                , Element.centerY
                ]
            <|
                if properties.checked then
                    Icon.renderWithSizeColor theme.iconSize
                        frontColor
                        [ Background.color <| toElementColor backColor
                        , Border.rounded theme.containerShape
                        ]
                        properties.icon

                else
                    Element.el
                        [ Element.width <| Element.px theme.iconSize
                        , Element.height <| Element.px theme.iconSize
                        , Border.width 2
                        , Border.rounded theme.containerShape
                        , Border.color <| toElementColor borderColor
                        ]
                        Element.none
        }
