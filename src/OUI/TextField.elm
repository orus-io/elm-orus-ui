module OUI.TextField exposing
    ( TextField, Datatype(..), Type(..), new
    , multiline, search, username, email, password, newPassword
    , withColor, withType, withSupportingText, withFocused, withLeadingIcon, withTrailingIcon, withClickableTrailingIcon, withErrorIcon
    , onFocusBlur
    , getOnChange, getDatatype, getLabel, getSpellcheck, getColor, getErrorIcon, getHasFocus, getLeadingIcon, getOnFocus, getOnLoseFocus, getOnTrailingIconClick, getSupportingText, getTrailingIcon, getType, getValue
    )

{-| A [Text Field](https://m3.material.io/components/text-fields) component

@docs TextField, Datatype, Type, new


# Texfield types

@docs multiline, search, username, email, password, newPassword


# Internal


## Setters

@docs withColor, withType, withSupportingText, withFocused, withLeadingIcon, withTrailingIcon, withClickableTrailingIcon, withErrorIcon
@docs onFocusBlur


## Getters

@docs getOnChange, getDatatype, getLabel, getSpellcheck, getColor, getErrorIcon, getHasFocus, getLeadingIcon, getOnFocus, getOnLoseFocus, getOnTrailingIconClick, getSupportingText, getTrailingIcon, getType, getValue

-}

import OUI
import OUI.Icon exposing (Icon)


{-| Text input can be filled or outlined
-}
type Type
    = Filled
    | Outlined


{-| Data type of the field
-}
type Datatype
    = Text
    | Multiline
    | Email
    | Password Bool
    | NewPassword Bool
    | Username
    | Search


{-| A Text input component
-}
type TextField msg
    = TextField (Properties msg)


{-| Create a new text input
-}
new : String -> (String -> msg) -> String -> TextField msg
new label onChange value =
    TextField
        { onChange = onChange
        , label = label
        , datatype = Text
        , spellcheck = False
        , value = value
        , onFocus = Nothing
        , onLoseFocus = Nothing
        , hasFocus = False
        , supportingText = Nothing
        , color = OUI.Primary
        , type_ = Filled
        , leadingIcon = Nothing
        , trailingIcon = Nothing
        , onTrailingIconClick = Nothing
        , errorIcon = Nothing
        }


{-| change the input main color
-}
withColor : OUI.Color -> TextField msg -> TextField msg
withColor value (TextField props) =
    TextField
        { props
            | color = value
        }


{-| change the input type
-}
withType : Type -> TextField msg -> TextField msg
withType value (TextField props) =
    TextField
        { props
            | type_ = value
        }


{-| set the leading icon
-}
withLeadingIcon : Icon -> TextField msg -> TextField msg
withLeadingIcon value (TextField props) =
    TextField
        { props
            | leadingIcon = Just value
        }


{-| set the trailing icon
-}
withTrailingIcon : Icon -> TextField msg -> TextField msg
withTrailingIcon value (TextField props) =
    TextField
        { props
            | trailingIcon = Just value
        }


{-| add a clickable trailing icon
-}
withClickableTrailingIcon : msg -> Icon -> TextField msg -> TextField msg
withClickableTrailingIcon msg icon (TextField props) =
    TextField
        { props
            | trailingIcon = Just icon
            , onTrailingIconClick = Just msg
        }


{-| set the error icon
-}
withErrorIcon : Icon -> TextField msg -> TextField msg
withErrorIcon value (TextField props) =
    TextField
        { props
            | errorIcon = Just value
        }


{-| add a supporting text below the input
-}
withSupportingText : String -> TextField msg -> TextField msg
withSupportingText value (TextField props) =
    TextField
        { props
            | supportingText = Just value
        }


{-| set the onFocus / onLoseFocus events
-}
onFocusBlur : msg -> msg -> TextField msg -> TextField msg
onFocusBlur onFocus onLoseFocus (TextField props) =
    TextField
        { props
            | onFocus = Just onFocus
            , onLoseFocus = Just onLoseFocus
        }


{-| set the 'focused' current state of the input
-}
withFocused : Bool -> TextField msg -> TextField msg
withFocused hasFocus (TextField props) =
    TextField
        { props
            | hasFocus = hasFocus
        }


{-| Enable multiline input.
-}
multiline : Bool -> TextField msg -> TextField msg
multiline spellcheck (TextField props) =
    TextField
        { props
            | datatype = Multiline
            , spellcheck =
                spellcheck
        }


{-| Change the datatype to 'Search'
-}
search : TextField msg -> TextField msg
search (TextField props) =
    TextField
        { props
            | datatype = Search
        }


{-| Change the datatype to 'Username'
-}
username : TextField msg -> TextField msg
username (TextField props) =
    TextField
        { props
            | datatype = Username
        }


{-| Change the datatype to 'Email'
-}
email : TextField msg -> TextField msg
email (TextField props) =
    TextField
        { props
            | datatype = Email
        }


{-| Change the datatype to 'Password'

If the argument is 'True', the value is showed

-}
password : Bool -> TextField msg -> TextField msg
password show (TextField props) =
    TextField
        { props
            | datatype = Password show
        }


{-| Change the datatype to 'NewPassword'

If the argument is 'True', the value is showed

-}
newPassword : Bool -> TextField msg -> TextField msg
newPassword show (TextField props) =
    TextField
        { props
            | datatype = NewPassword show
        }


{-| Properties of the TextField component
-}
type alias Properties msg =
    { onChange : String -> msg
    , label : String
    , datatype : Datatype
    , spellcheck : Bool
    , value : String
    , onFocus : Maybe msg
    , onLoseFocus : Maybe msg
    , hasFocus : Bool
    , supportingText : Maybe String
    , color : OUI.Color
    , type_ : Type
    , leadingIcon : Maybe Icon
    , trailingIcon : Maybe Icon
    , onTrailingIconClick : Maybe msg
    , errorIcon : Maybe Icon
    }


{-| Get the on change msg
-}
getOnChange : TextField msg -> (String -> msg)
getOnChange (TextField props) =
    props.onChange


{-| Get the label
-}
getLabel : TextField msg -> String
getLabel (TextField props) =
    props.label


{-| Get the datatype
-}
getDatatype : TextField msg -> Datatype
getDatatype (TextField props) =
    props.datatype


{-| Get the spellcheck bool
-}
getSpellcheck : TextField msg -> Bool
getSpellcheck (TextField props) =
    props.spellcheck


{-| Get the value
-}
getValue : TextField msg -> String
getValue (TextField props) =
    props.value


{-| Get the on focus msg
-}
getOnFocus : TextField msg -> Maybe msg
getOnFocus (TextField props) =
    props.onFocus


{-| Get the on lose focus msg
-}
getOnLoseFocus : TextField msg -> Maybe msg
getOnLoseFocus (TextField props) =
    props.onLoseFocus


{-| Get the has-focus bool
-}
getHasFocus : TextField msg -> Bool
getHasFocus (TextField props) =
    props.hasFocus


{-| Get the supporting text
-}
getSupportingText : TextField msg -> Maybe String
getSupportingText (TextField props) =
    props.supportingText


{-| Get the color
-}
getColor : TextField msg -> OUI.Color
getColor (TextField props) =
    props.color


{-| Get the type
-}
getType : TextField msg -> Type
getType (TextField props) =
    props.type_


{-| Get the leading icon
-}
getLeadingIcon : TextField msg -> Maybe Icon
getLeadingIcon (TextField props) =
    props.leadingIcon


{-| Get the trailing icon
-}
getTrailingIcon : TextField msg -> Maybe Icon
getTrailingIcon (TextField props) =
    props.trailingIcon


{-| Get the on-trailing icon click msg
-}
getOnTrailingIconClick : TextField msg -> Maybe msg
getOnTrailingIconClick (TextField props) =
    props.onTrailingIconClick


{-| Get the error icon
-}
getErrorIcon : TextField msg -> Maybe Icon
getErrorIcon (TextField props) =
    props.errorIcon
