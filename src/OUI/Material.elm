module OUI.Material exposing
    ( renderText, renderButton, renderCheckbox, renderIcon
    , toElementColor
    )

{-| A elm-ui based renderer API

@docs renderText, renderButton, renderCheckbox, renderIcon

@docs toElementColor

-}

import Color
import Element exposing (Attribute, Element)
import OUI.Button
import OUI.Checkbox
import OUI.Icon exposing (Icon)
import OUI.Material.Button
import OUI.Material.Checkbox
import OUI.Material.Icon
import OUI.Material.Theme exposing (Theme)
import OUI.Material.Typography
import OUI.Text


{-| Convert a color to a Element.color
-}
toElementColor : Color.Color -> Element.Color
toElementColor =
    Color.toRgba
        >> Element.fromRgb


{-| Render a text
-}
renderText : Theme -> OUI.Text.Text -> Element msg
renderText { typescale } text =
    OUI.Material.Typography.render typescale text


{-| Render a button
-}
renderButton :
    Theme
    -> List (Attribute msg)
    -> OUI.Button.Button { constraints | hasText : (), hasAction : () } msg
    -> Element msg
renderButton { typescale, colorscheme, button } =
    OUI.Material.Button.render typescale colorscheme button


{-| Render an icon
-}
renderIcon : Theme -> List (Attribute msg) -> Icon -> Element msg
renderIcon { colorscheme } =
    OUI.Material.Icon.render colorscheme


{-| Render a checkbox
-}
renderCheckbox : Theme -> List (Attribute msg) -> OUI.Checkbox.Checkbox { hasAction : (), withChecked : () } msg -> Element msg
renderCheckbox { colorscheme, checkbox } =
    OUI.Material.Checkbox.render colorscheme checkbox
