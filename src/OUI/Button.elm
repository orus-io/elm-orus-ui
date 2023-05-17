module OUI.Button exposing
    ( Type(..), Button
    , new
    , withText, withIcon, color
    , onClick, disabled
    , elevatedButton, filledButton, tonalButton, outlinedButton, textButton, fab, extendedFAB, iconButton
    , Props, getProperties
    )

{-| A button creation API

@docs Type, Button


# Constructor

@docs new


# Basic properties

@docs withText, withIcon, color


# Actions

@docs onClick, disabled


# Button types

@docs elevatedButton, filledButton, tonalButton, outlinedButton, textButton, fab, extendedFAB, iconButton


# Internal

@docs Props, getProperties

-}

import OUI exposing (Color(..))


{-| A button type
-}
type Type
    = Elevated
    | Filled
    | Tonal
    | Outlined
    | Text
    | FAB
    | ExtendedFAB
    | Icon


{-| underlying properties of the button
-}
type alias Props msg =
    { text : String
    , icon : Maybe String
    , onClick : Maybe msg
    , color : Color
    , type_ : Type
    }


{-| A button
-}
type Button constraints msg
    = Button (Props msg)


{-| Create an empty button

A text and an action (onClick or disabled) must be set before it can be
rendered

By default, the button is of the 'Elevated' type, and its color is 'Primary'

-}
new : Button { needOnClickOrDisabled : (), needText : (), hasNoIcon : () } msg
new =
    Button
        { text = ""
        , icon = Nothing
        , onClick = Nothing
        , color = Primary
        , type_ = Elevated
        }


{-| Set the button primary color
-}
color : Color -> Button a msg -> Button a msg
color value (Button props) =
    Button { props | color = value }


btntype : Type -> Button a msg -> Button a msg
btntype value (Button props) =
    Button { props | type_ = value }


{-| Set the button type to 'Elevated' (default)
-}
elevatedButton : Button a msg -> Button a msg
elevatedButton =
    btntype Elevated


{-| Set the button type to 'Filled'
-}
filledButton : Button a msg -> Button a msg
filledButton =
    btntype Filled


{-| Set the button type to 'Tonal'
-}
tonalButton : Button a msg -> Button a msg
tonalButton =
    color SecondaryContainer
        >> btntype Filled


{-| Set the button type to 'Outlined'
-}
outlinedButton : Button a msg -> Button a msg
outlinedButton =
    btntype Outlined


{-| Set the button type to 'TextButton'
-}
textButton : Button a msg -> Button a msg
textButton =
    btntype Text


{-| Set the button type to 'FAB'
-}
fab : Button { a | hasIcon : () } msg -> Button { a | hasIcon : () } msg
fab =
    btntype FAB


{-| Set the button type to 'ExtendedFAB'
-}
extendedFAB : Button { a | hasIcon : () } msg -> Button { a | hasIcon : () } msg
extendedFAB =
    btntype ExtendedFAB


{-| Set the button type to 'iconButton'
-}
iconButton : Button { a | hasIcon : () } msg -> Button { a | hasIcon : () } msg
iconButton =
    btntype Icon


{-| Set the button text

Can only be called once

-}
withText :
    String
    -> Button { a | needText : () } msg
    -> Button { a | hasText : () } msg
withText value (Button props) =
    Button { props | text = value }


{-| Set the button icon

Can only be called once

-}
withIcon :
    String
    -> Button { a | hasNoIcon : () } msg
    -> Button { a | hasIcon : () } msg
withIcon value (Button props) =
    Button { props | icon = Just value }


{-| Set the button 'onClick' handler

Can only be called once

-}
onClick : msg -> Button { a | needOnClickOrDisabled : () } msg -> Button { a | hasAction : () } msg
onClick msg (Button props) =
    Button { props | onClick = Just msg }


{-| Set the button as 'disabled'

Can only be called once

-}
disabled : Button { props | needOnClickOrDisabled : () } msg -> Button { a | hasAction : () } msg
disabled (Button props) =
    Button props


{-| -}
getProperties :
    Button { constraints | hasText : (), hasAction : () } msg
    ->
        { text : String
        , icon : Maybe String
        , onClick : Maybe msg
        , color : Color
        , type_ : Type
        }
getProperties (Button props) =
    props
