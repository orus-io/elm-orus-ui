module OUI.Material.Theme exposing
    ( Theme, defaultTheme, Typescale, defaultTypescale, withExt
    , ButtonTheme, CheckboxTheme, DividerTheme, MenuTheme, NavigationTheme, SwitchTheme, TextFieldTheme, RadioButtonTheme
    , colorscheme, typescale, button, checkbox, divider, menu, navigation, switch, textfield, radiobutton, ext
    , withButton, withCheckbox, withColorscheme, withDivider, withMenu, withNavigation, withRadiobutton, withSwitch, withTextfield, withTypescale
    )

{-|

@docs Theme, defaultTheme, Typescale, defaultTypescale, withExt

@docs ButtonTheme, CheckboxTheme, DividerTheme, MenuTheme, NavigationTheme, SwitchTheme, TextFieldTheme, RadioButtonTheme

@docs colorscheme, typescale, button, checkbox, divider, menu, navigation, switch, textfield, radiobutton, ext

@docs withButton, withCheckbox, withColorscheme, withDivider, withMenu, withNavigation, withRadiobutton, withSwitch, withTextfield, withTypescale

-}

import OUI.Material.Button
import OUI.Material.Checkbox
import OUI.Material.Color
import OUI.Material.Divider
import OUI.Material.Menu
import OUI.Material.Navigation
import OUI.Material.RadioButton
import OUI.Material.Switch
import OUI.Material.TextField
import OUI.Material.Typography


{-| A Button theme
-}
type alias ButtonTheme =
    OUI.Material.Button.Theme


{-| A RadioButton theme
-}
type alias RadioButtonTheme =
    OUI.Material.RadioButton.Theme


{-| A Checkbox theme
-}
type alias CheckboxTheme =
    OUI.Material.Checkbox.Theme


{-| A Menu theme
-}
type alias MenuTheme =
    OUI.Material.Menu.Theme


{-| A Navigation theme
-}
type alias NavigationTheme =
    OUI.Material.Navigation.Theme


{-| A Switch theme
-}
type alias SwitchTheme =
    OUI.Material.Switch.Theme


{-| A TextField theme
-}
type alias TextFieldTheme =
    OUI.Material.TextField.Theme


{-| A Divider theme
-}
type alias DividerTheme =
    OUI.Material.Divider.Theme


{-| A font typescale
-}
type alias Typescale =
    OUI.Material.Typography.Typescale


{-| A material theme

Contains a color scheme, a typescale, and layouts for all the components

-}
type Theme ext
    = Theme
        { colorscheme : OUI.Material.Color.Scheme
        , typescale : Typescale
        , button : ButtonTheme
        , checkbox : CheckboxTheme
        , divider : DividerTheme
        , menu : MenuTheme
        , navigation : NavigationTheme
        , switch : SwitchTheme
        , textfield : TextFieldTheme
        , radiobutton : RadioButtonTheme
        , ext : ext
        }


{-| get the coloscheme
-}
colorscheme : Theme ext -> OUI.Material.Color.Scheme
colorscheme (Theme t) =
    t.colorscheme


{-| get the typescale
-}
typescale : Theme ext -> Typescale
typescale (Theme t) =
    t.typescale


{-| get the button theme
-}
button : Theme ext -> ButtonTheme
button (Theme t) =
    t.button


{-| get the checkbox theme
-}
checkbox : Theme ext -> CheckboxTheme
checkbox (Theme t) =
    t.checkbox


{-| get the divider theme
-}
divider : Theme ext -> DividerTheme
divider (Theme t) =
    t.divider


{-| get the mene theme
-}
menu : Theme ext -> MenuTheme
menu (Theme t) =
    t.menu


{-| get the navigation theme
-}
navigation : Theme ext -> NavigationTheme
navigation (Theme t) =
    t.navigation


{-| get the switch theme
-}
switch : Theme ext -> SwitchTheme
switch (Theme t) =
    t.switch


{-| get the textfield theme
-}
textfield : Theme ext -> TextFieldTheme
textfield (Theme t) =
    t.textfield


{-| get the radiobutton theme
-}
radiobutton : Theme ext -> RadioButtonTheme
radiobutton (Theme t) =
    t.radiobutton


{-| get the theme extension
-}
ext : Theme ext -> ext
ext (Theme t) =
    t.ext


{-| set the colorscheme
-}
withColorscheme : OUI.Material.Color.Scheme -> Theme ext -> Theme ext
withColorscheme value (Theme t) =
    Theme { t | colorscheme = value }


{-| set the typescale
-}
withTypescale : Typescale -> Theme ext -> Theme ext
withTypescale value (Theme t) =
    Theme { t | typescale = value }


{-| set the button theme
-}
withButton : ButtonTheme -> Theme ext -> Theme ext
withButton value (Theme t) =
    Theme { t | button = value }


