module OUI.Material.Theme exposing
    ( Theme, defaultTheme
    , Typescale, Typography, defaultTypescale, typescale, withTypescale
    , colorscheme, withColorscheme
    , ext, withExt
    , BadgeTheme, badge, withBadge
    , ButtonTheme, ButtonLayout, ButtonFABLayout, ButtonIconLayout, button, withButton
    , CheckboxTheme, checkbox, withCheckbox
    , DialogTheme, dialog, withDialog
    , DividerTheme, divider, withDivider
    , MenuTheme, menu, withMenu
    , NavigationTheme, navigation, withNavigation
    , ProgressTheme, progress, withProgress
    , RadioButtonTheme, radiobutton, withRadiobutton
    , SliderTheme, slider, withSlider
    , SwitchTheme, switch, withSwitch
    , TabsTheme, tabs, withTabs
    , TextFieldTheme, textfield, withTextfield
    , TimePickerTheme, timepicker, withTimepicker
    )

{-|


# Constructor

@docs Theme, defaultTheme


# Core properties


## Typescale

@docs Typescale, Typography, defaultTypescale, typescale, withTypescale


## Color scheme

@docs colorscheme, withColorscheme


## Extension

@docs ext, withExt


# Component themes


## Badge

@docs BadgeTheme, badge, withBadge


## Button

@docs ButtonTheme, ButtonLayout, ButtonFABLayout, ButtonIconLayout, button, withButton


## Checkbox

@docs CheckboxTheme, checkbox, withCheckbox


## Dialog

@docs DialogTheme, dialog, withDialog


## Divider

@docs DividerTheme, divider, withDivider


## Menu

@docs MenuTheme, menu, withMenu


## Navigation

@docs NavigationTheme, navigation, withNavigation


## Progress

@docs ProgressTheme, progress, withProgress


## Radio button

@docs RadioButtonTheme, radiobutton, withRadiobutton


## Slider

@docs SliderTheme, slider, withSlider


## Switch

@docs SwitchTheme, switch, withSwitch


## Tabs

@docs TabsTheme, tabs, withTabs


## TextField

@docs TextFieldTheme, textfield, withTextfield


## TimePicker

@docs TimePickerTheme, timepicker, withTimepicker

-}

import OUI
import OUI.Icon
import OUI.Material.Badge
import OUI.Material.Button
import OUI.Material.Checkbox
import OUI.Material.Color
import OUI.Material.Dialog
import OUI.Material.Divider
import OUI.Material.Menu
import OUI.Material.Navigation
import OUI.Material.Progress
import OUI.Material.RadioButton
import OUI.Material.Slider
import OUI.Material.Switch
import OUI.Material.Tabs
import OUI.Material.TextField
import OUI.Material.TimePicker
import OUI.Text


{-| A badge theme
-}
type alias BadgeTheme =
    { small :
        { shape : Int
        , size : Int

        -- position of the badge bottom left corner relative to the top right corner of the element
        , pos : ( Int, Int )
        }
    , large :
        { shape : Int
        , size : Int
        , padding : Int
        , textSize : OUI.Text.Size
        , textType : OUI.Text.Type
        , textColor : OUI.Text.Color

        -- position of the badge bottom left corner relative to the top right corner of the element
        , pos : ( Int, Int )
        }
    , color : OUI.Color
    }


{-| A normal button layout
-}
type alias ButtonLayout =
    { containerHeight : Int
    , containerRadius : Int
    , iconSize : Int
    , leftRightPadding : Int
    , leftPaddingWithIcon : Int
    , rightPaddingWithIcon : Int
    , paddingBetweenElements : Int
    , textType : OUI.Text.Type
    , textSize : OUI.Text.Size

    -- Label text alignment Center-aligned
    }


{-| A FAB button layout
-}
type alias ButtonFABLayout =
    { containerHeight : Int
    , containerShape : Int
    , containerWidth : Int
    , iconSize : Int
    }


{-| A Icon button layout
-}
type alias ButtonIconLayout =
    { iconSize : Int
    , containerSize : Int
    }


{-| A Button theme
-}
type alias ButtonTheme =
    { common : ButtonLayout
    , fab :
        { small : ButtonFABLayout
        , medium : ButtonFABLayout
        , large : ButtonFABLayout
        , extended : ButtonLayout
        }
    , icon : ButtonIconLayout
    }


{-| A Checkbox theme
-}
type alias CheckboxTheme =
    { containerWidth : Int
    , containerHeight : Int
    , containerShape : Int
    , iconSize : Int
    , stateLayerSize : Int
    }


