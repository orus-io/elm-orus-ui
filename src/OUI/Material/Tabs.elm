module OUI.Material.Tabs exposing (Theme, defaultTheme, render)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Input as Input
import OUI
import OUI.Badge exposing (Badge)
import OUI.Icon as Icon exposing (Icon)
import OUI.Material.Badge
import OUI.Material.Color
import OUI.Material.Icon
import OUI.Material.Typography
import OUI.Tabs exposing (Tabs)
import OUI.Text


type alias Theme =
    { primary :
        { containerHeight : Int
        , activeIndicatorHeight : Int
        , activeIndicatorWidth : Int
        }
    , secondary :
        { containerHeight : Int
        , activeIndicatorHeight : Int
        }
    , paddingBetweenIconAndText : Int
    , paddingBetweenInlineIconAndText : Int
    , paddingBetweenInlineTextAndBadge : Int
    , text :
        { size : OUI.Text.Size
        , type_ : OUI.Text.Type
        }
    , color :
        { selected : OUI.Color
        }
    }


defaultTheme : Theme
defaultTheme =
    { primary =
        { containerHeight = 64
        , activeIndicatorHeight = 3
        , activeIndicatorWidth = 36
        }
    , secondary =
        { containerHeight = 48
        , activeIndicatorHeight = 2
        }
    , paddingBetweenIconAndText = 4
    , paddingBetweenInlineIconAndText = 8
    , paddingBetweenInlineTextAndBadge = 4
    , text =
        { size = OUI.Text.Small
        , type_ = OUI.Text.Title
        }
    , color =
        { selected = OUI.Primary
        }
    }


renderPrimaryItem :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> OUI.Material.Badge.Theme
    -> Theme
    ->
        { text : String
        , icon : Icon
        , badge : Maybe Badge
        , selected : Bool
        , onClick : msg
        , color : OUI.Color
        }
    -> Element msg
renderPrimaryItem typescale colorscheme btheme theme { text, icon, badge, selected, onClick, color } =
    Input.button
        [ Element.width Element.fill
        , Element.height <| Element.px <| theme.primary.containerHeight - 1
        , Element.focused
            [ (if selected then
                OUI.Material.Color.getSurfaceColor color colorscheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorscheme)
                        OUI.Material.Color.focusStateLayerOpacity

               else
                OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getOnSurfaceColor color colorscheme)
                        OUI.Material.Color.focusStateLayerOpacity
              )
                |> OUI.Material.Color.toElementColor
                |> Background.color
            ]
        , Element.mouseOver
            [ (if selected then
                OUI.Material.Color.getSurfaceColor color colorscheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorscheme)
                        OUI.Material.Color.hoverStateLayerOpacity

               else
                OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getOnSurfaceColor color colorscheme)
                        OUI.Material.Color.hoverStateLayerOpacity
              )
                |> OUI.Material.Color.toElementColor
                |> Background.color
            ]
        ]
        { onPress = Just onClick
        , label =
            Element.column
                [ Element.width Element.fill
                , Element.spacing theme.paddingBetweenIconAndText
                , Element.height <| Element.px <| theme.primary.containerHeight - 1
                ]
            <|
                [ OUI.Material.Icon.render colorscheme
                    ([ Element.centerX
                     , Element.centerY
                     ]
                        ++ (case badge of
                                Just b ->
                                    [ OUI.Material.Badge.render
                                        typescale
                                        colorscheme
                                        btheme
                                        []
                                        b
                                    ]

                                Nothing ->
                                    []
                           )
                    )
                    icon
                , Element.text text
                    |> Element.el
                        [ Element.centerX
                        , Element.centerY
                        ]
                , Element.el
                    [ Element.height <| Element.px theme.primary.activeIndicatorHeight
                    , Element.width <| Element.px theme.primary.activeIndicatorWidth
                    , Background.color <|
                        if selected then
                            OUI.Material.Color.getElementColor theme.color.selected colorscheme

                        else
                            OUI.Material.Color.getSurfaceColor theme.color.selected colorscheme
                                |> OUI.Material.Color.setAlpha 0
                                |> OUI.Material.Color.toElementColor
                    , Border.roundEach
                        { topLeft = theme.primary.activeIndicatorHeight
                        , topRight = theme.primary.activeIndicatorHeight
                        , bottomLeft = 0
                        , bottomRight = 0
                        }
                    , Element.alignBottom
                    , Element.centerX
                    ]
                    Element.none
                ]
        }


renderSecondaryItem :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> OUI.Material.Badge.Theme
    -> Theme
    ->
        { text : String
        , icon : Maybe Icon
        , badge : Maybe Badge
        , selected : Bool
        , onClick : msg
        , color : OUI.Color
        }
    -> Element msg
