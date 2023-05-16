module OUI.Material exposing (..)

import Color
import Element exposing (Element)
import OUI.Material.Theme exposing (Theme)
import OUI.Material.Typography
import OUI.Text


toElementColor : Color.Color -> Element.Color
toElementColor =
    Color.toRgba
        >> Element.fromRgb


renderText : Theme -> OUI.Text.Text -> Element msg
renderText { typescale } text =
    OUI.Material.Typography.render typescale text
