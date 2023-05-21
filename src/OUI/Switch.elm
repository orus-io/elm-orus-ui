module OUI.Switch exposing
    ( Switch, new
    , withSelected, withIconSelected, withIconUnselected, withColor, onChange
    , properties
    )

{-| A Switch component

@docs Switch, new

@docs withSelected, withIconSelected, withIconUnselected, withColor, onChange

@docs properties

-}

import OUI
import OUI.Icon exposing (Icon)


{-| A Switch component
-}
type Switch msg
    = Switch
        { selected : Bool
        , iconSelected : Maybe Icon
        , iconUnselected : Maybe Icon
        , color : OUI.Color
        , onChange : Maybe (Bool -> msg)
        }


{-| create a new unselected Switch
-}
new : Switch msg
new =
    Switch
        { selected = False
        , iconSelected = Nothing
        , iconUnselected = Nothing
        , color = OUI.Primary
        , onChange = Nothing
        }


{-| Set the 'selected' state
-}
withSelected : Bool -> Switch msg -> Switch msg
withSelected value (Switch switch) =
    Switch
        { switch
            | selected = value
        }


{-| Set the icon to use when selected
-}
withIconSelected : Icon -> Switch msg -> Switch msg
withIconSelected value (Switch switch) =
    Switch
        { switch
            | iconSelected = Just value
        }


{-| Set the icon to use when unselected
-}
withIconUnselected : Icon -> Switch msg -> Switch msg
withIconUnselected value (Switch switch) =
    Switch
        { switch
            | iconUnselected = Just value
        }


{-| Change the primary color
-}
withColor : OUI.Color -> Switch msg -> Switch msg
withColor value (Switch switch) =
    Switch
        { switch
            | color = value
        }


{-| Set the event handler
-}
onChange : (Bool -> msg) -> Switch msg0 -> Switch msg
onChange msg (Switch switch) =
    Switch
        { selected = switch.selected
        , iconSelected = switch.iconSelected
        , iconUnselected = switch.iconUnselected
        , color = switch.color
        , onChange = Just msg
        }


{-| -}
properties :
    Switch msg
    ->
        { selected : Bool
        , iconSelected : Maybe Icon
        , iconUnselected : Maybe Icon
        , color : OUI.Color
        , onChange : Maybe (Bool -> msg)
        }
properties (Switch switch) =
    switch
