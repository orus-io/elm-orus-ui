module OUI.Divider exposing
    ( Divider(..)
    , new
    )

{-| A divider creation API

A divider is a thin line that groups content in lists and containers

@docs Divider


# Constructor

@docs new

-}

import OUI exposing (Color(..))


{-| A divider
-}
type Divider
    = Divider


{-| Create a divider with the given thickness

By default, the divider has a thickness of 1dp and it's color is outline variant

-}
new : Divider
new =
    Divider
