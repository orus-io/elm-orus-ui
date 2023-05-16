module OUI.Button exposing (..)

import OUI exposing (Color(..))


type Type
    = Elevated
    | Filled
    | Tonal
    | Outlined
    | Text
    | FAB
    | ExtendedFAB
    | Icon


type alias Props msg =
    { text : String
    , icon : Maybe String
    , onClick : Maybe msg
    , color : Color
    , type_ : Type
    }


type Button constraints msg
    = Button (Props msg)


new : Button { needOnClickOrDisabled : (), needText : (), hasNoIcon : () } msg
new =
    Button
        { text = ""
        , icon = Nothing
        , onClick = Nothing
        , color = Primary
        , type_ = Elevated
        }


color : Color -> Button a msg -> Button a msg
color value (Button props) =
    Button { props | color = value }


btntype : Type -> Button a msg -> Button a msg
btntype value (Button props) =
    Button { props | type_ = value }


elevatedButton : Button a msg -> Button a msg
elevatedButton =
    btntype Elevated


filledButton : Button a msg -> Button a msg
filledButton =
    btntype Filled


tonalButton : Button a msg -> Button a msg
tonalButton =
    color SecondaryContainer
        >> btntype Filled


outlinedButton : Button a msg -> Button a msg
outlinedButton =
    btntype Outlined


textButton : Button a msg -> Button a msg
textButton =
    btntype Text


fab : Button { a | hasIcon : () } msg -> Button { a | hasIcon : () } msg
fab =
    btntype FAB


extendedFAB : Button { a | hasIcon : () } msg -> Button { a | hasIcon : () } msg
extendedFAB =
    btntype ExtendedFAB


iconButton : Button { a | hasIcon : () } msg -> Button { a | hasIcon : () } msg
iconButton =
    btntype Icon


withText :
    String
    -> Button { a | needText : () } msg
    -> Button { a | hasText : () } msg
withText value (Button props) =
    Button { props | text = value }


withIcon :
    String
    -> Button { a | hasNoIcon : () } msg
    -> Button { a | hasIcon : () } msg
withIcon value (Button props) =
    Button { props | icon = Just value }


onClick : msg -> Button { a | needOnClickOrDisabled : () } msg -> Button { a | hasAction : () } msg
onClick msg (Button props) =
    Button { props | onClick = Just msg }


disabled : Button { props | needOnClickOrDisabled : () } msg -> Button { a | hasAction : () } msg
disabled (Button props) =
    Button props


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
