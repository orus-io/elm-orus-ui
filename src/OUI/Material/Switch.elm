module OUI.Material.Switch exposing (Theme, defaultTheme, render)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Html.Attributes
import OUI.Material.Color as Color
import OUI.Material.Icon as Icon
import OUI.Switch as Switch exposing (Switch)
import OUI.Utils.ARIA as ARIA


type alias Theme =
    { track :
        { height : Int
        , width : Int
        , outlineWidth : Int
        , corner : Int
        }
    , thumb :
        { size :
            { unselected : Int
            , withIcon : Int
            , selected : Int
            , pressed : Int
            }
        }
    , stateLayer :
        { size : Int
        }
    , icon :
        { sizeUnselected : Int
        , sizeSelected : Int
        }
    }


defaultTheme : Theme
defaultTheme =
    { track =
        { height = 32
        , width = 52
        , outlineWidth = 2
        , corner = 16
        }
    , thumb =
        { size =
            { unselected = 16
            , withIcon = 24
            , selected = 24
            , pressed = 28
            }
        }
    , stateLayer =
        { size = 40
        }
    , icon =
        { sizeUnselected = 16
        , sizeSelected = 16
        }
    }


render : Color.Scheme -> Theme -> List (Attribute msg) -> Switch msg -> Element msg
render colorscheme theme attrs switch =
    let
        { onChange, selected, color, iconSelected, iconUnselected } =
            Switch.properties switch

        aria =
            ARIA.roleSwitch selected
                |> ARIA.toElementAttributes

        { bgColor, outlineColor, thumbColor, iconColor } =
            case ( onChange /= Nothing, selected ) of
                ( True, True ) ->
                    { bgColor = Color.getElementColor color colorscheme
                    , outlineColor = Color.getElementColor color colorscheme
                    , thumbColor = Color.getOnElementColor color colorscheme
                    , iconColor = Color.getOnContainerColor color colorscheme
                    }

                ( True, False ) ->
                    { bgColor = Color.toElementColor colorscheme.surfaceContainerHighest
                    , outlineColor =
                        if Color.isError color then
                            Color.getElementColor color colorscheme

                        else
                            Color.toElementColor colorscheme.outline
                    , thumbColor = Color.toElementColor colorscheme.outline
                    , iconColor = colorscheme.surfaceContainerHighest
                    }

                ( False, True ) ->
                    { bgColor =
                        colorscheme.surface
                            |> Color.withShade colorscheme.onSurface 0.12
                            |> Color.toElementColor
                    , outlineColor =
                        colorscheme.surface
                            |> Color.withShade colorscheme.onSurface 0.12
                            |> Color.toElementColor
                    , thumbColor =
                        colorscheme.surface
                            |> Color.toElementColor
                    , iconColor =
                        colorscheme.surface
                            |> Color.withShade colorscheme.onSurface 0.38
                    }

                ( False, False ) ->
                    { bgColor =
                        colorscheme.surface
                            |> Color.withShade colorscheme.surfaceContainerHighest 0.12
                            |> Color.toElementColor
                    , outlineColor =
                        colorscheme.surface
                            |> Color.withShade colorscheme.onSurface 0.12
                            |> Color.toElementColor
                    , thumbColor =
                        colorscheme.surface
                            |> Color.withShade colorscheme.onSurface 0.38
                            |> Color.toElementColor
                    , iconColor =
                        colorscheme.surface
                            |> Color.withShade colorscheme.surfaceContainerHighest 0.38
                    }

        trackAttrs =
            [ Element.width <| Element.px theme.track.width
            , Element.height <| Element.px theme.track.height
            , Border.width theme.track.outlineWidth
            , Border.rounded theme.track.corner
            , Border.color outlineColor
            , Background.color bgColor
            ]

        withIcon =
            selected && iconSelected /= Nothing || not selected && iconUnselected /= Nothing

        icon =
            (if selected then
                iconSelected

             else
                iconUnselected
            )
                |> Maybe.map
                    (Icon.renderWithSizeColor
                        (if selected then
                            theme.icon.sizeSelected

                         else
                            theme.icon.sizeUnselected
                        )
                        iconColor
                        [ Element.centerX
                        , Element.centerY
                        ]
                    )
                |> Maybe.withDefault Element.none

        thumbSize =
            theme.thumb.size
                |> (if withIcon then
                        .withIcon

                    else if selected then
                        .selected

                    else
                        .unselected
                   )

        thumbAttrs =
            [ Element.height <| Element.px theme.thumb.size.pressed
            , Element.width <| Element.px theme.thumb.size.pressed
            , Background.color thumbColor
            , Border.rounded <| theme.thumb.size.pressed // 2
            , Border.color bgColor
            , Border.width <| (theme.thumb.size.pressed - thumbSize) // 2
            , Element.alignLeft
            , if selected then
                Element.moveRight <| toFloat (theme.track.width - theme.thumb.size.pressed - theme.track.outlineWidth * 2)

              else
                Element.moveRight 0
            , Element.mouseDown
                [ Border.color thumbColor
                ]
            , Element.inFront
                (Element.el
                    [ Element.centerX
                    , Element.moveUp <| toFloat ((theme.stateLayer.size - thumbSize) // 2)
                    , Element.height <| Element.px theme.stateLayer.size
                    , Element.width <| Element.px theme.stateLayer.size
                    , Border.rounded <| theme.stateLayer.size // 2
                    , Element.mouseOver
                        [ colorscheme.onSurface
                            |> Color.setAlpha Color.hoverStateLayerOpacity
                            |> Color.toElementColor
                            |> Background.color
                        ]
                    , Element.focused
                        [ colorscheme.onSurface
                            |> Color.setAlpha Color.focusStateLayerOpacity
                            |> Color.toElementColor
                            |> Background.color
                        ]
                    , Element.mouseDown
                        [ colorscheme.onSurface
                            |> Color.setAlpha Color.pressStateLayerOpacity
                            |> Color.toElementColor
                            |> Background.color
                        ]
                    ]
                    Element.none
                )
            , Element.htmlAttribute
                (Html.Attributes.style "transition" "all 0.3s ease-out")
            ]
    in
    Input.button (aria ++ trackAttrs ++ attrs)
        { onPress = onChange |> Maybe.map (\msg -> msg <| not selected)
        , label =
            Element.el thumbAttrs icon
        }
