module ColorScheme exposing
    ( defaultKeyColors, defaultLight, defaultDark
    , springKeyColors, springLight, springDark
    , autumnKeyColors, autumnLight, autumnDark
    , summerKeyColors, summerLight, summerDark
    , skyKeyColors, skyLight, skyDark
    )

{-| Implementation of Material 3 color schemes
see <https://material-foundation.github.io/material-theme-builder/>
to see all the added themes


# Default

@docs defaultKeyColors, defaultLight, defaultDark


# Spring

@docs springKeyColors, springLight, springDark


# Autumn

@docs autumnKeyColors, autumnLight, autumnDark


# Summer

@docs summerKeyColors, summerLight, summerDark


# Sky

@docs skyKeyColors, skyLight, skyDark

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


{-| autumnKeyColors
-}
autumnKeyColors : OUI.Material.Color.KeyColors
autumnKeyColors =
    { primary = Color.rgb255 179 59 21
    , secondary = Color.rgb255 184 133 118
    , tertiary = Color.rgb255 165 143 68
    , neutral = Color.rgb255 153 142 140
    , neutralVariant = Color.rgb255 160 140 135
    , error = Color.rgb255 255 84 73
    }


{-| autumnLight colorScheme
-}
autumnLight : OUI.Material.Color.Scheme
autumnLight =
    OUI.Material.Color.lightFromKeyColors autumnKeyColors


{-| autumnDark colorScheme
-}
autumnDark : OUI.Material.Color.Scheme
autumnDark =
    OUI.Material.Color.darkFromKeyColors autumnKeyColors


{-| summerKeyColors
-}
summerKeyColors : OUI.Material.Color.KeyColors
summerKeyColors =
    { primary = Color.rgb255 255 22 63
    , secondary = Color.rgb255 155 145 104
    , tertiary = Color.rgb255 109 155 123
    , neutral = Color.rgb255 148 144 136
    , neutralVariant = Color.rgb255 150 144 128
    , error = Color.rgb255 255 84 73
    }


{-| summerLight colorScheme
-}
summerLight : OUI.Material.Color.Scheme
summerLight =
    OUI.Material.Color.lightFromKeyColors summerKeyColors


{-| summerDark colorScheme
-}
summerDark : OUI.Material.Color.Scheme
summerDark =
    OUI.Material.Color.darkFromKeyColors summerKeyColors


{-| skyKeyColors
-}
skyKeyColors : OUI.Material.Color.KeyColors
skyKeyColors =
    { primary = Color.rgb255 118 156 223
    , secondary = Color.rgb255 137 145 162
    , tertiary = Color.rgb255 162 136 166
    , neutral = Color.rgb255 145 144 147
    , neutralVariant = Color.rgb255 142 144 152
    , error = Color.rgb255 255 84 73
    }


{-| skyLight colorScheme
-}
skyLight : OUI.Material.Color.Scheme
skyLight =
    OUI.Material.Color.lightFromKeyColors skyKeyColors


{-| skyDark colorScheme
-}
skyDark : OUI.Material.Color.Scheme
skyDark =
    OUI.Material.Color.darkFromKeyColors skyKeyColors
