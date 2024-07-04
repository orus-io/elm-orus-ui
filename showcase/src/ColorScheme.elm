module ColorScheme exposing
    ( defaultKeyColors, defaultLight, defaultDark
    , springKeyColors, springLight, springDark
    )

{-| Implementation of Material 3 color schemes
see <https://material-foundation.github.io/material-theme-builder/>
to see all the added themes


# Default

@docs defaultKeyColors, defaultLight, defaultDark


# Spring

@docs springKeyColors, springLight, springDark

-}

import Color exposing (Color)
import OUI.Material.Color


{-| defaultKeyColors are the default elm-OUI colors from which the
defaultColorScheme is built
-}
defaultKeyColors : OUI.Material.Color.KeyColors
defaultKeyColors =
    { primary =
        OUI.Material.Color.defaultKeyColors.primary

    -- Color.rgb255 50 255 100
    , secondary = OUI.Material.Color.defaultKeyColors.secondary
    , tertiary = OUI.Material.Color.defaultKeyColors.tertiary
    , neutral = OUI.Material.Color.defaultKeyColors.neutral
    , neutralVariant = OUI.Material.Color.defaultKeyColors.neutralVariant
    , error = OUI.Material.Color.defaultKeyColors.error
    }


{-| defaultLight colorscheme
-}
defaultLight : OUI.Material.Color.Scheme
defaultLight =
    let
        light =
            OUI.Material.Color.lightFromKeyColors defaultKeyColors
    in
    light


{-| defaultDark colorScheme
-}
defaultDark : OUI.Material.Color.Scheme
defaultDark =
    let
        dark =
            OUI.Material.Color.darkFromKeyColors defaultKeyColors
    in
    dark


{-| springKeyColors
-}
springKeyColors : OUI.Material.Color.KeyColors
springKeyColors =
    { primary = Color.rgb255 99 160 2
    , secondary = Color.rgb255 133 151 110
    , tertiary = Color.rgb255 77 157 152
    , neutral = Color.rgb255 145 145 139
    , neutralVariant = Color.rgb255 143 146 133
    , error = Color.rgb255 255 84 73
    }


{-| springLight colorScheme
-}
springLight : OUI.Material.Color.Scheme
springLight =
    OUI.Material.Color.lightFromKeyColors springKeyColors


{-| springDark colorScheme
-}
springDark : OUI.Material.Color.Scheme
springDark =
    OUI.Material.Color.darkFromKeyColors springKeyColors
