module OUI.TextField exposing
    ( TextField, Type(..), new
    , withColor, withType, withSupportingText, withFocused, withLeadingIcon, withTrailingIcon
    , onFocusBlur
    , properties
    )

{-| A [Text Field](https://m3.material.io/components/text-fields) component

@docs TextField, Type, new
@docs withColor, withType, withSupportingText, withFocused, withLeadingIcon, withTrailingIcon
@docs onFocusBlur
@docs properties

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
    = TextField
        { onChange : String -> msg
        , label : String
        , value : String
        , onFocus : Maybe msg
        , onLoseFocus : Maybe msg
        , hasFocus : Bool
        , supportingText : Maybe String
        , color : OUI.Color
        , type_ : Type
        , leadingIcon : Maybe Icon
        , trailingIcon : Maybe Icon
        }


{-| Create a new text input
-}
new : String -> (String -> msg) -> String -> TextField msg
new label onChange value =
    TextField
        { onChange = onChange
        , label = label
        , value = value
        , onFocus = Nothing
        , onLoseFocus = Nothing
        , hasFocus = False
        , supportingText = Nothing
        , color = OUI.Primary
        , type_ = Filled
        , leadingIcon = Nothing
        , trailingIcon = Nothing
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


{-| -}
properties :
    TextField msg
    ->
        { onChange : String -> msg
        , label : String
        , value : String
        , onFocus : Maybe msg
        , onLoseFocus : Maybe msg
        , hasFocus : Bool
        , supportingText : Maybe String
        , color : OUI.Color
        , type_ : Type
        , leadingIcon : Maybe Icon
        , trailingIcon : Maybe Icon
        }
properties (TextField props) =
    props