{-| A Dialog theme
-}
type alias DialogTheme =
    { containerShape : Int
    , containerWidth : { min : Int, max : Int }
    , iconSize : Int
    , padding : Int
    , paddingBetweenButtons : Int
    , paddingBetweenIconAndTitle : Int
    , paddingBetweenTitleAndBody : Int
    , paddingBetweenBodyAndAction : Int
    , fsCloseIcon : OUI.Icon.Icon
    }


{-| A Divider theme
-}
type alias DividerTheme =
    { thickness : Int
    }


{-| A Menu theme
-}
type alias MenuTheme =
    { radius : Int
    , topBottomPadding : Int
    , leftRightPadding : Int
    , paddingWithinItem : Int
    , itemHeight : Int
    , iconSize : Int
    , minWidth : Int
    , maxWidth : Int
    }


{-| A Navigation theme
-}
type alias NavigationTheme =
    { drawer :
        { containerWidth : Int
        , iconSize : Int
        , activeIndicatorHeight : Int
        , activeIndicatorShape : Int
        , activeIndicatorWidth : Int
        , leftPadding : Int
        , rightPadding : Int
        , activeIndicatorPadding : Int
        , badgeRightPadding : Int
        , paddingBetweenElements : Int
        }
    , rail :
        { containerWidth : Int
        , destinationItemHeight : Int
        , activeIndicatorHeight : Int
        , activeIndicatorWidth : Int
        , activeIndicatorShape : Int
        , iconSize : Int
        , badgeTheme : BadgeTheme
        , paddingBetweenEdgeAndActiveIndicator : Int
        , paddingbetweenActiveIndicatorAndLabelText : Int
        , paddingBetweenDestinationItems : Int
        }
    }


{-| A Progress theme
-}
type alias ProgressTheme =
    { activeIndicator : { thickness : Int }
    , trackIndicator : { thickness : Int }
    , circularSize : Int
    }


{-| A RadioButton theme
-}
type alias RadioButtonTheme =
    { containerWidth : Int
    , containerHeight : Int
    , containerShape : Int
    , contentSize : Int
    , stateLayerSize : Int
    , borderWidth : Int
    }


{-| A Slider theme
-}
type alias SliderTheme =
    { trackHeight : Int
    , labelContainerHeight : Int
    , labelContainerWidth : Int
    , handleHeight : Int
    , handleWidth : Int
    }


{-| A Switch theme
-}
type alias SwitchTheme =
    { track :
        { height : Int
        , width : Int
        , outlineWidth : Int
        , corner : Int
        }
    , thumb :
        { size :
            { unselected : Int
            , withIcon : Int
            , selected : Int
            , pressed : Int
            }
        }
    , stateLayer :
        { size : Int
        }
    , icon :
        { sizeUnselected : Int
        , sizeSelected : Int
        }
    }


{-| A Tabs theme
-}
type alias TabsTheme =
    { primary :
        { containerHeight : Int
        , activeIndicatorHeight : Int
        , activeIndicatorWidth : Int
        }
    , secondary :
        { containerHeight : Int
        , activeIndicatorHeight : Int
        }
    , paddingBetweenIconAndText : Int
    , paddingBetweenInlineIconAndText : Int
    , paddingBetweenInlineTextAndBadge : Int
    , text :
        { size : OUI.Text.Size
        , type_ : OUI.Text.Type
        }
    , color :
        { selected : OUI.Color
        }
    }


{-| A TextField theme
-}
type alias TextFieldTheme =
    { height : Int
    , leftRightPaddingWithoutIcon : Int
    , leftRightPaddingWithIcon : Int
    , paddingBetweenIconAndText : Int
    , supportingTextTopPadding : Int
    , paddingBetweenSupportingTextAndCharacterCounter : Int
    , iconSize : Int
    , filled :
        { topBottomPadding : Int
        }
    , outlined :
        { labelLeftRightPadding : Int
        , labelBottom : Int
        , shape : Int
        }
    }


{-| A TimePicker theme
-}
type alias TimePickerTheme =
    {}


{-| A font type
-}
type alias Typography =
    { font : String
    , lineHeight : Int
    , size : Int
    , tracking : Float
    , weight : Int
    }


{-| A font typescale
-}
type alias Typescale =
    { display :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    , headline :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    , title :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    , label :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    , body :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    }


