module OUI.MenuButton exposing
    ( Align(..)
    , MenuButton
    , Msg
    , State
    , alignLeft
    , alignRight
    , init
    , new
    , onOutsideClick
    , properties
    , update
    )

import OUI.Button
import OUI.Helpers
import OUI.Menu
import Task


type alias State =
    { id : String
    , opened : Bool
    }


type Msg msg
    = OnClickOutside
    | OnClickButton
    | OnClickItem msg


init : String -> State
init id =
    { id = id
    , opened = False
    }


onOutsideClick : (Msg msg -> msg) -> State -> Sub msg
onOutsideClick map state =
    if state.opened then
        OUI.Helpers.onOutsideClick state.id (map OnClickOutside)

    else
        Sub.none


type Effect msg
    = Loopback msg


update : Msg msg -> State -> ( State, Cmd msg )
update msg state =
    updateWithoutPerform msg state
        |> Tuple.mapSecond (Maybe.map performEffect >> Maybe.withDefault Cmd.none)


updateWithoutPerform : Msg msg -> State -> ( State, Maybe (Effect msg) )
updateWithoutPerform msg state =
    case msg of
        OnClickOutside ->
            ( { state | opened = False }, Nothing )

        OnClickButton ->
            ( { state | opened = not state.opened }, Nothing )

        OnClickItem selectMsg ->
            ( { state | opened = False }, Just <| Loopback selectMsg )


performEffect : Effect msg -> Cmd msg
performEffect (Loopback msg) =
    Task.perform identity <| Task.succeed msg


type Align
    = AlignLeft
    | AlignRight


type MenuButton btnC item msg
    = MenuButton
        { button : OUI.Button.Button { btnC | hasAction : () } msg
        , menu : OUI.Menu.Menu item msg
        , menuAlign : Align
        }


new :
    (Msg msg -> msg)
    -> (item -> msg)
    -> OUI.Button.Button { btnC | needOnClickOrDisabled : () } msg
    -> OUI.Menu.Menu item msg
    -> MenuButton btnC item msg
new map onClick button menu =
    MenuButton
        { button =
            button
                |> OUI.Button.onClick (map OnClickButton)
        , menu =
            menu
                |> OUI.Menu.onClick (map << OnClickItem << onClick)
        , menuAlign = AlignLeft
        }


alignRight : MenuButton btnC item msg -> MenuButton btnC item msg
alignRight (MenuButton props) =
    MenuButton
        { props
            | menuAlign = AlignRight
        }


alignLeft : MenuButton btnC item msg -> MenuButton btnC item msg
alignLeft (MenuButton props) =
    MenuButton
        { props
            | menuAlign = AlignLeft
        }


properties :
    MenuButton btnC item msg
    ->
        { button : OUI.Button.Button { btnC | hasAction : () } msg
        , menu : OUI.Menu.Menu item msg
        , menuAlign : Align
        }
properties (MenuButton props) =
    props
