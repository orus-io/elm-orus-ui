module OUI.Material exposing
    ( text, icon, divider, badge, progress
    , button, checkbox, switch, textField, radiobutton, menu, tabs
    , menuButton, navigation
    )

{-| A elm-ui based renderer API


# Basics

@docs text, icon, divider, badge, progress


# Inputs

@docs button, checkbox, switch, textField, radiobutton, menu, tabs


# Complex

@docs menuButton, navigation

-}

import Element exposing (Attribute, Element)
import OUI.Badge
import OUI.Button
import OUI.Checkbox
import OUI.Divider
import OUI.Icon exposing (Icon)
import OUI.Material.Badge
import OUI.Material.Button
import OUI.Material.Checkbox
import OUI.Material.Divider
import OUI.Material.Icon
import OUI.Material.Menu
import OUI.Material.MenuButton
import OUI.Material.Navigation
import OUI.Material.Progress
import OUI.Material.RadioButton
import OUI.Material.Switch
import OUI.Material.Tabs
import OUI.Material.TextField
import OUI.Material.Theme as Theme exposing (Theme)
import OUI.Material.Typography
import OUI.Menu
import OUI.MenuButton
import OUI.Navigation
import OUI.Progress
import OUI.RadioButton
import OUI.Switch
import OUI.Tabs
import OUI.Text
import OUI.TextField


{-| Render a text
-}
text :
    Theme themeExt
    -> OUI.Text.Text
    -> Element msg
text theme =
    OUI.Material.Typography.render (Theme.typescale theme) (Theme.colorscheme theme)


{-| Render a badge
-}
badge :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Badge.Badge
    -> Attribute msg
badge theme =
    OUI.Material.Badge.render
        (Theme.typescale theme)
        (Theme.colorscheme theme)
        (Theme.badge theme)


{-| Render a button
-}
button :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Button.Button { constraints | hasAction : () } msg
    -> Element msg
button theme =
    OUI.Material.Button.render
        (Theme.typescale theme)
        (Theme.colorscheme theme)
        (Theme.button theme)
        Nothing


{-| Render an icon
-}
icon :
    Theme themeExt
    -> List (Attribute msg)
    -> Icon
    -> Element msg
icon theme =
    OUI.Material.Icon.render (Theme.colorscheme theme)


{-| Render a checkbox
-}
checkbox :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Checkbox.Checkbox { hasAction : (), withChecked : () } msg
    -> Element msg
checkbox theme =
    OUI.Material.Checkbox.render (Theme.colorscheme theme) (Theme.checkbox theme)


{-| Render a menu
-}
menu :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Menu.Menu item msg
    -> Element msg
menu theme =
    OUI.Material.Menu.render
        (Theme.typescale theme)
        (Theme.colorscheme theme)
        (Theme.divider theme)
        (Theme.menu theme)
        -1


{-| Render a menu button
-}
menuButton :
    Theme themeExt
    -> OUI.MenuButton.State
    -> List (Attribute msg)
    -> OUI.MenuButton.MenuButton btnC item msg
    -> Element msg
menuButton theme =
    OUI.Material.MenuButton.render
        (Theme.typescale theme)
        (Theme.colorscheme theme)
        (Theme.button theme)
        (Theme.divider theme)
        (Theme.menu theme)


{-| Render a navigation trail/drawer
-}
navigation :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Navigation.Navigation btnC key msg
    -> Element msg
navigation theme =
    OUI.Material.Navigation.render
        (Theme.typescale theme)
        (Theme.colorscheme theme)
        (Theme.divider theme)
        (Theme.navigation theme)


{-| Render a progress
-}
progress :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Progress.Progress
    -> Element msg
progress theme =
    OUI.Material.Progress.render
        (Theme.colorscheme theme)
        (Theme.progress theme)


{-| Render a radiobutton
-}
radiobutton :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.RadioButton.RadioButton { hasAction : (), withSelected : () } msg
    -> Element msg
radiobutton theme =
    OUI.Material.RadioButton.render
        (Theme.colorscheme theme)
        (Theme.radiobutton theme)


{-| Render a Switch
-}
switch :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Switch.Switch msg
    -> Element msg
switch theme =
    OUI.Material.Switch.render
        (Theme.colorscheme theme)
        (Theme.switch theme)


{-| Render a Tabs
-}
tabs :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.Tabs.Tabs key item msg
    -> Element msg
tabs theme =
    OUI.Material.Tabs.render
        (Theme.typescale theme)
        (Theme.colorscheme theme)
        (Theme.badge theme)
        (Theme.tabs theme)


{-| Render a TextField
-}
textField :
    Theme themeExt
    -> List (Attribute msg)
    -> OUI.TextField.TextField msg
    -> Element msg
textField theme =
    OUI.Material.TextField.render
        (Theme.typescale theme)
        (Theme.colorscheme theme)
        (Theme.button theme)
        (Theme.textfield theme)


{-| Render a divider
-}
divider : Theme themeExt -> List (Attribute msg) -> OUI.Divider.Divider -> Element msg
divider theme =
    OUI.Material.Divider.render
        (Theme.colorscheme theme)
        (Theme.divider theme)
