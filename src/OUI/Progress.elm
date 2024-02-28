module OUI.Progress exposing
    ( Progress, Type(..)
    , circular, linear, withColor, withValue
    , properties
    )

{-| A progress widget


# Types

@docs Progress, Type


# Constructor

@docs circular, linear, withColor, withValue


# Internals

@docs properties

-}

import OUI


{-| A progress widget can be either circular of linear
-}
type Type
    = Circular
    | Linear


{-| The progress
-}
type Progress
    = Progress
        { type_ : Type
        , color : OUI.Color
        , value : Maybe Float
        }


{-| Create a circular progress widget
-}
circular : Progress
circular =
    Progress
        { type_ = Circular
        , color = OUI.Primary
        , value = Nothing
        }


{-| Create a linear progress widget
-}
linear : Progress
linear =
    Progress
        { type_ = Linear
        , color = OUI.Primary
        , value = Nothing
        }


{-| Set the progress primary color
-}
withColor : OUI.Color -> Progress -> Progress
withColor color (Progress progress) =
    Progress
        { progress
            | color = color
        }


{-| Set the progress value
-}
withValue : Float -> Progress -> Progress
withValue value (Progress progress) =
    Progress
        { progress
            | value = Just value
        }


{-| -}
properties :
    Progress
    ->
        { type_ : Type
        , color : OUI.Color
        , value : Maybe Float
        }
properties (Progress progress) =
    progress
