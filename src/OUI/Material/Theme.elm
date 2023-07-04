module OUI.Material.Theme exposing
    ( Theme, defaultTheme, Typescale, defaultTypescale
    , ButtonTheme, CheckboxTheme, DividerTheme, MenuTheme, NavigationTheme, SwitchTheme, TextFieldTheme, RadioButtonTheme
    )

{-|

@docs Theme, defaultTheme, Typescale, defaultTypescale

@docs ButtonTheme, CheckboxTheme, DividerTheme, MenuTheme, NavigationTheme, SwitchTheme, TextFieldTheme, RadioButtonTheme

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
type alias Theme ext =
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
    , ext : Maybe ext
    }


{-| The default Material 3 theme
-}
defaultTheme : Theme ext
defaultTheme =
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
    , ext = Nothing
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
