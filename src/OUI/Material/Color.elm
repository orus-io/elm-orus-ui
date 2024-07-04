module OUI.Material.Color exposing
    ( KeyColors, Scheme
    , defaultKeyColors, defaultLightScheme, defaultDarkScheme, lightFromKeyColors, darkFromKeyColors
    , getColor, getOnColor
    , getElementColor, getOnElementColor, toElementColor
    , getContainerColor, getOnContainerColor
    , getContainerElementColor, getOnContainerElementColor
    , getSurfaceColor, getOnSurfaceColor
    , getSurfaceVariantColor, getOnSurfaceVariantColor
    , getSurfaceContainerLowestColor, getSurfaceContainerLowColor, getSurfaceContainerColor, getSurfaceContainerHighColor, getSurfaceContainerHighestColor
    , hoverStateLayerOpacity, focusStateLayerOpacity, pressStateLayerOpacity
    , setAlpha, withShade, isError, tone
    )

{-| Material 3 color utilities and scheme


# Types

@docs KeyColors, Scheme


# Constructors

@docs defaultKeyColors, defaultLightScheme, defaultDarkScheme, lightFromKeyColors, darkFromKeyColors


# Getters

@docs getColor, getOnColor

@docs getElementColor, getOnElementColor, toElementColor

@docs getContainerColor, getOnContainerColor

@docs getContainerElementColor, getOnContainerElementColor

@docs getSurfaceColor, getOnSurfaceColor

@docs getSurfaceVariantColor, getOnSurfaceVariantColor

@docs getSurfaceContainerLowestColor, getSurfaceContainerLowColor, getSurfaceContainerColor, getSurfaceContainerHighColor, getSurfaceContainerHighestColor

@docs hoverStateLayerOpacity, focusStateLayerOpacity, pressStateLayerOpacity


# Helper functions

@docs setAlpha, withShade, isError, tone

-}

import Color exposing (Color)
import Color.Convert as Convert
import Element
import OUI


{-| A set of colors suitable for generating a color scheme
-}
type alias KeyColors =
    { primary : Color
    , secondary : Color
    , tertiary : Color
    , error : Color
    , neutral : Color
    , neutralVariant : Color
    }


{-| A Material 3 color scheme
-}
type alias Scheme =
    { keyColors : KeyColors
    , primary : Color
    , primaryContainer : Color
    , onPrimary : Color
    , onPrimaryContainer : Color
    , inversePrimary : Color
    , secondary : Color
    , secondaryContainer : Color
    , onSecondary : Color
    , onSecondaryContainer : Color
    , tertiary : Color
    , tertiaryContainer : Color
    , onTertiary : Color
    , onTertiaryContainer : Color
    , surface : Color
    , surfaceDim : Color
    , surfaceBright : Color
    , surfaceContainerLowest : Color
    , surfaceContainerLow : Color
    , surfaceContainer : Color
    , surfaceContainerHigh : Color
    , surfaceContainerHighest : Color
    , surfaceVariant : Color
    , onSurface : Color
    , onSurfaceVariant : Color
    , inverseSurface : Color
    , inverseOnSurface : Color
    , background : Color
    , onBackground : Color
    , error : Color
    , errorContainer : Color
    , onError : Color
    , onErrorContainer : Color
    , outline : Color
    , outlineVariant : Color
    , shadow : Color
    , surfaceTint : Color
    , scrim : Color
    }


{-| The default Material 3 key colors
-}
defaultKeyColors : KeyColors
defaultKeyColors =
    { primary = Color.rgb255 0x67 0x50 0xA4
    , secondary = Color.rgb255 0x62 0x5B 0x71
    , tertiary = Color.rgb255 0x7D 0x52 0x60
    , error = Color.rgb255 0xB3 0x26 0x1E
    , neutral = Color.rgb255 0x40 0x40 0x40
    , neutralVariant = Color.rgb255 0x40 0x40 0x40
    }


{-| The default Material 3 light theme based on the default key colors
-}
defaultLightScheme : Scheme
defaultLightScheme =
    lightFromKeyColors defaultKeyColors


{-| The default Material 3 dark theme based on the default key colors
-}
defaultDarkScheme : Scheme
defaultDarkScheme =
    darkFromKeyColors defaultKeyColors


