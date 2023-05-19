module OUI.Material.Button exposing (..)

import Color
import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import OUI
import OUI.Button exposing (Button, properties)
import OUI.Material.Color exposing (getOnColor)
import OUI.Material.Icon as Icon
import OUI.Material.Typography
import OUI.Text


type alias Theme =
    { common : Layout
    , fab :
        { small : FABLayout
        , medium : FABLayout
        , large : FABLayout
        }
    , icon : IconLayout
    }


defaultTheme : Theme
defaultTheme =
    { common =
        { containerHeight = 40
        , containerRadius = 20
        , iconSize = 18
        , leftRightPadding = 24
        , leftPaddingWithIcon = 16
        , rightPaddingWithIcon = 16
        , paddingBetweenElements = 8

        --, labelTextAlignment =
        }
    , fab =
        { small =
            { containerHeight = 40
            , containerShape = 12
            , containerWidth = 40
            , iconSize = 24
            }
        , medium =
            { containerHeight = 56
            , containerShape = 16
            , containerWidth = 56
            , iconSize = 24
            }
        , large =
            { containerHeight = 96
            , containerShape = 28
            , containerWidth = 96
            , iconSize = 36
            }
        }
    , icon =
        { iconSize = 24
        , containerSize = 40
        }
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


type alias FABLayout =
    { containerHeight : Int
    , containerShape : Int
    , containerWidth : Int
    , iconSize : Int
    }


type alias IconLayout =
    { iconSize : Int
    , containerSize : Int

    -- , targetSize : Int
    }


{-| returns the front & back colors of a button
-}
btnColors :
    OUI.Material.Color.Scheme
    -> OUI.Button.Type
    -> OUI.Color
    -> Bool
    -> ( Color.Color, Color.Color )
btnColors colorscheme type_ color disabled =
    case ( type_, disabled ) of
        ( OUI.Button.Elevated, False ) ->
            ( OUI.Material.Color.getColor color colorscheme
            , colorscheme.surfaceContainerLow
            )

        ( OUI.Button.Filled, False ) ->
            ( OUI.Material.Color.getOnColor color colorscheme
            , OUI.Material.Color.getColor color colorscheme
            )

        ( OUI.Button.FilledIcon, False ) ->
            ( OUI.Material.Color.getOnColor color colorscheme
            , OUI.Material.Color.getColor color colorscheme
            )

        ( _, True ) ->
            ( OUI.Material.Color.setAlpha 0.38 colorscheme.onSurface
            , OUI.Material.Color.setAlpha 0.12 colorscheme.onSurface
            )

        ( _, False ) ->
            ( OUI.Material.Color.getColor color colorscheme
            , colorscheme.surfaceContainerLow
            )


commonButtonAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> Bool
    -> List (Attribute msg)
commonButtonAttrs typescale colorscheme layout hasIcon =
    let
        padding =
            if hasIcon then
                Element.paddingEach
                    { top = 0
                    , bottom = 0
                    , left = layout.leftPaddingWithIcon
                    , right = layout.rightPaddingWithIcon
                    }

            else
                Element.paddingXY layout.leftRightPadding 0
    in
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , padding
           ]


