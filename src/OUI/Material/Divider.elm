module OUI.Material.Divider exposing (Theme, defaultTheme, render)

import Element exposing (Attribute, Element)
import Element.Background
import OUI.Divider exposing (Divider)
import OUI.Material.Color


type alias Theme =
    { thickness : Int
    }


defaultTheme : Theme
defaultTheme =
    { thickness = 1
    }


render :
    OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> Divider
    -> Element msg
render colorscheme theme attrs _ =
    let
        all_attrs : List (Attribute msg)
        all_attrs =
            [ Element.height <| Element.px theme.thickness
            , Element.Background.color <| OUI.Material.Color.toElementColor colorscheme.outlineVariant
            , Element.centerX
            ]
                ++ attrs
    in
    Element.none
        |> Element.el (all_attrs ++ [ Element.width Element.fill ])
