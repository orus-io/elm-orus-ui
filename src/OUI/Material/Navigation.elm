module OUI.Material.Navigation exposing (Theme, defaultTheme, render)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import Element.Keyed as Keyed
import Html.Attributes
import OUI
import OUI.Badge
import OUI.Button exposing (Button)
import OUI.Divider
import OUI.Image exposing (Image)
import OUI.Material.Badge
import OUI.Material.Color exposing (toElementColor)
import OUI.Material.Divider
import OUI.Material.Icon
import OUI.Material.Typography as Typography
import OUI.Navigation exposing (Navigation)
import OUI.Text


transition : String -> Attribute msg
transition =
    Html.Attributes.style "transition"
        >> Element.htmlAttribute


transitionAllEaseOut : Attribute msg
transitionAllEaseOut =
    -- transition "all 0.3s ease-out"
    transition ""


type alias DrawerTheme =
    { containerWidth : Int
    , iconSize : Int
    , activeIndicatorHeight : Int
    , activeIndicatorShape : Int
    , activeIndicatorWidth : Int

    --Horizontal label alignment: Start-aligned
    , leftPadding : Int
    , rightPadding : Int
    , activeIndicatorPadding : Int
    , badgeRightPadding : Int
    , paddingBetweenElements : Int
    }


type alias RailTheme =
    { containerWidth : Int

    --, containerShape:Int
    , destinationItemHeight : Int
    , activeIndicatorHeight : Int
    , activeIndicatorWidth : Int
    , activeIndicatorShape : Int

    --Active indicator height (no destination label text) 56dp
    --Active indicator shape (no destination label text) 28dp corner radius
    , iconSize : Int
    , badgeTheme : OUI.Material.Badge.Theme
    , paddingBetweenEdgeAndActiveIndicator : Int
    , paddingbetweenActiveIndicatorAndLabelText : Int
    , paddingBetweenDestinationItems : Int
    }


type alias Theme =
    { drawer : DrawerTheme
    , rail : RailTheme
    }


defaultTheme : Theme
defaultTheme =
    { drawer =
        { containerWidth = 360
        , iconSize = 24
        , activeIndicatorHeight = 56
        , activeIndicatorShape = 28
        , activeIndicatorWidth = 336

        --Horizontal label alignment: Start-aligned
        , leftPadding = 28
        , rightPadding = 28
        , activeIndicatorPadding = 12
        , badgeRightPadding = 16
        , paddingBetweenElements = 0
        }
    , rail =
        { containerWidth = 80

        --, containerShape = 0
        , destinationItemHeight = 56
        , activeIndicatorHeight = 32
        , activeIndicatorWidth = 56
        , activeIndicatorShape = 16

        --Active indicator height (no destination label text) 56dp
        --Active indicator shape (no destination label text) 28dp corner radius
        , iconSize = 24
        , badgeTheme = OUI.Material.Badge.defaultTheme
        , paddingBetweenEdgeAndActiveIndicator = 12
        , paddingbetweenActiveIndicatorAndLabelText = 4
        , paddingBetweenDestinationItems = 12
        }
    }


render :
    Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> OUI.Material.Divider.Theme
    -> Theme
    -> List (Attribute msg)
    -> Navigation btnC key msg
    -> Element msg
render typescale colorscheme dividerTheme theme _ nav =
    let
        props :
            { imageHeader : Maybe Image
            , fab : Maybe (Button { btnC | hasAction : (), hasIcon : () } msg)
            , header : Maybe String
            , selected : Maybe key
            , entries : List (OUI.Navigation.Entry key)
            , mode : OUI.Navigation.Mode
            , onSelect : key -> msg
            , onDismiss : Maybe msg
            , activeColor : OUI.Color
            }
        props =
            { imageHeader = OUI.Navigation.getImageHeader nav
            , fab = OUI.Navigation.getFAB nav
            , header = OUI.Navigation.getHeader nav
            , selected = OUI.Navigation.getSelected nav
            , entries = OUI.Navigation.getEntries nav
            , mode = OUI.Navigation.getMode nav
            , onSelect = OUI.Navigation.getOnSelect nav
            , onDismiss = OUI.Navigation.getOnDismiss nav
            , activeColor = OUI.Navigation.getActiveColor nav
            }

        isDrawer : Bool
        isDrawer =
            props.mode /= OUI.Navigation.Rail

        width : Int
        width =
            if isDrawer then
                theme.drawer.containerWidth

            else
                theme.rail.containerWidth
    in
    Keyed.column
        [ Background.color <| toElementColor (OUI.Material.Color.getSurfaceContainerLowColor props.activeColor colorscheme)
        , Element.width <| Element.px width
        , Element.height <| Element.fill
        , Element.scrollbarY
        , transitionAllEaseOut
        ]
    <|
        -- [image header
        -- text header
        -- fab
        -- ]
        -- ++
        (case props.header of
            Just s ->
                ( "header"
                , OUI.Text.headlineSmall s
                    |> Typography.render typescale colorscheme
                    |> Element.el
                        [ Element.centerX
                        , Element.padding 15
                        ]
                )

            Nothing ->
                ( "", Element.none )
        )
            :: List.indexedMap
                (\i entry ->
                    ( String.fromInt i
                    , renderEntry typescale colorscheme dividerTheme theme props entry
                    )
                )
                props.entries


