module ColorThemes exposing
    ( spring
    , autumn
    , summer
    , sky
    )

{-| Implementation of Material 3 color schemes
see <https://material-foundation.github.io/material-theme-builder/>
to see all the added themes


@docs spring, autumn, summer, sky

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


default : OUI.Material.Color.Theme
default =
    OUI.Material.Color.makeTheme "default" "Default material theme" defaultKeyColors


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

spring : OUI.Material.Color.Theme
spring =
    OUI.Material.Color.makeTheme "spring" "Spring colors" springKeyColors



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

autumn : OUI.Material.Color.Theme
autumn =
    OUI.Material.Color.makeTheme "autumn" "Autumn colors" autumnKeyColors


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


summer : OUI.Material.Color.Theme
summer =
    OUI.Material.Color.makeTheme "summer" "Summer colors" summerKeyColors


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


sky : OUI.Material.Color.Theme
sky =
    OUI.Material.Color.makeTheme "sky" "Sky colors" skyKeyColors

