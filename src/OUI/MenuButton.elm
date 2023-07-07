module OUI.MenuButton exposing
    ( MenuButton, Align(..)
    , new, alignLeft, alignRight
    , State, Msg, init, update, onOutsideClick
    , Effect(..), updateWithoutPerform, performEffect
    , properties
    )

{-| A button+menu creation API

The button will open a menu when clicked.

@docs MenuButton, Align


# Constructor

@docs new, alignLeft, alignRight


# State management

Menu + button is a stateful component

@docs State, Msg, init, update, onOutsideClick


## update internals

If you need to change the update effect into something else than Cmd (say, a
[`Effect`](/packages/orus-io/elm-spa/latest/Effect#Effect), here is
everything you need.

@docs Effect, updateWithoutPerform, performEffect


# Internal

@docs properties

-}

import OUI.Button
import OUI.Helpers
import OUI.Menu
import Task


{-| Menu alignment
-}
type Align
    = AlignLeft
    | AlignRight


{-| A Button + Menu component
-}
type MenuButton btnC item msg
    = MenuButton
        { button : OUI.Button.Button { btnC | hasAction : () } msg
        , menu : OUI.Menu.Menu item msg
        , menuAlign : Align
        }


{-| Creates a new button + menu

The button must not have any action defined on it

    MenuButton.new (MenuButtonMsg "menu1")
        OnMenu1Click
        (Button.new "click me"
            |> Button.outlinedButton
        )
        (Menu.new identity
            |> Menu.withItems [ "One", "Two", "Three" ]
            |> Menu.withIcon
                (\i ->
                    if i /= "Two" then
                        Just OUI.Icon.check

                    else
                        Nothing
                )
        )
        |> OUI.Material.menuButton shared.theme model.menu1State []

-}
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


{-| Change the menu alignment to 'right'
-}
alignRight : MenuButton btnC item msg -> MenuButton btnC item msg
alignRight (MenuButton props) =
    MenuButton
        { props
            | menuAlign = AlignRight
        }


{-| Change the menu alignment to 'left' (default)
-}
alignLeft : MenuButton btnC item msg -> MenuButton btnC item msg
alignLeft (MenuButton props) =
    MenuButton
        { props
            | menuAlign = AlignLeft
        }


{-| The component state
-}
type alias State =
    { id : String
    , opened : Bool
    }


{-| The component message
-}
type Msg msg
    = OnClickOutside
    | OnClickButton
    | OnClickItem msg


{-| Initialise the State. The given id must be unique in the currently displayed
components
-}
init : String -> State
init id =
    { id = id
    , opened = False
    }


{-| Update the state given a message
-}
update : Msg msg -> State -> ( State, Cmd msg )
update msg state =
    updateWithoutPerform msg state
        |> Tuple.mapSecond (Maybe.map performEffect >> Maybe.withDefault Cmd.none)


{-| Catch clicks outside an opened menu
-}
onOutsideClick : (Msg msg -> msg) -> State -> Sub msg
onOutsideClick map state =
    if state.opened then
        OUI.Helpers.onOutsideClick state.id (map OnClickOutside)

    else
        Sub.none


{-| Internal update returns Effect instead of Cmd
-}
type Effect msg
    = Loopback msg


{-| Do the update but returns a Effect instead of a Cmd

The Effect can be converted to a Cmd with [performEffect](#performEffect)

-}
updateWithoutPerform : Msg msg -> State -> ( State, Maybe (Effect msg) )
updateWithoutPerform msg state =
    case msg of
        OnClickOutside ->
            ( { state | opened = False }, Nothing )

        OnClickButton ->
            ( { state | opened = not state.opened }, Nothing )

        OnClickItem selectMsg ->
            ( { state | opened = False }, Just <| Loopback selectMsg )


{-| Change a [`Effect`](#Effect) into a [`Cmd`](/packages/elm/core/latest/Platform-Cmd#Cmd)

It simply does:

    performEffect : Effect msg -> Cmd msg
    performEffect (Loopback msg) =
        Task.perform identity <| Task.succeed msg

-}
performEffect : Effect msg -> Cmd msg
performEffect (Loopback msg) =
    Task.perform identity <| Task.succeed msg


{-| -}
properties :
    MenuButton btnC item msg
    ->
        { button : OUI.Button.Button { btnC | hasAction : () } msg
        , menu : OUI.Menu.Menu item msg
        , menuAlign : Align
        }
properties (MenuButton props) =
    props