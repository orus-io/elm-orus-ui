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


new : Button { needAction : (), needText : (), hasNoIcon : () } msg
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


text :
    String
    -> Button { a | needText : () } msg
    -> Button { a | hasText : () } msg
text value (Button props) =
    Button { props | text = value }


icon :
    String
    -> Button { a | hasNoIcon : () } msg
    -> Button a msg
icon value (Button props) =
    Button { props | icon = Just value }


onClick : msg -> Button { a | needAction : () } msg -> Button a msg
onClick msg (Button props) =
    Button { props | onClick = Just msg }


disabled : Button { props | needAction : () } msg -> Button a msg
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