renderEntry :
    Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> OUI.Material.Divider.Theme
    -> Theme
    ->
        { imageHeader : Maybe Image
        , fab : Maybe (Button { btnC | hasAction : (), hasIcon : () } msg)
        , header : Maybe String
        , selected : Maybe key
        , entries : List (OUI.Navigation.Entry key)
        , mode : OUI.Navigation.Mode
        , onSelect : key -> msg
        , onDismiss : Maybe msg
        , activeColor : OUI.Color
        }
    -> OUI.Navigation.Entry key
    -> Element msg
renderEntry typescale colorscheme dividerTheme theme props entry =
    let
        isDrawer : Bool
        isDrawer =
            props.mode /= OUI.Navigation.Rail
    in
    case entry of
        OUI.Navigation.Entry key { label, icon, badge } ->
            if isDrawer then
                let
                    badgeString : Maybe String
                    badgeString =
                        badge
                            |> Maybe.map
                                (\b ->
                                    case b of
                                        OUI.Badge.Small ->
                                            ""

                                        OUI.Badge.Label s ->
                                            s

                                        OUI.Badge.Number n ->
                                            n |> String.fromInt
                                )

                    badgeEl : Element msg
                    badgeEl =
                        badgeString
                            |> Maybe.map
                                (\text ->
                                    Element.el
                                        [ Element.alignRight
                                        , Element.moveRight <|
                                            toFloat <|
                                                theme.drawer.activeIndicatorWidth
                                                    - theme.drawer.iconSize
                                                    - theme.drawer.leftPadding
                                                    - theme.drawer.badgeRightPadding
                                        , Element.centerY
                                        , transitionAllEaseOut
                                        ]
                                        (OUI.Text.labelLarge text
                                            |> Typography.renderWithAttrs
                                                typescale
                                                colorscheme
                                                [ transitionAllEaseOut
                                                ]
                                        )
                                )
                            |> Maybe.withDefault Element.none
                in
                Keyed.column
                    [ Element.width Element.fill
                    , Element.height <| Element.px theme.drawer.activeIndicatorHeight
                    , Element.paddingEach
                        { top = 0
                        , bottom = 0
                        , left = theme.drawer.leftPadding - theme.drawer.activeIndicatorPadding
                        , right = theme.drawer.rightPadding - theme.drawer.activeIndicatorPadding
                        }
                    , transitionAllEaseOut
                    ]
                    [ ( "btn"
                      , Input.button
                            [ Element.width Element.fill
                            , Element.paddingXY theme.drawer.activeIndicatorPadding 0
                            , Element.height <| Element.px theme.drawer.activeIndicatorHeight
                            , Border.rounded theme.drawer.activeIndicatorShape
                            , if props.selected == Just key then
                                Background.color <| OUI.Material.Color.getElementColor props.activeColor colorscheme

                              else
                                Element.mouseOver
                                    [ OUI.Material.Color.getSurfaceContainerLowColor props.activeColor colorscheme
                                        |> OUI.Material.Color.withShade
                                            (OUI.Material.Color.getOnSurfaceColor props.activeColor colorscheme)
                                            OUI.Material.Color.hoverStateLayerOpacity
                                        |> toElementColor
                                        |> Background.color
                                    ]
                            , transitionAllEaseOut
                            ]
                            { onPress = Just <| props.onSelect key
                            , label =
                                Keyed.row
                                    [ Element.width Element.fill
                                    , Element.spacing <| theme.drawer.iconSize // 2
                                    , Element.height <| Element.px theme.drawer.activeIndicatorHeight
                                    , transitionAllEaseOut
                                    ]
                                <|
                                    [ ( "icon"
                                      , OUI.Material.Icon.renderWithSizeColor
                                            theme.drawer.iconSize
                                            (OUI.Material.Color.getOnSurfaceVariantColor props.activeColor colorscheme)
                                            [ transitionAllEaseOut
                                            , Element.inFront badgeEl
                                            ]
                                            icon
                                      )
                                    , ( "label"
                                      , OUI.Text.labelLarge label
                                            |> Typography.renderWithAttrs
                                                typescale
                                                colorscheme
                                                [ transitionAllEaseOut
                                                ]
                                      )
                                    ]
                            }
                      )
                    ]

            else
                let
                    badgeAttrs : List (Attribute msg)
                    badgeAttrs =
                        case badge of
                            Nothing ->
                                []

                            Just b ->
                                OUI.Material.Badge.render typescale colorscheme theme.rail.badgeTheme [] b
                                    |> List.singleton
                in
                Keyed.column
                    [ Element.width Element.fill
                    , Element.height <| Element.px theme.rail.destinationItemHeight
                    , Element.paddingXY theme.rail.paddingBetweenEdgeAndActiveIndicator 0
                    , Element.centerY
                    , transitionAllEaseOut
                    ]
                    [ ( "btn"
                      , Input.button
                            [ Element.width Element.fill
                            , Element.height <| Element.px theme.rail.activeIndicatorHeight
                            , Border.rounded theme.rail.activeIndicatorShape
                            , if props.selected == Just key then
                                Background.color <| OUI.Material.Color.getElementColor props.activeColor colorscheme

                              else
                                Element.mouseOver
                                    [ Background.color <| OUI.Material.Color.getElementColor props.activeColor colorscheme
                                    ]
                            , transitionAllEaseOut
                            , Element.alignTop
                            ]
                            { onPress = Just <| props.onSelect key
                            , label =
                                Keyed.row
                                    [ Element.width <| Element.px theme.rail.activeIndicatorWidth
                                    , transitionAllEaseOut
                                    ]
                                <|
                                    [ ( "icon"
                                      , Element.el
                                            [ transitionAllEaseOut
                                            , Element.width <| Element.px theme.rail.activeIndicatorWidth
                                            ]
                                        <|
                                            OUI.Material.Icon.renderWithSizeColor
                                                theme.rail.iconSize
                                                (OUI.Material.Color.getOnSurfaceVariantColor props.activeColor colorscheme)
                                                ([ transitionAllEaseOut
                                                 , Element.centerX
                                                 ]
                                                    ++ badgeAttrs
                                                )
                                                icon
                                      )
                                    , ( "label"
                                      , Element.el
                                            [ transitionAllEaseOut
                                            , Element.width <| Element.px theme.rail.activeIndicatorWidth
                                            ]
                                            (OUI.Text.labelMedium
                                                label
                                                |> Typography.renderWithAttrs
                                                    typescale
                                                    colorscheme
                                                    [ Element.moveLeft <|
                                                        toFloat <|
                                                            theme.rail.activeIndicatorWidth
                                                    , Element.moveDown <|
                                                        toFloat <|
                                                            (theme.rail.activeIndicatorHeight // 2)
                                                                + theme.rail.paddingbetweenActiveIndicatorAndLabelText
                                                                + (typescale.label.medium.lineHeight // 2)
                                                    , transitionAllEaseOut
                                                    , Element.centerX
                                                    ]
                                            )
                                      )
                                    ]
                            }
                      )
                    ]

        OUI.Navigation.SectionHeader label ->
            if isDrawer then
                ( label
                , OUI.Text.titleSmall label
                    |> Typography.renderWithAttrs
                        typescale
                        colorscheme
                        [ Element.centerY
                        ]
                )
                    |> Keyed.el
                        [ Element.width Element.fill
                        , Element.height <| Element.px theme.drawer.activeIndicatorHeight
                        , Element.paddingXY theme.drawer.leftPadding 0
                        , transitionAllEaseOut
                        ]

            else
                Keyed.el
                    [ transitionAllEaseOut
                    , Element.width Element.fill
                    , Element.height <| Element.px 0
                    ]
                    ( label, Element.none )

        OUI.Navigation.Divider ->
            OUI.Divider.new
                |> OUI.Material.Divider.render colorscheme dividerTheme []
                |> Element.el
                    [ Element.paddingEach
                        { left =
                            if isDrawer then
                                theme.drawer.leftPadding

                            else
                                (theme.rail.containerWidth - theme.rail.activeIndicatorWidth) // 2
                        , right =
                            if isDrawer then
                                theme.drawer.rightPadding

                            else
                                (theme.rail.containerWidth - theme.rail.activeIndicatorWidth) // 2
                        , top =
                            if isDrawer then
                                0

                            else
                                theme.rail.paddingBetweenDestinationItems
                        , bottom =
                            if isDrawer then
                                0

                            else
                                theme.rail.paddingBetweenDestinationItems
                        }
                    , Element.width Element.fill
                    ]
