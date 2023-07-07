module OUI.Material.Divider exposing (Theme, defaultTheme, render)

import Element exposing (Attribute, Element)
import Element.Background
import OUI.Divider as Divider exposing (Divider, Type)
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
        properties : { type_ : Type }
        properties =
            Divider.properties divider

        all_attrs : List (Attribute msg)
        all_attrs =
            [ Element.height <| Element.px theme.thickness
            , Element.Background.color <| OUI.Material.Color.toElementColor colorscheme.outlineVariant
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