{-| Create a light color scheme from key colors
-}
lightFromKeyColors : KeyColors -> Scheme
lightFromKeyColors keyColors =
    { keyColors = keyColors
    , primary = tone 40 keyColors.primary
    , primaryContainer = tone 90 keyColors.primary
    , onPrimary = tone 100 keyColors.primary
    , onPrimaryContainer = tone 10 keyColors.primary
    , inversePrimary = tone 80 keyColors.primary
    , secondary = tone 40 keyColors.secondary
    , secondaryContainer = tone 90 keyColors.secondary
    , onSecondary = tone 100 keyColors.secondary
    , onSecondaryContainer = tone 10 keyColors.secondary
    , tertiary = tone 40 keyColors.tertiary
    , tertiaryContainer = tone 90 keyColors.tertiary
    , onTertiary = tone 100 keyColors.tertiary
    , onTertiaryContainer = tone 10 keyColors.tertiary
    , surface = tone 98 keyColors.neutral
    , surfaceDim = tone 87 keyColors.neutral
    , surfaceBright = tone 98 keyColors.neutral
    , surfaceContainerLowest = tone 100 keyColors.neutral
    , surfaceContainerLow = tone 96 keyColors.neutral
    , surfaceContainer = tone 94 keyColors.neutral
    , surfaceContainerHigh = tone 92 keyColors.neutral
    , surfaceContainerHighest = tone 90 keyColors.neutral
    , surfaceVariant = tone 90 keyColors.neutralVariant
    , onSurface = tone 10 keyColors.neutral
    , onSurfaceVariant = tone 30 keyColors.neutralVariant
    , inverseSurface = tone 20 keyColors.neutral
    , inverseOnSurface = tone 95 keyColors.neutral
    , background = tone 98 keyColors.neutral
    , onBackground = tone 10 keyColors.neutral
    , error = tone 40 keyColors.error
    , errorContainer = tone 90 keyColors.error
    , onError = tone 100 keyColors.error
    , onErrorContainer = tone 10 keyColors.error
    , outline = tone 50 keyColors.neutralVariant
    , outlineVariant = tone 80 keyColors.neutralVariant
    , shadow = tone 0 keyColors.neutral |> setAlpha 0.16
    , surfaceTint = keyColors.primary
    , scrim = tone 0 keyColors.neutral
    }


{-| Create a dark color scheme from key colors
-}
darkFromKeyColors : KeyColors -> Scheme
darkFromKeyColors keyColors =
    { keyColors = keyColors
    , primary = tone 80 keyColors.primary
    , primaryContainer = tone 30 keyColors.primary
    , onPrimary = tone 20 keyColors.primary
    , onPrimaryContainer = tone 90 keyColors.primary
    , inversePrimary = tone 40 keyColors.primary
    , secondary = tone 80 keyColors.secondary
    , secondaryContainer = tone 30 keyColors.secondary
    , onSecondary = tone 20 keyColors.secondary
    , onSecondaryContainer = tone 90 keyColors.primary
    , tertiary = tone 80 keyColors.tertiary
    , tertiaryContainer = tone 30 keyColors.tertiary
    , onTertiary = tone 20 keyColors.tertiary
    , onTertiaryContainer = tone 90 keyColors.tertiary
    , surface = tone 6 keyColors.neutral
    , surfaceDim = tone 6 keyColors.neutral
    , surfaceBright = tone 24 keyColors.neutral
    , surfaceContainerLowest = tone 4 keyColors.neutral
    , surfaceContainerLow = tone 10 keyColors.neutral
    , surfaceContainer = tone 12 keyColors.neutral
    , surfaceContainerHigh = tone 18 keyColors.neutral
    , surfaceContainerHighest = tone 22 keyColors.neutral
    , surfaceVariant = tone 30 keyColors.neutralVariant
    , onSurface = tone 90 keyColors.neutral
    , onSurfaceVariant = tone 80 keyColors.neutralVariant
    , inverseSurface = tone 90 keyColors.neutral
    , inverseOnSurface = tone 20 keyColors.neutral
    , background = tone 6 keyColors.neutral
    , onBackground = tone 90 keyColors.neutral
    , error = tone 80 keyColors.error
    , errorContainer = tone 30 keyColors.error
    , onError = tone 20 keyColors.error
    , onErrorContainer = tone 90 keyColors.error
    , outline = tone 60 keyColors.neutralVariant
    , outlineVariant = tone 30 keyColors.neutralVariant
    , shadow = tone 100 keyColors.neutral |> setAlpha 0.16
    , surfaceTint = keyColors.primary
    , scrim = tone 0 keyColors.neutral
    }


{-| returns true if the given color is a error color
-}
isError : OUI.Color -> Bool
isError c =
    case c of
        OUI.Error ->
            True

        OUI.ErrorContainer ->
            True

        _ ->
            False


