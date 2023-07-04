module OUI.Divider exposing (..)

{-| A divider creation API

@docs Divider

A divider is a thin line that groups content in lists and containers


# Constructor

@docs new


# Basic properties

@docs withThickness, color


# Internal

@docs properties

-}

import OUI exposing (Color(..))


{-| A divider type
-}
type Type
    = FullWidth
    | Inset


{-| underlying properties of the divider
-}
type alias Props =
    { color : Maybe Color
    , type_ : Type
    }


{-| A divider
-}
type Divider
    = Divider Props


{-| Create a divider with the given thickness

By default, the divider has a thickness of 1dp and it's color is TODO idk

-}
new : Divider
new =
    Divider
        { color = Nothing
        , type_ = FullWidth
        }


{-| Set the divider color
-}
color : Color -> Divider -> Divider
color value (Divider props) =
    Divider { props | color = Just value }


{-| Set the divider type
-}
dvdtype : Type -> Divider -> Divider
dvdtype value (Divider props) =
    Divider { props | type_ = value }


{-| Set the divider type to 'Full width' (default)
-}
fullWidthDivider : Divider -> Divider
fullWidthDivider =
    dvdtype FullWidth


{-| Set the divider type to 'inset'
-}
insetDivider : Divider -> Divider
insetDivider =
    dvdtype Inset


{-| -}
properties :
    Divider
    ->
        { color : Maybe Color
        , type_ : Type
        }
properties (Divider props) =
    props
