module OUI.Material.Button exposing
    ( FABLayout
    , IconLayout
    , Layout
    , Theme
    , defaultTheme
    , render
    , renderProps
    )

import Color
import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import OUI
import OUI.Button exposing (Button)
import OUI.Icon exposing (Icon)
import OUI.Material.Color
import OUI.Material.Icon as Icon
import OUI.Material.Typography
import OUI.Text
import OUI.Utils.ARIA as ARIA


type alias Theme =
    { common : Layout
    , fab :
        { small : FABLayout
        , medium : FABLayout
        , large : FABLayout
        , extended : Layout
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
        , textType = OUI.Text.Label
        , textSize = OUI.Text.Large

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
        , extended =
            { containerHeight = 56
            , containerRadius = 16
            , iconSize = 24
            , leftRightPadding = 24
            , leftPaddingWithIcon = 16
            , rightPaddingWithIcon = 16
            , paddingBetweenElements = 8
            , textType = OUI.Text.Label
            , textSize = OUI.Text.Large

            --, labelTextAlignment =
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
    , textType : OUI.Text.Type
    , textSize : OUI.Text.Size

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
            , OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
            )

        ( OUI.Button.Filled, False ) ->
            ( OUI.Material.Color.getOnColor color colorscheme
            , OUI.Material.Color.getColor color colorscheme
            )

        ( OUI.Button.FilledIcon, False ) ->
            ( OUI.Material.Color.getOnColor color colorscheme
            , OUI.Material.Color.getColor color colorscheme
            )

        ( OUI.Button.SmallFAB, False ) ->
            ( OUI.Material.Color.getOnColor color colorscheme
            , OUI.Material.Color.getColor color colorscheme
            )

        ( OUI.Button.MediumFAB, False ) ->
            ( OUI.Material.Color.getOnColor color colorscheme
            , OUI.Material.Color.getColor color colorscheme
            )

        ( OUI.Button.LargeFAB, False ) ->
            ( OUI.Material.Color.getOnColor color colorscheme
            , OUI.Material.Color.getColor color colorscheme
            )

        ( OUI.Button.ExtendedFAB, False ) ->
            ( OUI.Material.Color.getOnColor color colorscheme
            , OUI.Material.Color.getColor color colorscheme
            )

        ( _, True ) ->
            ( OUI.Material.Color.getOnSurfaceColor color colorscheme
                |> OUI.Material.Color.setAlpha 0.38
            , OUI.Material.Color.getOnSurfaceColor color colorscheme
                |> OUI.Material.Color.setAlpha 0.12
            )

        ( _, False ) ->
            ( OUI.Material.Color.getColor color colorscheme
            , OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
            )


layoutAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> Bool
    -> List (Attribute msg)
layoutAttrs typescale colorscheme layout hasIcon =
    let
        padding : Attribute msg
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
    (Element.height <| Element.px layout.containerHeight)
        :: OUI.Material.Typography.attrs layout.textType layout.textSize OUI.Text.NoColor typescale colorscheme
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
elevatedAttrs _ colorscheme _ color =
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
        [ OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.focusStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseDown
        [ OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.pressStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseOver
        [ OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
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
    -> OUI.Color
    -> Layout
    -> List (Attribute msg)
elevatedDisabledAttrs _ colorscheme color _ =
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
                    (OUI.Material.Color.getOnSurfaceColor color colorscheme)
        ]
    ]


filledAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
filledAttrs _ colorscheme _ color =
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
    -> OUI.Color
    -> Layout
    -> List (Attribute msg)
filledDisabledAttrs _ colorscheme color _ =
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
                    (OUI.Material.Color.getOnSurfaceColor color colorscheme)
        ]
    ]


outlinedAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
outlinedAttrs _ colorscheme _ color =
    [ Border.width 1
    , Border.color <| OUI.Material.Color.toElementColor colorscheme.outline
    , Font.color <| OUI.Material.Color.getElementColor color colorscheme
    , Element.focused
        [ OUI.Material.Color.getSurfaceColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.focusStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseDown
        [ OUI.Material.Color.getSurfaceColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.pressStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseOver
        [ OUI.Material.Color.getSurfaceColor color colorscheme
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
    -> OUI.Color
    -> Layout
    -> List (Attribute msg)
outlinedDisabledAttrs _ colorscheme color _ =
    [ Border.width 1
    , Border.color <|
        OUI.Material.Color.toElementColor <|
            OUI.Material.Color.setAlpha 0.12 (OUI.Material.Color.getOnSurfaceColor color colorscheme)
    , Font.color <|
        OUI.Material.Color.toElementColor <|
            OUI.Material.Color.setAlpha 0.38 (OUI.Material.Color.getOnSurfaceColor color colorscheme)
    , Element.focused
        [ Background.color <|
            OUI.Material.Color.toElementColor <|
                OUI.Material.Color.setAlpha
                    OUI.Material.Color.hoverStateLayerOpacity
                    (OUI.Material.Color.getOnSurfaceColor color colorscheme)
        ]
    ]


textAttrs :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Layout
    -> OUI.Color
    -> List (Attribute msg)
textAttrs _ colorscheme _ color =
    [ Font.color <| OUI.Material.Color.getElementColor color colorscheme
    , Element.focused
        [ OUI.Material.Color.getSurfaceColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.focusStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseDown
        [ OUI.Material.Color.getSurfaceColor color colorscheme
            |> OUI.Material.Color.withShade
                (OUI.Material.Color.getColor color colorscheme)
                OUI.Material.Color.pressStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
    , Element.mouseOver
        [ OUI.Material.Color.getSurfaceColor color colorscheme
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
    -> OUI.Color
    -> Layout
    -> List (Attribute msg)
textDisabledAttrs _ colorscheme color _ =
    [ Font.color <|
        OUI.Material.Color.toElementColor <|
            OUI.Material.Color.setAlpha 0.38 (OUI.Material.Color.getOnSurfaceColor color colorscheme)
    , Element.focused
        [ Background.color <|
            OUI.Material.Color.toElementColor <|
                OUI.Material.Color.setAlpha
                    OUI.Material.Color.hoverStateLayerOpacity
                    (OUI.Material.Color.getOnSurfaceColor color colorscheme)
        ]
    ]


fabLayoutAttrs :
    FABLayout
    -> List (Attribute msg)
fabLayoutAttrs layout =
    [ Border.rounded layout.containerShape
    , Element.height <| Element.px layout.containerHeight
    , Element.width <| Element.px layout.containerWidth
    ]


fabColorsAttrs :
    OUI.Material.Color.Scheme
    -> OUI.Color
    -> List (Attribute msg)
fabColorsAttrs colorscheme color =
    let
        stateLayerColor : Color.Color
        stateLayerColor =
            frontColor

        ( frontColor, bgColor ) =
            btnColors colorscheme OUI.Button.SmallFAB color False
    in
    [ Border.shadow
        { offset = ( 1, 1 )
        , size = 1
        , blur = 1
        , color = OUI.Material.Color.toElementColor colorscheme.shadow
        }
    , Background.color <| OUI.Material.Color.toElementColor bgColor
    , Font.color <| OUI.Material.Color.toElementColor frontColor
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

        OUI.Button.ExtendedFAB ->
            ( theme.fab.extended.iconSize, frontColor )

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
    -> Maybe Icon
    -> List (Attribute msg)
    -> Button { constraints | hasAction : () } msg
    -> Element msg
render typescale colorscheme theme rightIcon attrs button =
    let
        props :
            { text : String
            , icon : Maybe Icon
            , action : OUI.Button.Action msg
            , color : OUI.Color
            , type_ : OUI.Button.Type
            }
        props =
            { text = OUI.Button.getText button
            , icon = OUI.Button.getIcon button
            , action = OUI.Button.getAction button
            , color = OUI.Button.getColor button
            , type_ = OUI.Button.getType button
            }
    in
    renderProps typescale colorscheme theme rightIcon attrs props


renderProps :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Theme
    -> Maybe Icon
    -> List (Attribute msg)
    ->
        { text : String
        , icon : Maybe Icon
        , action : OUI.Button.Action msg
        , color : OUI.Color
        , type_ : OUI.Button.Type
        }
    -> Element msg
renderProps typescale colorscheme theme rightIcon attrs props =
    let
        aria : List (Attribute msg)
        aria =
            ARIA.roleButton
                |> ARIA.withLabel props.text
                |> ARIA.toElementAttributes

        hasIcon : Bool
        hasIcon =
            props.icon /= Nothing

        label : Element msg
        label =
            let
                ( size, color ) =
                    iconSizeColor colorscheme theme props.type_ props.color (props.action == OUI.Button.Disabled)
            in
            case ( iconOnly props.type_, props.icon, rightIcon ) of
                ( _, Nothing, Nothing ) ->
                    Element.el
                        [ Element.centerX
                        , Element.centerY
                        ]
                    <|
                        Element.text props.text

                ( True, _, Just icon ) ->
                    Icon.renderWithSizeColor size
                        color
                        [ Element.centerX
                        , Element.centerY
                        ]
                        icon

                ( True, Just icon, _ ) ->
                    Icon.renderWithSizeColor size
                        color
                        [ Element.centerX
                        , Element.centerY
                        ]
                        icon

                ( False, icon, rIcon ) ->
                    [ icon
                        |> Maybe.map
                            (Icon.renderWithSizeColor size
                                color
                                [ Element.centerX
                                , Element.centerY
                                ]
                            )
                    , Just (Element.text props.text)
                    , rIcon
                        |> Maybe.map
                            (Icon.renderWithSizeColor size
                                color
                                [ Element.centerX
                                , Element.centerY
                                ]
                            )
                    ]
                        |> List.filterMap identity
                        |> Element.row
                            [ Element.spacing theme.common.paddingBetweenElements
                            ]

        all_attrs : List (Attribute msg)
        all_attrs =
            --(Element.height <| Element.px theme.common.containerHeight) ::
            aria
                ++ attrs
                ++ (case ( props.type_, props.action ) of
                        ( OUI.Button.Elevated, OUI.Button.Disabled ) ->
                            layoutAttrs typescale colorscheme theme.common hasIcon
                                ++ elevatedDisabledAttrs typescale colorscheme props.color theme.common

                        ( OUI.Button.Elevated, _ ) ->
                            layoutAttrs typescale colorscheme theme.common hasIcon
                                ++ elevatedAttrs typescale colorscheme theme.common props.color

                        ( OUI.Button.Filled, OUI.Button.Disabled ) ->
                            layoutAttrs typescale colorscheme theme.common hasIcon
                                ++ filledDisabledAttrs typescale colorscheme props.color theme.common

                        ( OUI.Button.Filled, _ ) ->
                            layoutAttrs typescale colorscheme theme.common hasIcon
                                ++ filledAttrs typescale colorscheme theme.common props.color

                        ( OUI.Button.FilledIcon, OUI.Button.Disabled ) ->
                            iconButtonAttrs theme.icon
                                ++ filledDisabledAttrs typescale colorscheme props.color theme.common

                        ( OUI.Button.FilledIcon, _ ) ->
                            iconButtonAttrs theme.icon
                                ++ filledAttrs typescale colorscheme theme.common props.color

                        ( OUI.Button.Outlined, OUI.Button.Disabled ) ->
                            layoutAttrs typescale colorscheme theme.common hasIcon
                                ++ outlinedDisabledAttrs typescale colorscheme props.color theme.common

                        ( OUI.Button.Outlined, _ ) ->
                            layoutAttrs typescale colorscheme theme.common hasIcon
                                ++ outlinedAttrs typescale colorscheme theme.common props.color

                        ( OUI.Button.OutlinedIcon, OUI.Button.Disabled ) ->
                            iconButtonAttrs theme.icon
                                ++ outlinedDisabledAttrs typescale colorscheme props.color theme.common

                        ( OUI.Button.OutlinedIcon, _ ) ->
                            iconButtonAttrs theme.icon
                                ++ outlinedAttrs typescale colorscheme theme.common props.color

                        ( OUI.Button.Text, OUI.Button.Disabled ) ->
                            layoutAttrs typescale colorscheme theme.common hasIcon
                                ++ textDisabledAttrs typescale colorscheme props.color theme.common

                        ( OUI.Button.Text, _ ) ->
                            layoutAttrs typescale colorscheme theme.common hasIcon
                                ++ textAttrs typescale colorscheme theme.common props.color

                        ( OUI.Button.Icon, OUI.Button.Disabled ) ->
                            iconButtonAttrs theme.icon
                                ++ textDisabledAttrs typescale colorscheme props.color theme.common

                        ( OUI.Button.Icon, _ ) ->
                            iconButtonAttrs theme.icon
                                ++ textAttrs typescale colorscheme theme.common props.color

                        ( OUI.Button.SmallFAB, _ ) ->
                            fabLayoutAttrs theme.fab.small
                                ++ fabColorsAttrs colorscheme props.color

                        ( OUI.Button.MediumFAB, _ ) ->
                            fabLayoutAttrs theme.fab.medium
                                ++ fabColorsAttrs colorscheme props.color

                        ( OUI.Button.LargeFAB, _ ) ->
                            fabLayoutAttrs theme.fab.large
                                ++ fabColorsAttrs colorscheme props.color

                        ( OUI.Button.ExtendedFAB, OUI.Button.Disabled ) ->
                            layoutAttrs typescale colorscheme theme.fab.extended hasIcon
                                ++ fabColorsAttrs colorscheme props.color

                        ( OUI.Button.ExtendedFAB, _ ) ->
                            layoutAttrs typescale colorscheme theme.fab.extended hasIcon
                                ++ fabColorsAttrs colorscheme props.color
                   )
    in
    case props.action of
        OUI.Button.Link url ->
            Element.link all_attrs
                { label = label
                , url = url
                }

        OUI.Button.NewTabLink url ->
            Element.newTabLink all_attrs
                { label = label
                , url = url
                }

        OUI.Button.DownloadLink url ->
            Element.download all_attrs
                { label = label
                , url = url
                }

        OUI.Button.DownloadAsLink url filename ->
            Element.downloadAs all_attrs
                { label = label
                , filename = filename
                , url = url
                }

        OUI.Button.OnClick msg ->
            Input.button all_attrs
                { label = label
                , onPress = Just msg
                }

        OUI.Button.Disabled ->
            Input.button all_attrs
                { label = label
                , onPress = Nothing
                }