iconButtonAttrs : IconLayout -> List (Attribute msg)
iconButtonAttrs layout =
    [ Element.width <| Element.px layout.containerSize
    , Element.height <| Element.px layout.containerSize
    , Border.rounded (layout.containerSize // 2)
    ]


elevatedAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
elevatedAttrs typescale colorscheme layout color =
    let
        ( frontColor, backColor ) =
            btnColors colorscheme OUI.Button.Elevated color False
    in
    [ Border.shadow
        { offset = ( 1, 1 )
        , size = 1
        , blur = 1
        , color = OUI.Material.Color.toElementColor colorscheme.shadow
        }
    , Background.color <| OUI.Material.Color.toElementColor backColor
    , Font.color <| OUI.Material.Color.toElementColor frontColor
    , Element.focused
        [ colorscheme.surfaceContainerLow
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.focusStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseDown
        [ colorscheme.surfaceContainerLow
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.pressStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseOver
        [ colorscheme.surfaceContainerLow
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
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
elevatedDisabledAttrs typescale colorscheme layout =
    let
        ( frontColor, backColor ) =
            btnColors colorscheme OUI.Button.Elevated OUI.Primary True
    in
    [ Background.color <| OUI.Material.Color.toElementColor backColor
    , Font.color <| OUI.Material.Color.toElementColor frontColor
    , Element.focused
        [ Background.color <|
            OUI.Material.Color.toElementColor <|
                OUI.Material.Color.setAlpha
                    (0.12 + OUI.Material.Color.hoverStateLayerOpacity)
                    colorscheme.onSurface
        ]
    ]


filledAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
filledAttrs typescale colorscheme layout color =
    let
        ( frontColor, backColor ) =
            btnColors colorscheme OUI.Button.Filled color False
    in
    [ Background.color <| OUI.Material.Color.toElementColor backColor
    , Font.color <| OUI.Material.Color.toElementColor frontColor
    , Element.focused
        [ OUI.Material.Color.getColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getOnColor color colorscheme)
                OUI.Material.Color.focusStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseDown
        [ OUI.Material.Color.getColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getOnColor color colorscheme)
                OUI.Material.Color.pressStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseOver
        [ OUI.Material.Color.getColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getOnColor color colorscheme)
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
filledDisabledAttrs typescale colorscheme layout =
    let
        ( frontColor, backColor ) =
            btnColors colorscheme OUI.Button.Filled OUI.Primary True
    in
    [ Background.color <| OUI.Material.Color.toElementColor backColor
    , Font.color <| OUI.Material.Color.toElementColor frontColor
    , Element.focused
        [ Background.color <|
            OUI.Material.Color.toElementColor <|
                OUI.Material.Color.setAlpha
                    (0.12 + OUI.Material.Color.hoverStateLayerOpacity)
                    colorscheme.onSurface
        ]
    ]


outlinedAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
outlinedAttrs typescale colorscheme layout color =
    [ Border.width 1
    , Border.color <| OUI.Material.Color.toElementColor colorscheme.outline
    , Font.color <| OUI.Material.Color.getElementColor color colorscheme
    , Element.focused
        [ colorscheme.surface
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.focusStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseDown
        [ colorscheme.surface
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.pressStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseOver
        [ colorscheme.surface
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
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
outlinedDisabledAttrs typescale colorscheme layout =
    [ Border.width 1
    , Border.color <|
        OUI.Material.Color.toElementColor <|
            OUI.Material.Color.setAlpha 0.12 colorscheme.onSurface
    , Font.color <|
        OUI.Material.Color.toElementColor <|
            OUI.Material.Color.setAlpha 0.38 colorscheme.onSurface
    , Element.focused
        [ Background.color <|
            OUI.Material.Color.toElementColor <|
                OUI.Material.Color.setAlpha
                    OUI.Material.Color.hoverStateLayerOpacity
                    colorscheme.onSurface
        ]
    ]


textAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
textAttrs typescale colorscheme layout color =
    [ Font.color <| OUI.Material.Color.getElementColor color colorscheme
    , Element.focused
        [ colorscheme.surface
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.focusStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseDown
        [ colorscheme.surface
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.pressStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseOver
        [ colorscheme.surface
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
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
textDisabledAttrs typescale colorscheme layout =
    [ Font.color <|
        OUI.Material.Color.toElementColor <|
            OUI.Material.Color.setAlpha 0.38 colorscheme.onSurface
    , Element.focused
        [ Background.color <|
            OUI.Material.Color.toElementColor <|
                OUI.Material.Color.setAlpha
                    OUI.Material.Color.hoverStateLayerOpacity
                    colorscheme.onSurface
        ]
    ]


fabAttrs :
    OUI.Material.Color.Scheme
    -> FABLayout
    -> OUI.Color
    -> List (Attribute msg)
fabAttrs colorscheme layout color =
    let
        -- TODO The fab colors mappings are primary, secondary, tertiary and surface
        -- so the 'OUI.Color' is not adapted here. We'll need to make things differently
        -- for fabs
        ( bgColor, stateLayerColor ) =
            case color of
                OUI.Primary ->
                    ( colorscheme.primaryContainer, colorscheme.onPrimaryContainer )

                OUI.PrimaryContainer ->
                    ( colorscheme.primaryContainer, colorscheme.onPrimaryContainer )

                OUI.Secondary ->
                    ( colorscheme.secondaryContainer, colorscheme.onSecondaryContainer )

                OUI.SecondaryContainer ->
                    ( colorscheme.secondaryContainer, colorscheme.onSecondaryContainer )

                OUI.Tertiary ->
                    ( colorscheme.tertiaryContainer, colorscheme.onTertiaryContainer )

                OUI.TertiaryContainer ->
                    ( colorscheme.tertiaryContainer, colorscheme.onTertiaryContainer )

                OUI.Error ->
                    ( colorscheme.errorContainer, colorscheme.onErrorContainer )

                OUI.ErrorContainer ->
                    ( colorscheme.errorContainer, colorscheme.onErrorContainer )
    in
    [ Border.rounded layout.containerShape
    , Element.height <| Element.px layout.containerHeight
    , Element.width <| Element.px layout.containerWidth
    , Border.shadow
        { offset = ( 1, 1 )
        , size = 1
        , blur = 1
        , color = OUI.Material.Color.toElementColor colorscheme.shadow
        }
    , Background.color <| OUI.Material.Color.toElementColor bgColor
    , Element.focused
        [ bgColor
            |> OUI.Material.Color.withShade
                stateLayerColor
                OUI.Material.Color.focusStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseDown
        [ bgColor
            |> OUI.Material.Color.withShade
                stateLayerColor
                OUI.Material.Color.pressStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseOver
        [ bgColor
            |> OUI.Material.Color.withShade
                stateLayerColor
                OUI.Material.Color.hoverStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    ]


iconOnly : OUI.Button.Type -> Bool
iconOnly t =
    case t of
        OUI.Button.Icon ->
            True

        OUI.Button.FilledIcon ->
            True

        OUI.Button.OutlinedIcon ->
            True

        OUI.Button.SmallFAB ->
            True

        OUI.Button.MediumFAB ->
            True

        OUI.Button.LargeFAB ->
            True

        _ ->
            False


iconSizeColor : OUI.Material.Color.Scheme -> Theme -> OUI.Button.Type -> OUI.Color -> Bool -> ( Int, Color.Color )
iconSizeColor colorscheme theme type_ color disabled =
    let
        ( frontColor, _ ) =
            btnColors colorscheme type_ color disabled
    in
    case type_ of
        OUI.Button.SmallFAB ->
            ( theme.fab.small.iconSize, frontColor )

        OUI.Button.MediumFAB ->
            ( theme.fab.medium.iconSize, frontColor )

        OUI.Button.LargeFAB ->
            ( theme.fab.large.iconSize, frontColor )

        OUI.Button.Icon ->
            ( theme.icon.iconSize, frontColor )

        OUI.Button.FilledIcon ->
            ( theme.icon.iconSize, frontColor )

        OUI.Button.OutlinedIcon ->
            ( theme.icon.iconSize, frontColor )

        _ ->
            ( theme.common.iconSize, frontColor )


render :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> Button { constraints | hasText : (), hasAction : () } msg
    -> Element msg
render typescale colorscheme theme attrs button =
    let
        props =
            properties button

        hasIcon =
            props.icon /= Nothing

        label =
            case props.icon of
                Nothing ->
                    Element.text props.text

                Just icon ->
                    let
                        ( size, color ) =
                            iconSizeColor colorscheme theme props.type_ props.color (props.onClick == Nothing)
                    in
                    if iconOnly props.type_ then
                        Icon.renderWithSizeColor size
                            color
                            [ Element.centerX
                            , Element.centerY
                            ]
                            icon

                    else
                        Element.row [ Element.spacing theme.common.paddingBetweenElements ]
                            [ Icon.renderWithSizeColor size
                                color
                                [ Element.centerX
                                , Element.centerY
                                ]
                                icon
                            , Element.text props.text
                            ]
    in
    Input.button
        ((Element.height <| Element.px theme.common.containerHeight)
            :: attrs
            ++ (case ( props.type_, props.onClick ) of
                    ( OUI.Button.Elevated, Just _ ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ elevatedAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Elevated, Nothing ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ elevatedDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Filled, Just _ ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ filledAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Filled, Nothing ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ filledDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.FilledIcon, Just _ ) ->
                        iconButtonAttrs theme.icon
                            ++ filledAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.FilledIcon, Nothing ) ->
                        iconButtonAttrs theme.icon
                            ++ filledDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Tonal, Just _ ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ filledAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Tonal, Nothing ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ filledDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Outlined, Just _ ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ outlinedAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Outlined, Nothing ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ outlinedDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.OutlinedIcon, Just _ ) ->
                        iconButtonAttrs theme.icon
                            ++ outlinedAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.OutlinedIcon, Nothing ) ->
                        iconButtonAttrs theme.icon
                            ++ outlinedDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Text, Just _ ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ textAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Text, Nothing ) ->
                        commonButtonAttrs typescale colorscheme theme.common hasIcon
                            ++ textDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Icon, Just _ ) ->
                        iconButtonAttrs theme.icon
                            ++ textAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Icon, Nothing ) ->
                        iconButtonAttrs theme.icon
                            ++ textDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.SmallFAB, Just _ ) ->
                        fabAttrs colorscheme theme.fab.small props.color

                    ( OUI.Button.MediumFAB, Just _ ) ->
                        fabAttrs colorscheme theme.fab.medium props.color

                    ( OUI.Button.LargeFAB, Just _ ) ->
                        fabAttrs colorscheme theme.fab.large props.color

                    _ ->
                        textDisabledAttrs typescale colorscheme theme.common
               )
        )
        { label = label
        , onPress = props.onClick
        }
