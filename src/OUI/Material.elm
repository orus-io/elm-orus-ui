module OUI.Material exposing (text, button, checkbox, icon, switch, textField)

{-| A elm-ui based renderer API

@docs text, button, checkbox, icon, switch, textField

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
text : Theme -> OUI.Text.Text -> Element msg
text { typescale } =
    OUI.Material.Typography.render typescale


{-| Render a button
-}
button :
    Theme
    -> List (Attribute msg)
    -> OUI.Button.Button { constraints | hasAction : () } msg
    -> Element msg
button theme =
    OUI.Material.Button.render theme.typescale theme.colorscheme theme.button


{-| Render an icon
-}
icon : Theme -> List (Attribute msg) -> Icon -> Element msg
icon { colorscheme } =
    OUI.Material.Icon.render colorscheme


{-| Render a checkbox
-}
checkbox : Theme -> List (Attribute msg) -> OUI.Checkbox.Checkbox { hasAction : (), withChecked : () } msg -> Element msg
checkbox theme =
    OUI.Material.Checkbox.render theme.colorscheme theme.checkbox


{-| Render a Switch
-}
switch : Theme -> List (Attribute msg) -> OUI.Switch.Switch msg -> Element msg
switch theme =
    OUI.Material.Switch.render theme.colorscheme theme.switch


{-| Render a TextField
-}
textField : Theme -> List (Attribute msg) -> OUI.TextField.TextField msg -> Element msg
textField theme =
    OUI.Material.TextField.render theme.typescale theme.colorscheme theme.button theme.textfield
