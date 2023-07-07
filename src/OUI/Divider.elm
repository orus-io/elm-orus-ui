module OUI.Divider exposing
    ( Divider(..), Type(..)
    , new
    , fullWidthDivider, insetDivider
    , properties, Props, dvdtype
    )

{-| A divider creation API

@docs Divider, Type

A divider is a thin line that groups content in lists and containers


# Constructor

@docs new


# Divider Type

@docs fullWidthDivider, insetDivider


# Internal

@docs properties, Props, dvdtype

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
    { type_ : Type }


{-| A divider
-}
type Divider
    = Divider Props


{-| Create a divider with the given thickness

By default, the divider has a thickness of 1dp and it's color is outline variant

-}
new : Divider
new =
    Divider
        { type_ = FullWidth }


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
    -> { type_ : Type }
properties (Divider props) =
    props
