module OUI.TimePicker exposing (Format(..), Mode(..), Msg, State, TimePicker, ampmColor, initState, mainColor, new, updateState)

import OUI


type Mode
    = Input
    | Dial


type Format
    = H12
    | H24


type TimePicker
    = TimePicker
        { mainColor : OUI.Color
        , ampmColor : OUI.Color
        , mode : Mode
        , format : Format
        }


type Msg
    = Noop


type alias State =
    {}


new : TimePicker
new =
    TimePicker
        { mainColor = OUI.Primary
        , ampmColor = OUI.TertiaryContainer
        , mode = Input
        , format = H24
        }


mainColor : TimePicker -> OUI.Color
mainColor (TimePicker props) =
    props.mainColor


ampmColor : TimePicker -> OUI.Color
ampmColor (TimePicker props) =
    props.mainColor


initState : State
initState =
    {}


updateState : Msg -> State -> State
updateState msg state =
    state
