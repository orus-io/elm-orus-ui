module OUI.Material.Menu exposing (Theme, defaultTheme, passiveOnClick, render)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Html.Events
import Json.Decode as Json
import OUI.Icon exposing (Icon)
import OUI.Material.Color
import OUI.Material.Icon as Icon
import OUI.Material.Typography
import OUI.Menu exposing (Menu)
import OUI.Text


type alias Theme =
    { radius : Int
    , topBottomPadding : Int
    , leftRightPadding : Int
    , paddingWithinItem : Int
    , itemHeight : Int
    , iconSize : Int
    , minWidth : Int
    , maxWidth : Int
    }


defaultTheme : Theme
defaultTheme =
    { radius = 4
    , topBottomPadding = 8
    , leftRightPadding = 12
    , paddingWithinItem = 12
    , itemHeight = 48
    , iconSize = 24
    , minWidth = 112
    , maxWidth = 280
    }


render :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> Menu item msg
    -> Element msg
render typescale colorscheme theme attrs menu =
    let
        props :
            { items : List item
            , itemToText : item -> String
            , itemToIcon : item -> Maybe Icon
            , itemToTrailingIcon : item -> Maybe Icon
            , itemSelected : item -> Bool
            , onClick : Maybe (item -> msg)
            , textType : OUI.Text.Type
            , textSize : OUI.Text.Size
            }
        props =
            OUI.Menu.properties menu

        {- True if any entry as a leading icon -}
        hasLeadingIcons : Bool
        hasLeadingIcons =
            props.items
                |> List.foldl (\i r -> r || props.itemToIcon i /= Nothing) False

        {- Buggy way to avaluate how much width we need -}
        widthApprox : Int
        widthApprox =
            props.items
                |> List.foldl (\i r -> max r <| (props.itemToText i |> String.length) * 10) 0
                |> (+) 48
    in
    Element.column
        (attrs
            ++ [ Element.paddingXY 0 theme.topBottomPadding
               , Border.rounded theme.radius
               , Border.shadow
                    { offset = ( 1, 1 )
                    , size = 1
                    , blur = 1
                    , color = OUI.Material.Color.toElementColor colorscheme.shadow
                    }
               , colorscheme.surfaceContainer
                    |> OUI.Material.Color.toElementColor
                    |> Background.color
               , colorscheme.onSurface
                    |> OUI.Material.Color.toElementColor
                    |> Font.color
               , Element.px widthApprox
                    |> Element.minimum theme.minWidth
                    |> Element.maximum theme.maxWidth
                    |> Element.width
               ]
            ++ OUI.Material.Typography.attrs props.textType props.textSize typescale
        )
        (props.items
            |> List.map
                (\item ->
                    Element.row
                        ([ Element.height <| Element.px theme.itemHeight
                         , Element.width Element.fill
                         , Element.paddingXY theme.leftRightPadding 0
                         , Element.spacing theme.paddingWithinItem
                         , Element.mouseOver
                            [ colorscheme.surfaceContainer
                                |> OUI.Material.Color.withShade colorscheme.onSurface
                                    OUI.Material.Color.hoverStateLayerOpacity
                                |> OUI.Material.Color.toElementColor
                                |> Background.color
                            ]
                         ]
                            ++ (case props.onClick of
                                    Just msg ->
                                        [ passiveOnClick <| msg item ]

                                    Nothing ->
                                        []
                               )
                        )
                        ((if hasLeadingIcons then
                            [ props.itemToIcon item
                                |> Maybe.withDefault OUI.Icon.blank
                                |> Icon.renderWithSizeColor theme.iconSize colorscheme.onSurface []
                            ]

                          else
                            []
                         )
                            ++ [ Element.text (props.itemToText item)
                               , props.itemToTrailingIcon item
                                    |> Maybe.withDefault OUI.Icon.blank
                                    |> Icon.renderWithSizeColor theme.iconSize colorscheme.onSurface [ Element.alignRight ]
                               ]
                        )
                )
        )


passiveOnClick : msg -> Attribute msg
passiveOnClick msg =
    Html.Events.stopPropagationOn "click" (Json.succeed ( msg, True ))
        |> Element.htmlAttribute
