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


{-| returns the front & back colors of a button
-}
btnColors :
    OUI.Material.Color.Scheme
    -> OUI.Button.Type
    -> OUI.Color
    -> Bool
    -> ( Color.Color, Color.Color )
btnColors colorScheme type_ color disabled =
    case ( type_, disabled ) of
        ( OUI.Button.Elevated, False ) ->
            ( OUI.Material.Color.getColor color colorScheme
            , colorScheme.surfaceContainerLow
            )

        ( OUI.Button.Filled, False ) ->
            ( OUI.Material.Color.getOnColor color colorScheme
            , OUI.Material.Color.getColor color colorScheme
            )

        ( _, True ) ->
            ( OUI.Material.Color.setAlpha 0.38 colorScheme.onSurface
            , OUI.Material.Color.setAlpha 0.12 colorScheme.onSurface
            )

        ( _, False ) ->
            ( OUI.Material.Color.getColor color colorScheme
            , colorScheme.surfaceContainerLow
            )


elevatedAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
elevatedAttrs typescale colorScheme layout color =
    let
        ( frontColor, backColor ) =
            btnColors colorScheme OUI.Button.Elevated color False
    in
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Border.shadow
                { offset = ( 1, 1 )
                , size = 1
                , blur = 1
                , color = OUI.Material.Color.toElementColor colorScheme.shadow
                }
           , Background.color <| OUI.Material.Color.toElementColor backColor
           , Font.color <| OUI.Material.Color.toElementColor frontColor
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
    let
        ( frontColor, backColor ) =
            btnColors colorScheme OUI.Button.Elevated OUI.Primary True
    in
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Background.color <| OUI.Material.Color.toElementColor backColor
           , Font.color <| OUI.Material.Color.toElementColor frontColor
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
    let
        ( frontColor, backColor ) =
            btnColors colorScheme OUI.Button.Filled color False
    in
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Background.color <| OUI.Material.Color.toElementColor backColor
           , Font.color <| OUI.Material.Color.toElementColor frontColor
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
    let
        ( frontColor, backColor ) =
            btnColors colorScheme OUI.Button.Filled OUI.Primary True
    in
    OUI.Material.Typography.attrs typescale OUI.Text.Label OUI.Text.Large
        ++ [ Border.rounded layout.containerRadius
           , Background.color <| OUI.Material.Color.toElementColor backColor
           , Font.color <| OUI.Material.Color.toElementColor frontColor
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


fabAttrs :
    OUI.Material.Color.Scheme
    -> FABLayout
    -> OUI.Color
    -> List (Attribute msg)
fabAttrs colorScheme layout color =
    let
        -- TODO The fab colors mappings are primary, secondary, tertiary and surface
        -- so the 'OUI.Color' is not adapted here. We'll need to make things differently
        -- for fabs
        ( bgColor, stateLayerColor ) =
            case color of
                OUI.Primary ->
                    ( colorScheme.primaryContainer, colorScheme.onPrimaryContainer )

                OUI.PrimaryContainer ->
                    ( colorScheme.primaryContainer, colorScheme.onPrimaryContainer )

                OUI.Secondary ->
                    ( colorScheme.secondaryContainer, colorScheme.onSecondaryContainer )

                OUI.SecondaryContainer ->
                    ( colorScheme.secondaryContainer, colorScheme.onSecondaryContainer )

                OUI.Tertiary ->
                    ( colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer )

                OUI.TertiaryContainer ->
                    ( colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer )

                OUI.Error ->
                    ( colorScheme.errorContainer, colorScheme.onErrorContainer )

                OUI.ErrorContainer ->
                    ( colorScheme.errorContainer, colorScheme.onErrorContainer )
    in
    [ Border.rounded layout.containerShape
    , Element.height <| Element.px layout.containerHeight
    , Element.width <| Element.px layout.containerWidth
    , Border.shadow
        { offset = ( 1, 1 )
        , size = 1
        , blur = 1
        , color = OUI.Material.Color.toElementColor colorScheme.shadow
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

        padding =
            case props.icon of
                Nothing ->
                    Element.paddingXY theme.common.leftRightPadding 0

                Just _ ->
                    Element.paddingEach
                        { top = 0
                        , bottom = 0
                        , left = theme.common.leftPaddingWithIcon
                        , right = theme.common.rightPaddingWithIcon
                        }

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
            :: padding
            :: attrs
            ++ (case ( props.type_, props.onClick ) of
                    ( OUI.Button.Elevated, Just _ ) ->
                        elevatedAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Elevated, Nothing ) ->
                        elevatedDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Filled, Just _ ) ->
                        filledAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Filled, Nothing ) ->
                        filledDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Tonal, Just _ ) ->
                        filledAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Tonal, Nothing ) ->
                        filledDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Outlined, Just _ ) ->
                        outlinedAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Outlined, Nothing ) ->
                        outlinedDisabledAttrs typescale colorscheme theme.common

                    ( OUI.Button.Text, Just _ ) ->
                        textAttrs typescale colorscheme theme.common props.color

                    ( OUI.Button.Text, Nothing ) ->
                        textDisabledAttrs typescale colorscheme theme.common

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
