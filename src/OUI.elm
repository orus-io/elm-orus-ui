module OUI exposing (Color(..))

{-|

@docs Color

-}

import Color


{-| Colors
-}
type Color
    = Primary
    | PrimaryContainer
    | Secondary
    | SecondaryContainer
    | Tertiary
    | TertiaryContainer
    | Neutral
    | NeutralVariant
    | Error
    | ErrorContainer
    | Custom
        { color : Color.Color
        , onColor : Color.Color
        , surface : Color.Color
        , onSurface : Color.Color
        }
