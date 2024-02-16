module OUI.Badge exposing
    ( Badge(..)
    , small, label, number
    )

{-| A badge creation API


# Types

@docs Badge


# Constructor

@docs small, label, number

-}


{-| A badge is a small red bullet with optional label that typically floats on
the top right a an element, usually an icon
-}
type Badge
    = Small
    | Label String
    | Number Int


{-| A small badge has no label and is smaller than a badge with a label
-}
small : Badge
small =
    Small


{-| Creates a badge with a text label
-}
label : String -> Badge
label =
    Label


{-| Creates a badge with a numeric label
-}
number : Int -> Badge
number =
    Number
