module OUI.Material.Divider exposing (..)

import Element exposing (Attribute, Element)
import Element.Background
import OUI
import OUI.Divider as Divider exposing (Divider)
import OUI.Material.Color


type alias Theme =
    { thickness : Int
    , margin : Int
    }


defaultTheme : Theme
defaultTheme =
    { thickness = 1
    , margin = 16
    }


render :
    OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> Divider
    -> Element msg
render colorscheme theme attrs divider =
    let
        properties =
            Divider.properties divider

        color =
            OUI.Material.Color.getColor
                (properties.color |> Maybe.withDefault OUI.Primary)
                colorscheme

        all_attrs =
            [ Element.height <| Element.px theme.thickness
            , Element.Background.color <| OUI.Material.Color.toElementColor color
            , Element.centerX
            ]
                ++ attrs
    in
    case properties.type_ of
        Divider.FullWidth ->
            Element.none
                |> Element.el (all_attrs ++ [ Element.width Element.fill ])

        Divider.Inset ->
            Element.row [ Element.width Element.fill ]
                [ Element.none
                    |> Element.el [ Element.width <| Element.px theme.margin ]
                , Element.none
                    |> Element.el (all_attrs ++ [ Element.width Element.fill ])
                , Element.none
                    |> Element.el [ Element.width <| Element.px theme.margin ]
                ]