{-| The "hover" state layer opacity
-}
hoverStateLayerOpacity : Float
hoverStateLayerOpacity =
    0.08


{-| The "focus" state layer opacity
-}
focusStateLayerOpacity : Float
focusStateLayerOpacity =
    0.12


{-| The "press" state layer opacity
-}
pressStateLayerOpacity : Float
pressStateLayerOpacity =
    0.12


{-| Convert a Color to Element.Color
-}
toElementColor : Color -> Element.Color
toElementColor =
    Color.toRgba
        >> Element.fromRgb


{-| Get a color of a scheme directly as a 'Element.Color'
-}
getElementColor : OUI.Color -> Scheme -> Element.Color
getElementColor c =
    getColor c
        >> toElementColor


{-| Get a "on" color of a scheme directly as a 'Element.Color'
-}
getOnElementColor : OUI.Color -> Scheme -> Element.Color
getOnElementColor c =
    getOnColor c
        >> toElementColor


{-| get a "container" color directly as a 'Element.color'
-}
getContainerElementColor : OUI.Color -> Scheme -> Element.Color
getContainerElementColor c =
    getContainerColor c
        >> toElementColor


{-| get a "on container" color directly as a 'Element.color'
-}
getOnContainerElementColor : OUI.Color -> Scheme -> Element.Color
getOnContainerElementColor c =
    getOnContainerColor c
        >> toElementColor


{-| Get a color of a scheme
-}
getColor : OUI.Color -> Scheme -> Color
getColor c =
    case c of
        OUI.Primary ->
            .primary

        OUI.PrimaryContainer ->
            .primaryContainer

        OUI.Secondary ->
            .secondary

        OUI.SecondaryContainer ->
            .secondaryContainer

        OUI.Tertiary ->
            .tertiary

        OUI.TertiaryContainer ->
            .tertiaryContainer

        OUI.Neutral ->
            .onSurface

        OUI.NeutralVariant ->
            .onSurfaceVariant

        OUI.Error ->
            .error

        OUI.ErrorContainer ->
            .errorContainer

        OUI.Custom { color } ->
            always color


{-| Get a "on" color of a scheme
-}
getOnColor : OUI.Color -> Scheme -> Color
getOnColor c =
    case c of
        OUI.Primary ->
            .onPrimary

        OUI.PrimaryContainer ->
            .onPrimaryContainer

        OUI.Secondary ->
            .onSecondary

        OUI.SecondaryContainer ->
            .onSecondaryContainer

        OUI.Tertiary ->
            .onTertiary

        OUI.TertiaryContainer ->
            .onTertiaryContainer

        OUI.Neutral ->
            .surface

        OUI.NeutralVariant ->
            .surface

        OUI.Error ->
            .onError

        OUI.ErrorContainer ->
            .onErrorContainer

        OUI.Custom { onColor } ->
            always onColor


{-| get a container color
-}
getContainerColor : OUI.Color -> Scheme -> Color
getContainerColor c =
    case c of
        OUI.Primary ->
            .primaryContainer

        OUI.PrimaryContainer ->
            .primaryContainer

        OUI.Secondary ->
            .secondaryContainer

        OUI.SecondaryContainer ->
            .secondaryContainer

        OUI.Tertiary ->
            .tertiaryContainer

        OUI.TertiaryContainer ->
            .tertiaryContainer

        OUI.Neutral ->
            .surfaceContainer

        OUI.NeutralVariant ->
            .surfaceContainer

        OUI.Error ->
            .errorContainer

        OUI.ErrorContainer ->
            .errorContainer

        OUI.Custom { color } ->
            always color


{-| get a "on container" color
-}
getOnContainerColor : OUI.Color -> Scheme -> Color
getOnContainerColor c =
    case c of
        OUI.Primary ->
            .onPrimaryContainer

        OUI.PrimaryContainer ->
            .onPrimaryContainer

        OUI.Secondary ->
            .onSecondaryContainer

        OUI.SecondaryContainer ->
            .onSecondaryContainer

        OUI.Tertiary ->
            .onTertiaryContainer

        OUI.TertiaryContainer ->
            .onTertiaryContainer

        OUI.Neutral ->
            .onSurface

        OUI.NeutralVariant ->
            .onSurfaceVariant

        OUI.Error ->
            .onErrorContainer

        OUI.ErrorContainer ->
            .onErrorContainer

        OUI.Custom { onColor } ->
            always onColor


{-| get the "surface" color
-}
getSurfaceColor : OUI.Color -> Scheme -> Color
getSurfaceColor c =
    case c of
        OUI.Custom { surface } ->
            always surface

        _ ->
            .surface


