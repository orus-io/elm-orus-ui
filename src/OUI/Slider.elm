module OUI.Slider exposing
    ( Slider, new
    , onChange, withColor, withDiscreteStep, withMinMax, withStep
    , getColor, getMinMax, getOnChange, getStep, getValue
    )

{-|


# Constructor

@docs Slider, new


# Setters

@docs onChange, withColor, withDiscreteStep, withMinMax, withStep


# Getters

@docs getColor, getMinMax, getOnChange, getStep, getValue

-}

import OUI


{-| A slider
-}
type Slider msg
    = Slider
        { onChange : Maybe (Float -> msg)
        , min : Float
        , max : Float
        , step : Maybe ( Float, Bool )
        , value : Float
        , color : OUI.Color
        }


{-| Creates a slider

A slider must have a value

-}
new : Float -> Slider msg
new value =
    Slider
        { onChange = Nothing
        , min = 0
        , max = 100
        , step = Nothing
        , value = value
        , color = OUI.Primary
        }


{-| Set a change handler

If not set, the slider is read-only

-}
onChange : (Float -> msg) -> Slider msg -> Slider msg
onChange value (Slider slider) =
    Slider { slider | onChange = Just value }


{-| Change the main color of the slider

The default color is "Primary"

-}
withColor : OUI.Color -> Slider msg -> Slider msg
withColor value (Slider slider) =
    Slider
        { slider
            | color = value
        }


{-| Set limits

The default limits are 0 and 100

-}
withMinMax : Float -> Float -> Slider msg -> Slider msg
withMinMax minValue maxValue (Slider slider) =
    Slider
        { slider
            | min = min minValue maxValue
            , max = max minValue maxValue
        }


{-| Set a step

Steps limits the possible values but will not change the slider appearence

See also (#withDiscreteStep)

-}
withStep : Float -> Slider msg -> Slider msg
withStep value (Slider slider) =
    Slider { slider | step = Just ( value, False ) }


{-| Enable "discrete" mode

Steps limits the possible values. A dot is visible at each possible values

-}
withDiscreteStep : Float -> Slider msg -> Slider msg
withDiscreteStep value (Slider slider) =
    Slider { slider | step = Just ( value, True ) }


{-| return the slider color
-}
getColor : Slider msg -> OUI.Color
getColor (Slider slider) =
    slider.color


{-| return the slider min/max
-}
getMinMax : Slider msg -> ( Float, Float )
getMinMax (Slider slider) =
    ( slider.min, slider.max )


{-| return the slider onChange handler
-}
getOnChange : Slider msg -> Maybe (Float -> msg)
getOnChange (Slider slider) =
    slider.onChange


{-| return the slider step
-}
getStep : Slider msg -> Maybe ( Float, Bool )
getStep (Slider slider) =
    slider.step


{-| return the slider value
-}
getValue : Slider msg -> Float
getValue (Slider slider) =
    slider.value
