module OUI.Material.Navigation exposing (..)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Keyed as Keyed
import Html.Attributes
import OUI.Material.Color exposing (toElementColor)
import OUI.Material.Icon
import OUI.Material.Typography
import OUI.Navigation exposing (Navigation, NavigationProperties)
import OUI.Text


transition : String -> Attribute msg
transition =
    Html.Attributes.style "transition"
        >> Element.htmlAttribute


transitionAllEaseOut : Attribute msg
transitionAllEaseOut =
    -- transition "all 0.3s ease-out"
    transition ""


ifThenElse : Bool -> a -> a -> a
ifThenElse condition if_ then_ =
    if condition then
        if_

    else
        then_


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
    , badgeShape : Int
    , badgeSize : Int
    , largeBadgeShape : Int
    , largeBadgeSize : Int
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
        , badgeShape = 3
        , badgeSize = 6
        , largeBadgeShape = 8
        , largeBadgeSize = 16
        , paddingBetweenEdgeAndActiveIndicator = 12
        , paddingbetweenActiveIndicatorAndLabelText = 4
        , paddingBetweenDestinationItems = 12
        }
    }


render :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> Navigation btnC key msg
    -> Element msg
render typescale colorscheme theme attrs nav =
    let
        props =
            OUI.Navigation.properties nav

        isDrawer =
            props.mode /= OUI.Navigation.Rail

        width =
            if isDrawer then
                theme.drawer.containerWidth

            else
                theme.rail.containerWidth
    in
    Keyed.column
        [ Background.color <| OUI.Material.Color.toElementColor colorscheme.surfaceContainerLow
        , Element.width <| Element.px width
        , Element.height <| Element.fill
        , transitionAllEaseOut
        ]
    <|
        [-- image header
         -- text header
         -- fab
        ]
            ++ List.indexedMap
                (\i entry ->
                    ( String.fromInt i
                    , renderEntry typescale colorscheme theme props entry
                    )
                )
                props.entries


renderEntry :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Theme
    -> OUI.Navigation.NavigationProperties btnC key msg
    -> OUI.Navigation.Entry key
    -> Element msg
renderEntry typescale colorscheme theme props entry =
    let
        isDrawer =
            props.mode /= OUI.Navigation.Rail
    in
    case entry of
        OUI.Navigation.Entry key { label, icon, badge } ->
            let
                isActive =
                    props.selected == Just key
            in
            if isDrawer then
                let
                    badgeEl =
                        badge
                            |> Maybe.map
                                (\text ->
                                    let
                                        large =
                                            text /= ""
                                    in
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
                                            |> OUI.Material.Typography.renderWithAttrs typescale
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
                            , Element.mouseOver
                                [ Background.color <| OUI.Material.Color.getElementColor props.activeColor colorscheme
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
                                            colorscheme.onSurfaceVariant
                                            [ transitionAllEaseOut
                                            , Element.inFront badgeEl
                                            ]
                                            icon
                                      )
                                    , ( "label"
                                      , OUI.Text.labelLarge label
                                            |> OUI.Material.Typography.renderWithAttrs typescale
                                                [ transitionAllEaseOut
                                                ]
                                      )
                                    ]
                            }
                      )
                    ]

            else
                let
                    badgeEl =
                        badge
                            |> Maybe.map
                                (\text ->
                                    let
                                        large =
                                            text /= ""
                                    in
                                    Element.el
                                        ([ Element.paddingXY
                                            (ifThenElse large (theme.rail.largeBadgeShape // 2) 0)
                                            0
                                         , Element.height <|
                                            Element.px <|
                                                ifThenElse large
                                                    theme.rail.largeBadgeSize
                                                    theme.rail.badgeSize
                                         , Element.width <|
                                            ifThenElse large
                                                (Element.minimum theme.rail.largeBadgeSize <| Element.shrink)
                                                (Element.px theme.rail.badgeSize)
                                         , Border.rounded <|
                                            ifThenElse large
                                                theme.rail.largeBadgeShape
                                                theme.rail.badgeShape
                                         , Background.color <| toElementColor colorscheme.error
                                         , Font.color <| toElementColor colorscheme.onError
                                         , transitionAllEaseOut
                                         ]
                                            ++ ifThenElse large
                                                [ Element.moveRight <|
                                                    toFloat <|
                                                        theme.rail.iconSize
                                                            // 2
                                                , Element.alignLeft
                                                , Element.alignBottom
                                                , Element.moveUp <|
                                                    toFloat <|
                                                        theme.rail.iconSize
                                                            // 2
                                                ]
                                                [ Element.alignRight
                                                , Element.alignTop
                                                ]
                                        )
                                        (ifThenElse large
                                            (OUI.Text.labelSmall text
                                                |> OUI.Material.Typography.renderWithAttrs typescale
                                                    [ Element.centerX
                                                    , Element.centerY
                                                    ]
                                            )
                                            Element.none
                                        )
                                )
                            |> Maybe.withDefault Element.none
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
                            , Element.mouseOver
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
                                                colorscheme.onSurfaceVariant
                                                [ transitionAllEaseOut
                                                , Element.centerX
                                                , Element.inFront badgeEl
                                                ]
                                                icon
                                      )
                                    , ( "label"
                                      , Element.el
                                            [ transitionAllEaseOut
                                            , Element.width <| Element.px theme.rail.activeIndicatorWidth
                                            ]
                                            (OUI.Text.labelMedium
                                                label
                                                |> OUI.Material.Typography.renderWithAttrs typescale
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
                    |> OUI.Material.Typography.renderWithAttrs typescale
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
            Element.none
