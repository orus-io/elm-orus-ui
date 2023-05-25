module OUI.Material exposing
    ( renderText, renderButton, renderCheckbox, renderIcon, renderSwitch, renderTextField
    , toElementColor
    )

{-| A elm-ui based renderer API

@docs renderText, renderButton, renderCheckbox, renderIcon, renderSwitch, renderTextField

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
import OUI.Material.Switch
import OUI.Material.TextField
import OUI.Material.Theme exposing (Theme)
import OUI.Material.Typography
import OUI.Switch
import OUI.Text
import OUI.TextField


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


{-| Render a Switch
-}
renderSwitch : Theme -> List (Attribute msg) -> OUI.Switch.Switch msg -> Element msg
renderSwitch { colorscheme, switch } =
    OUI.Material.Switch.render colorscheme switch


{-| Render a TextField
-}
renderTextField : Theme -> List (Attribute msg) -> OUI.TextField.TextField msg -> Element msg
renderTextField { typescale, colorscheme, textfield, button } =
    OUI.Material.TextField.render typescale colorscheme button textfield
