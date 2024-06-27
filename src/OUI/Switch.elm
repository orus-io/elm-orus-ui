module OUI.Switch exposing
    ( Switch, new
    , withIconSelected, withIconUnselected, withColor, onChange
    , getColor, getIconSelected, getIconUnselected, getOnChange, getSelected
    )

{-| A Switch component

@docs Switch, new

@docs withIconSelected, withIconUnselected, withColor, onChange

@docs getColor, getIconSelected, getIconUnselected, getOnChange, getSelected

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
new : Bool -> Switch msg
new selected =
    Switch
        { selected = selected
        , iconSelected = Nothing
        , iconUnselected = Nothing
        , color = OUI.Primary
        , onChange = Nothing
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


{-| get the selected state
-}
getSelected : Switch msg -> Bool
getSelected (Switch switch) =
    switch.selected


{-| get the icon when selected
-}
getIconSelected : Switch msg -> Maybe Icon
getIconSelected (Switch switch) =
    switch.iconSelected


{-| get the icon when unselected
-}
getIconUnselected : Switch msg -> Maybe Icon
getIconUnselected (Switch switch) =
    switch.iconUnselected


{-| get the color
-}
getColor : Switch msg -> OUI.Color
getColor (Switch switch) =
    switch.color


{-| get the 'on change' message builder
-}
getOnChange : Switch msg -> Maybe (Bool -> msg)
getOnChange (Switch switch) =
    switch.onChange
