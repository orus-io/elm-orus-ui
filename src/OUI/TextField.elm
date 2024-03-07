module OUI.TextField exposing
    ( TextField, Type(..), new
    , multiline, withColor, withType, withSupportingText, withFocused, withLeadingIcon, withTrailingIcon, withClickableTrailingIcon, withErrorIcon
    , onFocusBlur
    , Properties, properties
    )

{-| A [Text Field](https://m3.material.io/components/text-fields) component

@docs TextField, Type, new
@docs multiline, withColor, withType, withSupportingText, withFocused, withLeadingIcon, withTrailingIcon, withClickableTrailingIcon, withErrorIcon
@docs onFocusBlur
@docs Properties, properties

-}

import Element.Events exposing (onLoseFocus)
import Html.Events exposing (onFocus)
import OUI
import OUI.Icon exposing (Icon)


{-| Text input can be filled or outlined
-}
type Type
    = Filled
    | Outlined


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
        , isMultiline = False
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
            | isMultiline = True
            , spellcheck =
                spellcheck
        }


{-| Properties of the TextField component
-}
type alias Properties msg =
    { onChange : String -> msg
    , label : String
    , isMultiline : Bool
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


{-| Get the TextField properties
-}
properties :
    TextField msg
    -> Properties msg
properties (TextField props) =
    props
