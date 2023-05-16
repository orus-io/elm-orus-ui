module OUI.Material.Button exposing (..)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import OUI
import OUI.Button exposing (Button, getProperties)
import OUI.Material.Color
import OUI.Material.Typography
import OUI.Text


defaultLayout : Layout
defaultLayout =
    { containerHeight = 40
    , containerRadius = 20
    , iconSize = 18
    , leftRightPadding = 24
    , leftPaddingWithIcon = 16
    , rightPaddingWithIcon = 16
    , paddingBetweenElements = 8

    --, labelTextAlignment =
    }


type alias Layout =
    { containerHeight : Int
    , containerRadius : Int
    , iconSize : Int
    , leftRightPadding : Int
    , leftPaddingWithIcon : Int
    , rightPaddingWithIcon : Int
    , paddingBetweenElements : Int

    -- Label text alignment Center-aligned
    }


elevatedAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
elevatedAttrs typescale colorScheme layout color =
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Border.shadow
                { offset = ( 1, 1 )
                , size = 1
                , blur = 1
                , color = OUI.Material.Color.toElementColor colorScheme.shadow
                }
           , Background.color <| OUI.Material.Color.toElementColor colorScheme.surfaceContainerLow
           , Font.color <| OUI.Material.Color.getElementColor color colorScheme
           , Element.focused
                [ colorScheme.surfaceContainerLow
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.focusStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           , Element.mouseDown
                [ colorScheme.surfaceContainerLow
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.pressStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           , Element.mouseOver
                [ colorScheme.surfaceContainerLow
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.hoverStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           ]


elevatedDisabledAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> List (Attribute msg)
elevatedDisabledAttrs typescale colorScheme layout =
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Border.shadow
                { offset = ( 1, 1 )
                , size = 0
                , blur = 1
                , color = OUI.Material.Color.toElementColor colorScheme.shadow
                }
           , Background.color <|
                OUI.Material.Color.toElementColor <|
                    OUI.Material.Color.setAlpha 0.12 colorScheme.onSurface
           , Font.color <|
                OUI.Material.Color.toElementColor <|
                    OUI.Material.Color.setAlpha 0.38 colorScheme.onSurface
           , Element.focused
                [ Background.color <|
                    OUI.Material.Color.toElementColor <|
                        OUI.Material.Color.setAlpha
                            (0.12 + OUI.Material.Color.hoverStateLayerOpacity)
                            colorScheme.onSurface
                ]
           ]


filledAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
filledAttrs typescale colorScheme layout color =
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Background.color <| OUI.Material.Color.getElementColor color colorScheme
           , Font.color <| OUI.Material.Color.getOnElementColor color colorScheme
           , Element.focused
                [ OUI.Material.Color.getColor color colorScheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getOnColor color colorScheme)
                        OUI.Material.Color.focusStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           , Element.mouseDown
                [ OUI.Material.Color.getColor color colorScheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getOnColor color colorScheme)
                        OUI.Material.Color.pressStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           , Element.mouseOver
                [ OUI.Material.Color.getColor color colorScheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getOnColor color colorScheme)
                        OUI.Material.Color.hoverStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           ]


filledDisabledAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> List (Attribute msg)
filledDisabledAttrs typescale colorScheme layout =
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Background.color <|
                OUI.Material.Color.toElementColor <|
                    OUI.Material.Color.setAlpha 0.12 colorScheme.onSurface
           , Font.color <|
                OUI.Material.Color.toElementColor <|
                    OUI.Material.Color.setAlpha 0.38 colorScheme.onSurface
           , Element.focused
                [ Background.color <|
                    OUI.Material.Color.toElementColor <|
                        OUI.Material.Color.setAlpha
                            (0.12 + OUI.Material.Color.hoverStateLayerOpacity)
                            colorScheme.onSurface
                ]
           ]


outlinedAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
outlinedAttrs typescale colorScheme layout color =
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Border.width 1
           , Border.color <| OUI.Material.Color.toElementColor colorScheme.outline
           , Font.color <| OUI.Material.Color.getElementColor color colorScheme
           , Element.focused
                [ colorScheme.surface
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.focusStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           , Element.mouseDown
                [ colorScheme.surface
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.pressStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           , Element.mouseOver
                [ colorScheme.surface
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.hoverStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           ]


outlinedDisabledAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> List (Attribute msg)
outlinedDisabledAttrs typescale colorScheme layout =
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Border.width 1
           , Border.color <|
                OUI.Material.Color.toElementColor <|
                    OUI.Material.Color.setAlpha 0.12 colorScheme.onSurface
           , Font.color <|
                OUI.Material.Color.toElementColor <|
                    OUI.Material.Color.setAlpha 0.38 colorScheme.onSurface
           , Element.focused
                [ Background.color <|
                    OUI.Material.Color.toElementColor <|
                        OUI.Material.Color.setAlpha
                            OUI.Material.Color.hoverStateLayerOpacity
                            colorScheme.onSurface
                ]
           ]


textAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
textAttrs typescale colorScheme layout color =
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Font.color <| OUI.Material.Color.getElementColor color colorScheme
           , Element.focused
                [ colorScheme.surface
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.focusStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           , Element.mouseDown
                [ colorScheme.surface
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.pressStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           , Element.mouseOver
                [ colorScheme.surface
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorScheme)
                        OUI.Material.Color.hoverStateLayerOpacity
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
                ]
           ]


textDisabledAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> List (Attribute msg)
textDisabledAttrs typescale colorScheme layout =
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Font.color <|
                OUI.Material.Color.toElementColor <|
                    OUI.Material.Color.setAlpha 0.38 colorScheme.onSurface
           , Element.focused
                [ Background.color <|
                    OUI.Material.Color.toElementColor <|
                        OUI.Material.Color.setAlpha
                            OUI.Material.Color.hoverStateLayerOpacity
                            colorScheme.onSurface
                ]
           ]


render :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> List (Attribute msg)
    -> Button { constraints | hasText : (), hasAction : () } msg
    -> Element msg
render typescale colorscheme layout attrs button =
    let
        props =
            getProperties button

        padding =
            case props.icon of
                Nothing ->
                    Element.paddingXY layout.leftRightPadding 0

                Just _ ->
                    Element.paddingEach
                        { top = 0
                        , bottom = 0
                        , left = layout.leftPaddingWithIcon
                        , right = layout.rightPaddingWithIcon
                        }

        label =
            case props.icon of
                Nothing ->
                    Element.text props.text

                Just icon ->
                    Element.row [ Element.spacing layout.paddingBetweenElements ]
                        [ Element.text icon, Element.text props.text ]
    in
    Input.button
        ((Element.height <| Element.px layout.containerHeight)
            :: padding
            :: attrs
            ++ (case ( props.type_, props.onClick ) of
                    ( OUI.Button.Elevated, Just _ ) ->
                        elevatedAttrs typescale colorscheme layout props.color

                    ( OUI.Button.Elevated, Nothing ) ->
                        elevatedDisabledAttrs typescale colorscheme layout

                    ( OUI.Button.Filled, Just _ ) ->
                        filledAttrs typescale colorscheme layout props.color

                    ( OUI.Button.Filled, Nothing ) ->
                        filledDisabledAttrs typescale colorscheme layout

                    ( OUI.Button.Tonal, Just _ ) ->
                        filledAttrs typescale colorscheme layout props.color

                    ( OUI.Button.Tonal, Nothing ) ->
                        filledDisabledAttrs typescale colorscheme layout

                    ( OUI.Button.Outlined, Just _ ) ->
                        outlinedAttrs typescale colorscheme layout props.color

                    ( OUI.Button.Outlined, Nothing ) ->
                        outlinedDisabledAttrs typescale colorscheme layout

                    ( OUI.Button.Text, Just _ ) ->
                        textAttrs typescale colorscheme layout props.color

                    ( OUI.Button.Text, Nothing ) ->
                        textDisabledAttrs typescale colorscheme layout

                    _ ->
                        textDisabledAttrs typescale colorscheme layout
               )
        )
        { label = label
        , onPress = props.onClick
        }
