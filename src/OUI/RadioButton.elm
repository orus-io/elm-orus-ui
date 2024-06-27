module OUI.RadioButton exposing
    ( RadioButton
    , new
    , withColor, withSelected, onChange, disabled
    , getColor, getOnChange, getSelected
    )

{-| A Radiobutton creation API

@docs RadioButton


# Constructor

@docs new


# Basic properties

@docs withColor, withSelected, onChange, disabled


# Internals

@docs getColor, getOnChange, getSelected

-}

import OUI


type alias Props msg =
    { selected : Bool
    , onChange : Maybe (Bool -> msg)
    , color : OUI.Color
    }


{-| A RadioButton component
-}
type RadioButton constraints msg
    = RadioButton (Props msg)


{-| creates a RadioButton. It must get a 'onChange' handler or be 'disabled'.
-}
new : RadioButton { needOnChangeOrDisabled : (), needSelected : () } msg
new =
    RadioButton
        { selected = False
        , onChange = Nothing
        , color = OUI.Primary
        }


{-| Set the 'selected' state. It not used, the RadioButton is 'undetermined'.
-}
withSelected : Bool -> RadioButton { a | needSelected : () } msg -> RadioButton { a | withSelected : () } msg
withSelected selected (RadioButton props) =
    RadioButton
        { props
            | selected = selected
        }


{-| Change the RadioButton color
-}
withColor : OUI.Color -> RadioButton a msg -> RadioButton a msg
withColor color (RadioButton props) =
    RadioButton
        { props
            | color = color
        }


{-| Set a change handler msg
-}
onChange :
    (Bool -> msg)
    -> RadioButton { a | needOnChangeOrDisabled : () } msg
    -> RadioButton { a | hasAction : () } msg
onChange msg (RadioButton props) =
    RadioButton
        { props
            | onChange = Just msg
        }


{-| disable the RadioButton
-}
disabled :
    RadioButton { a | needOnChangeOrDisabled : () } msg
    -> RadioButton { a | hasAction : () } msg
disabled (RadioButton props) =
    RadioButton props


{-| get the 'selected' value
-}
getSelected : RadioButton c msg -> Bool
getSelected (RadioButton props) =
    props.selected


{-| get the 'onChange' message
-}
getOnChange : RadioButton c msg -> Maybe (Bool -> msg)
getOnChange (RadioButton props) =
    props.onChange


{-| get the color
-}
getColor : RadioButton c msg -> OUI.Color
getColor (RadioButton props) =
    props.color
