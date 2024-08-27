module OUI.Material.TimePicker exposing (Theme, defaultTheme, render)

import Element exposing (Attribute, Element)
import OUI.Material.Color as Color
import OUI.Material.Typography as Typography
import OUI.TimePicker exposing (TimePicker)


type alias Theme =
    {}


defaultTheme : Theme
defaultTheme =
    {}


render : Typography.Typescale -> Color.Scheme -> Theme -> OUI.TimePicker.State -> List (Attribute msg) -> TimePicker -> Element msg
render typescale colorscheme theme state attrs timepicker =
    Element.text "timepicker"
