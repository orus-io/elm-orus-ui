module OUI.Material exposing (..)

import Color
import Element exposing (Attribute, Element)
import OUI.Button
import OUI.Material.Button
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


renderButton :
    Theme
    -> List (Attribute msg)
    -> OUI.Button.Button { constraints | hasText : (), hasAction : () } msg
    -> Element msg
renderButton { typescale, colorscheme, button } =
    OUI.Material.Button.render typescale colorscheme button
