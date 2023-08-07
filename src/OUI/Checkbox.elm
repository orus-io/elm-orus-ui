module OUI.Checkbox exposing
    ( new, Checkbox
    , withIcon, withColor, withChecked, onChange, disabled
    , Properties, properties
    )

{-|


# Constructor

@docs new, Checkbox
@docs withIcon, withColor, withChecked, onChange, disabled


# Internals

@docs Properties, properties

-}

import OUI
import OUI.Icon exposing (Icon)


{-| -}
type alias Properties msg =
    { checked : Bool
    , icon : Icon
    , onChange : Maybe (Bool -> msg)
    , color : OUI.Color
    }


{-| A Checkbox component
-}
type Checkbox constraints msg
    = Checkbox (Properties msg)


{-| creates a checkbox. It must get a 'onChange' handler or be 'disabled'.
-}
new : Checkbox { needOnChangeOrDisabled : (), needChecked : () } msg
new =
    Checkbox
        { checked = False
        , icon = OUI.Icon.check
        , onChange = Nothing
        , color = OUI.Primary
        }


{-| Set the 'checked' state. It not used, the checkbox is 'undetermined'.
-}
withChecked : Bool -> Checkbox { a | needChecked : () } msg -> Checkbox { a | withChecked : () } msg
withChecked checked (Checkbox props) =
    Checkbox
        { props
            | checked = checked
        }


{-| Change the check icon used at rendering
-}
withIcon : Icon -> Checkbox a msg -> Checkbox a msg
withIcon icon (Checkbox props) =
    Checkbox
        { props
            | icon = icon
        }


{-| Change the checkbox color
-}
withColor : OUI.Color -> Checkbox a msg -> Checkbox a msg
withColor color (Checkbox props) =
    Checkbox
        { props
            | color = color
        }


{-| Set a change handler msg
-}
onChange :
    (Bool -> msg)
    -> Checkbox { a | needOnChangeOrDisabled : () } msg
    -> Checkbox { a | hasAction : () } msg
onChange msg (Checkbox props) =
    Checkbox
        { props
            | onChange = Just msg
        }


{-| disable the checkbox
-}
disabled :
    Checkbox { a | needOnChangeOrDisabled : () } msg
    -> Checkbox { a | hasAction : () } msg
disabled (Checkbox props) =
    Checkbox props


{-| -}
properties :
    Checkbox { a | hasAction : (), withChecked : () } msg
    -> Properties msg
properties (Checkbox props) =
    props