{-| set the checkbox theme
-}
withCheckbox : CheckboxTheme -> Theme ext -> Theme ext
withCheckbox value (Theme t) =
    Theme { t | checkbox = value }


{-| set the divider theme
-}
withDivider : DividerTheme -> Theme ext -> Theme ext
withDivider value (Theme t) =
    Theme { t | divider = value }


{-| set the menu theme
-}
withMenu : MenuTheme -> Theme ext -> Theme ext
withMenu value (Theme t) =
    Theme { t | menu = value }


{-| set the navigation theme
-}
withNavigation : NavigationTheme -> Theme ext -> Theme ext
withNavigation value (Theme t) =
    Theme { t | navigation = value }


{-| set the switch theme
-}
withSwitch : SwitchTheme -> Theme ext -> Theme ext
withSwitch value (Theme t) =
    Theme { t | switch = value }


{-| set the textfield theme
-}
withTextfield : TextFieldTheme -> Theme ext -> Theme ext
withTextfield value (Theme t) =
    Theme { t | textfield = value }


{-| set the radiobutton theme
-}
withRadiobutton : RadioButtonTheme -> Theme ext -> Theme ext
withRadiobutton value (Theme t) =
    Theme { t | radiobutton = value }


{-| set the theme extension
-}
withExt : ext -> Theme ext1 -> Theme ext
withExt themeExt (Theme t) =
    Theme
        { colorscheme = t.colorscheme
        , typescale = t.typescale
        , button = t.button
        , divider = t.divider
        , checkbox = t.checkbox
        , menu = t.menu
        , navigation = t.navigation
        , radiobutton = t.radiobutton
        , switch = t.switch
        , textfield = t.textfield
        , ext = themeExt
        }


{-| The default Material 3 theme
-}
defaultTheme : Theme ()
defaultTheme =
    Theme
        { colorscheme = OUI.Material.Color.defaultLightScheme
        , typescale = defaultTypescale
        , button = OUI.Material.Button.defaultTheme
        , divider = OUI.Material.Divider.defaultTheme
        , checkbox = OUI.Material.Checkbox.defaultTheme
        , menu = OUI.Material.Menu.defaultTheme
        , navigation = OUI.Material.Navigation.defaultTheme
        , radiobutton = OUI.Material.RadioButton.defaultTheme
        , switch = OUI.Material.Switch.defaultTheme
        , textfield = OUI.Material.TextField.defaultTheme
        , ext = ()
        }


{-| The default Material 3 Typescale
-}
defaultTypescale : Typescale
defaultTypescale =
    { display =
        { large =
            { font = "Roboto"
            , lineHeight = 54
            , size = 47
            , tracking = -0.125
            , weight = 400
            }
        , medium =
            { font = "Roboto"
            , lineHeight = 53
            , size = 45
            , tracking = 0
            , weight = 400
            }
        , small =
            { font = "Roboto"
            , lineHeight = 44
            , size = 36
            , tracking = 0
            , weight = 400
            }
        }
    , headline =
        { large =
            { font = "Roboto"
            , lineHeight = 40
            , size = 32
            , tracking = 0
            , weight = 400
            }
        , medium =
            { font = "Roboto"
            , lineHeight = 36
            , size = 28
            , tracking = 0
            , weight = 400
            }
        , small =
            { font = "Roboto"
            , lineHeight = 32
            , size = 24
            , tracking = 0
            , weight = 400
            }
        }
    , title =
        { large =
            { font = "Roboto"
            , lineHeight = 26
            , size = 22
            , tracking = 0
            , weight = 400
            }
        , medium =
            { font = "Roboto"
            , lineHeight = 24
            , size = 16
            , tracking = 0.15
            , weight = 500
            }
        , small =
            { font = "Roboto"
            , lineHeight = 20
            , size = 14
            , tracking = 0.1
            , weight = 500
            }
        }
    , label =
        { large =
            { font = "Roboto"
            , lineHeight = 20
            , size = 14
            , tracking = 0.1
            , weight = 500
            }
        , medium =
            { font = "Roboto"
            , lineHeight = 16
            , size = 12
            , tracking = 0.5
            , weight = 500
            }
        , small =
            { font = "Roboto"
            , lineHeight = 16
            , size = 11
            , tracking = 0.5
            , weight = 500
            }
        }
    , body =
        { large =
            { font = "Roboto"
            , lineHeight = 24
            , size = 16
            , tracking = 0.5
            , weight = 400
            }
        , medium =
            { font = "Roboto"
            , lineHeight = 20
            , size = 14
            , tracking = 0.25
            , weight = 400
            }
        , small =
            { font = "Roboto"
            , lineHeight = 16
            , size = 12
            , tracking = 0.4
            , weight = 400
            }
        }
    }