renderSecondaryItem typescale colorscheme btheme theme { text, icon, badge, selected, onClick, color } =
    Input.button
        [ Element.width Element.fill
        , Element.height <| Element.px <| theme.secondary.containerHeight - 1
        , Border.widthEach
            { bottom = theme.secondary.activeIndicatorHeight
            , top = 0
            , left = 0
            , right = 0
            }
        , Border.color <|
            if selected then
                OUI.Material.Color.getElementColor theme.color.selected colorscheme

            else
                OUI.Material.Color.getColor theme.color.selected colorscheme
                    |> OUI.Material.Color.setAlpha 0
                    |> OUI.Material.Color.toElementColor
        , Element.focused
            [ (if selected then
                OUI.Material.Color.getSurfaceColor color colorscheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorscheme)
                        OUI.Material.Color.focusStateLayerOpacity

               else
                OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getOnSurfaceColor color colorscheme)
                        OUI.Material.Color.focusStateLayerOpacity
              )
                |> OUI.Material.Color.toElementColor
                |> Background.color
            ]
        , Element.mouseOver
            [ (if selected then
                OUI.Material.Color.getSurfaceColor color colorscheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getColor color colorscheme)
                        OUI.Material.Color.hoverStateLayerOpacity

               else
                OUI.Material.Color.getSurfaceContainerLowColor color colorscheme
                    |> OUI.Material.Color.withShade
                        (OUI.Material.Color.getOnSurfaceColor color colorscheme)
                        OUI.Material.Color.hoverStateLayerOpacity
              )
                |> OUI.Material.Color.toElementColor
                |> Background.color
            ]
        ]
        { onPress = Just onClick
        , label =
            Element.row [ Element.width Element.fill ] <|
                (case icon of
                    Nothing ->
                        []

                    Just i ->
                        [ OUI.Material.Icon.render colorscheme
                            [ Element.centerX
                            , Element.centerY
                            ]
                            i
                        , Element.el [ Element.width <| Element.px theme.paddingBetweenInlineIconAndText ]
                            Element.none
                        ]
                )
                    ++ [ Element.text text
                            |> Element.el [ Element.centerX, Element.moveDown 1 ]
                       ]
                    ++ (case badge of
                            Just b ->
                                [ Element.el
                                    [ Element.width <| Element.px theme.paddingBetweenInlineTextAndBadge
                                    , Element.centerX
                                    ]
                                    Element.none
                                , OUI.Material.Badge.renderBadge typescale
                                    colorscheme
                                    btheme
                                    [ Element.centerX
                                    , Element.centerY
                                    ]
                                    b
                                ]

                            Nothing ->
                                []
                       )
        }


render :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> OUI.Material.Badge.Theme
    -> Theme
    -> List (Attribute msg)
    -> Tabs key item msg
    -> Element msg
render typescale colorscheme btheme theme attrs tabs =
    let
        props :
            { type_ : OUI.Tabs.Type
            , items : List ( key, item )
            , itemToText : item -> String
            , itemToIcon : item -> Maybe Icon
            , itemToBadge : item -> Maybe Badge
            , selected : Maybe key
            , onClick : key -> msg
            , color : OUI.Color
            }
        props =
            OUI.Tabs.properties tabs

        isPrimary : Bool
        isPrimary =
            case props.type_ of
                OUI.Tabs.Primary ->
                    True

                OUI.Tabs.Secondary ->
                    False
    in
    props.items
        |> List.map
            (\( key, item ) ->
                if isPrimary then
                    renderPrimaryItem
                        typescale
                        colorscheme
                        btheme
                        theme
                        { text = props.itemToText item
                        , icon = props.itemToIcon item |> Maybe.withDefault Icon.blank
                        , badge = props.itemToBadge item
                        , selected = props.selected == Just key
                        , onClick = props.onClick key
                        , color = props.color
                        }

                else
                    renderSecondaryItem
                        typescale
                        colorscheme
                        btheme
                        theme
                        { text = props.itemToText item
                        , icon = props.itemToIcon item
                        , badge = props.itemToBadge item
                        , selected = props.selected == Just key
                        , onClick = props.onClick key
                        , color = props.color
                        }
            )
        |> Element.row
            ([ Element.height <|
                Element.px <|
                    if isPrimary then
                        theme.primary.containerHeight

                    else
                        theme.secondary.containerHeight
             , Border.widthEach
                { bottom = 1
                , left = 0
                , right = 0
                , top = 0
                }
             , Border.color <| OUI.Material.Color.toElementColor colorscheme.surfaceVariant
             ]
                ++ OUI.Material.Typography.attrs
                    theme.text.type_
                    theme.text.size
                    (OUI.Text.Custom colorscheme.onSurfaceVariant)
                    typescale
                    colorscheme
                ++ attrs
            )
