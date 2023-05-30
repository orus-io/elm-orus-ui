module OUI.MenuButton exposing (MenuButton, new, properties, State, initialState, withState)

import OUI.Button
import OUI.Menu

type alias State = Bool

initialState : State
initialState = 
    False


type MenuButton btnC item msg =
    MenuButton {
        id : String
        , button : OUI.Button.Button {btnC|hasAction: ()} msg
        , menu : OUI.Menu.Menu item msg
        , state : State
    }

new : String -> OUI.Button.Button { btnC | hasAction: () } msg -> OUI.Menu.Menu item msg -> MenuButton btnC item msg
new id button menu =
    MenuButton
        { id = id
        , button = button
        , menu = menu
        , state = initialState
        }


withState : State -> MenuButton btnC item msg -> MenuButton btnC item msg
withState state (MenuButton props) =
    MenuButton
        { props
            | state = state
        }



properties :
    MenuButton btnC item msg
   -> { id : String
      , button : OUI.Button.Button {btnC |hasAction:()} msg
      , menu : OUI.Menu.Menu item msg
      , state : State
      }
properties (MenuButton props) =
    props