{-| get the "on surface" color
-}
getOnSurfaceColor : OUI.Color -> Scheme -> Color
getOnSurfaceColor c =
    case c of
        OUI.Custom { onSurface } ->
            always onSurface

        _ ->
            .onSurface


{-| get the "surface variant" color
-}
getSurfaceVariantColor : OUI.Color -> Scheme -> Color
getSurfaceVariantColor c =
    case c of
        OUI.Custom { surface } ->
            always surface

        _ ->
            .surfaceVariant


{-| get the "on surface variant" color
-}
getOnSurfaceVariantColor : OUI.Color -> Scheme -> Color
getOnSurfaceVariantColor c =
    case c of
        OUI.Custom { onSurface } ->
            always onSurface

        _ ->
            .onSurfaceVariant


{-| get the "surface container lowest" color
-}
getSurfaceContainerLowestColor : OUI.Color -> Scheme -> Color
getSurfaceContainerLowestColor c =
    case c of
        OUI.Custom { surface } ->
            always surface

        _ ->
            .surfaceContainerLowest


{-| get the "surface container low" color
-}
getSurfaceContainerLowColor : OUI.Color -> Scheme -> Color
getSurfaceContainerLowColor c =
    case c of
        OUI.Custom { surface } ->
            always surface

        _ ->
            .surfaceContainerLow


{-| get the "surface container" color
-}
getSurfaceContainerColor : OUI.Color -> Scheme -> Color
getSurfaceContainerColor c =
    case c of
        OUI.Custom { surface } ->
            always surface

        _ ->
            .surfaceContainer


{-| get the "surface container high" color
-}
getSurfaceContainerHighColor : OUI.Color -> Scheme -> Color
getSurfaceContainerHighColor c =
    case c of
        OUI.Custom { surface } ->
            always surface

        _ ->
            .surfaceContainerHigh


{-| get the "surface container highest" color
-}
getSurfaceContainerHighestColor : OUI.Color -> Scheme -> Color
getSurfaceContainerHighestColor c =
    case c of
        OUI.Custom { surface } ->
            always surface

        _ ->
            .surfaceContainerHighest


{-| set the opacity of a color
-}
setAlpha : Float -> Color -> Color
setAlpha value color =
    let
        rgba : { red : Float, green : Float, blue : Float, alpha : Float }
        rgba =
            Color.toRgba color
    in
    Color.fromRgba
        { rgba
            | alpha = value
        }


{-| Utility function to convert a color to CIELCH color space
-}
toCIELCH : Color -> { l : Float, c : Float, h : Float }
toCIELCH =
    Convert.colorToLab
        >> (\{ l, a, b } ->
                { l = l
                , c = sqrt (a * a + b * b)
                , h = atan2 b a
                }
           )


{-| Utility function to convert CIELCH color space back to a color
-}
fromCIELCH : { l : Float, c : Float, h : Float } -> Color
fromCIELCH =
    (\{ l, c, h } ->
        { l = l
        , a = c * cos h
        , b = c * sin h
        }
    )
        >> Convert.labToColor


{-| Simulates adding a color in front (subtractive color mixing).

    --Darkens the color by 50%
    withShade (Color.rgb255 255 255 255) 0.5

    --Makes the color 50% more red
    withShade (Color.rgb255 255 0 0) 0.5

-}
withShade : Color -> Float -> Color -> Color
withShade c2 amount c1 =
    let
        alpha : Float
        alpha =
            c1
                |> Color.toRgba
                |> .alpha

        fun :
            { l : Float, c : Float, h : Float }
            -> { l : Float, c : Float, h : Float }
            -> { l : Float, c : Float, h : Float }
        fun a b =
            { l = a.l * (1 - amount) + b.l * amount
            , c = a.c * (1 - amount) + b.c * amount
            , h = a.h * (1 - amount) + b.h * amount
            }
    in
    fun (toCIELCH c1) (toCIELCH c2)
        |> fromCIELCH
        |> Color.toRgba
        |> (\color -> { color | alpha = alpha })
        |> Color.fromRgba


{-| Change the tone of a color

See <https://m3.material.io/styles/color/the-color-system/key-colors-tones>

-}
tone : Int -> Color -> Color
tone light color =
    let
        hsla : { hue : Float, saturation : Float, lightness : Float, alpha : Float }
        hsla =
            Color.toHsla color

        fLight : Float
        fLight =
            if light <= 0 then
                0.0

            else if light >= 100 then
                1.0

            else
                toFloat light / 100
    in
    Color.fromHsla
        { hsla
            | lightness = fLight
        }
