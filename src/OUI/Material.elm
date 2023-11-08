module OUI.Material exposing
    ( text, icon
    , button, checkbox, switch, textField, radiobutton
    , navigation
    , menu, menuButton
    )

{-| A elm-ui based renderer API


# Basics

@docs text, icon


# Inputs

@docs button, checkbox, switch, textField, radiobutton


# Complex

@docs navigation

-}

import Color
import Element exposing (Attribute, Element)
import OUI.Button
import OUI.Checkbox
import OUI.Icon exposing (Icon)
import OUI.Material.Button
import OUI.Material.Checkbox
import OUI.Material.Color
import OUI.Material.Icon
import OUI.Material.Menu
import OUI.Material.MenuButton
import OUI.Material.Navigation
import OUI.Material.RadioButton
import OUI.Material.Switch
import OUI.Material.TextField
import OUI.Material.Theme exposing (Theme, Typescale)
import OUI.Material.Typography
import OUI.Menu
import OUI.MenuButton
import OUI.Navigation
import OUI.RadioButton
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
text :
    Theme themeExt
    -> OUI.Text.Text
    -> Element msg
text { typescale } =
    OUI.Material.Typography.render typescale


{-| Render a button
-}
button :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Button.Button { constraints | hasAction : () } msg
    -> Element msg
button theme =
    OUI.Material.Button.render theme.typescale theme.colorscheme theme.button


{-| Render an icon
-}
icon :
    Theme themeExt
    -> List (Attribute msg)
    -> Icon
    -> Element msg
icon { colorscheme } =
    OUI.Material.Icon.render colorscheme


{-| Render a checkbox
-}
checkbox :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Checkbox.Checkbox { hasAction : (), withChecked : () } msg
    -> Element msg
checkbox theme =
    OUI.Material.Checkbox.render theme.colorscheme theme.checkbox


menu :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Menu.Menu item msg
    -> Element msg
menu theme =
    OUI.Material.Menu.render theme.typescale theme.colorscheme theme.menu


menuButton :
    Theme themeExt
    -> OUI.MenuButton.State
    -> List (Attribute msg)
    -> OUI.MenuButton.MenuButton btnC item msg
    -> Element msg
menuButton theme =
    OUI.Material.MenuButton.render theme.typescale theme.colorscheme theme.button theme.menu


{-| Render a navigation trail/drawer
-}
navigation :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Navigation.Navigation btnC key msg
    -> Element msg
navigation theme =
    OUI.Material.Navigation.render theme.typescale theme.colorscheme theme.navigation


{-| Render a radiobutton
-}
radiobutton :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.RadioButton.RadioButton { hasAction : (), withSelected : () } msg
    -> Element msg
radiobutton theme =
    OUI.Material.RadioButton.render theme.colorscheme theme.radiobutton


{-| Render a Switch
-}
switch :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Switch.Switch msg
    -> Element msg
switch theme =
    OUI.Material.Switch.render theme.colorscheme theme.switch


{-| Render a TextField
-}
textField :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.TextField.TextField msg
    -> Element msg
textField theme =
    OUI.Material.TextField.render theme.typescale theme.colorscheme theme.button theme.textfield