{-| A material theme

Contains a color scheme, a typescale, and layouts for all the components

It can also carry a custom extension to store your own components theme, extra
colors, or anything that makes sense in your application

-}
type Theme ext
    = Theme
        { colorscheme : OUI.Material.Color.Scheme
        , typescale : Typescale
        , badge : BadgeTheme
        , button : ButtonTheme
        , checkbox : CheckboxTheme
        , dialog : DialogTheme
        , divider : DividerTheme
        , menu : MenuTheme
        , navigation : NavigationTheme
        , progress : ProgressTheme
        , slider : SliderTheme
        , switch : SwitchTheme
        , tabs : TabsTheme
        , textfield : TextFieldTheme
        , timepicker : TimePickerTheme
        , radiobutton : RadioButtonTheme
        , ext : ext
        }


{-| get the color [Scheme](OUI-Material-Color#Scheme)
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


{-| get the badge theme
-}
badge : Theme ext -> BadgeTheme
badge (Theme t) =
    t.badge


{-| get the checkbox theme
-}
checkbox : Theme ext -> CheckboxTheme
checkbox (Theme t) =
    t.checkbox


{-| get the dialog theme
-}
dialog : Theme ext -> DialogTheme
dialog (Theme t) =
    t.dialog


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


{-| get the progress theme
-}
progress : Theme ext -> ProgressTheme
progress (Theme t) =
    t.progress


{-| get the slider theme
-}
slider : Theme ext -> SliderTheme
slider (Theme t) =
    t.slider


{-| get the switch theme
-}
switch : Theme ext -> SwitchTheme
switch (Theme t) =
    t.switch


{-| get the tabs theme
-}
tabs : Theme ext -> TabsTheme
tabs (Theme t) =
    t.tabs


{-| get the textfield theme
-}
textfield : Theme ext -> TextFieldTheme
textfield (Theme t) =
    t.textfield


{-| get the timepicker theme
-}
timepicker : Theme ext -> TimePickerTheme
timepicker (Theme t) =
    t.timepicker


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


{-| set the badge theme
-}
withBadge : BadgeTheme -> Theme ext -> Theme ext
withBadge value (Theme t) =
    Theme { t | badge = value }


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


{-| set the dialog theme
-}
withDialog : DialogTheme -> Theme ext -> Theme ext
withDialog value (Theme t) =
    Theme { t | dialog = value }


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
withProgress : ProgressTheme -> Theme ext -> Theme ext
withProgress value (Theme t) =
    Theme { t | progress = value }


{-| set the slider theme
-}
withSlider : SliderTheme -> Theme ext -> Theme ext
withSlider value (Theme t) =
    Theme { t | slider = value }


{-| set the switch theme
-}
withSwitch : SwitchTheme -> Theme ext -> Theme ext
withSwitch value (Theme t) =
    Theme { t | switch = value }


{-| set the tabs theme
-}
withTabs : TabsTheme -> Theme ext -> Theme ext
withTabs value (Theme t) =
    Theme { t | tabs = value }


{-| set the textfield theme
-}
withTextfield : TextFieldTheme -> Theme ext -> Theme ext
withTextfield value (Theme t) =
    Theme { t | textfield = value }


{-| set the timepicker theme
-}
withTimepicker : TimePickerTheme -> Theme ext -> Theme ext
withTimepicker value (Theme t) =
    Theme { t | timepicker = value }


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
        , badge = t.badge
        , button = t.button
        , divider = t.divider
        , dialog = t.dialog
        , checkbox = t.checkbox
        , menu = t.menu
        , navigation = t.navigation
        , progress = t.progress
        , radiobutton = t.radiobutton
        , slider = t.slider
        , switch = t.switch
        , tabs = t.tabs
        , textfield = t.textfield
        , timepicker = t.timepicker
        , ext = themeExt
        }


{-| The default Material 3 theme
-}
defaultTheme : Theme ()
defaultTheme =
    Theme
        { colorscheme = OUI.Material.Color.defaultLightScheme
        , typescale = defaultTypescale
        , badge = OUI.Material.Badge.defaultTheme
        , button = OUI.Material.Button.defaultTheme
        , divider = OUI.Material.Divider.defaultTheme
        , dialog = OUI.Material.Dialog.defaultTheme
        , checkbox = OUI.Material.Checkbox.defaultTheme
        , menu = OUI.Material.Menu.defaultTheme
        , navigation = OUI.Material.Navigation.defaultTheme
        , progress = OUI.Material.Progress.defaultTheme
        , radiobutton = OUI.Material.RadioButton.defaultTheme
        , slider = OUI.Material.Slider.defaultTheme
        , switch = OUI.Material.Switch.defaultTheme
        , tabs = OUI.Material.Tabs.defaultTheme
        , textfield = OUI.Material.TextField.defaultTheme
        , timepicker = OUI.Material.TimePicker.defaultTheme
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
