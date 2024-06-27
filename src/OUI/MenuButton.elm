module OUI.MenuButton exposing
    ( MenuButton, Align(..), Key(..)
    , new, alignLeft, alignRight, withOpenCloseIcons
    , State, Msg, init, update, onOutsideClick
    , Effect(..), updateWithoutPerform, performEffect
    , getButton, getMenu, getMenuAlign, getOnKeyDown, getOnLoseFocus, getOpenCloseIcons
    )

{-| A button+menu creation API

The button will open a menu when clicked.

@docs MenuButton, Align, Key


# Constructor

@docs new, alignLeft, alignRight, withOpenCloseIcons


# State management

Menu + button is a stateful component

@docs State, Msg, init, update, onOutsideClick


## update internals

If you need to change the update effect into something else than Cmd (say, a
[`Effect`](https://package.elm-lang.org/packages/orus-io/elm-spa/latest/Effect#Effect), here is
everything you need.

@docs Effect, updateWithoutPerform, performEffect


# Internal

@docs getButton, getMenu, getMenuAlign, getOnKeyDown, getOnLoseFocus, getOpenCloseIcons

-}

import OUI.Button
import OUI.Helpers
import OUI.Icon exposing (Icon)
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
        , onKeyDown : Key -> msg
        , onLoseFocus : msg
        , openCloseIcons : Maybe ( Icon, Icon )
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
    (Msg item msg -> msg)
    -> (item -> msg)
    -> OUI.Button.Button { btnC | needOnClickOrDisabled : () } msg
    -> OUI.Menu.Menu item msg
    -> MenuButton btnC item msg
new map onClick button menu =
    let
        menuitems : List (OUI.Menu.Item item)
        menuitems =
            OUI.Menu.getItems menu
    in
    MenuButton
        { button =
            button
                |> OUI.Button.onClick (map OnClickButton)
        , menu =
            menu
                |> OUI.Menu.onClick (map << OnClickItem << onClick)
        , menuAlign = AlignLeft
        , onKeyDown = OnKeyDown onClick menuitems >> map
        , onLoseFocus = map OnBlur
        , openCloseIcons = Nothing
        }


{-| withOpenCloseIcons
-}
withOpenCloseIcons : Icon -> Icon -> MenuButton btnC item msg -> MenuButton btnC item msg
withOpenCloseIcons open close (MenuButton props) =
    MenuButton
        { props
            | openCloseIcons = Just ( open, close )
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
    , highlighted : Int
    }


{-| Keys
-}
type Key
    = ArrowDown
    | ArrowUp
    | Enter
    | Esc


{-| The component message
-}
type Msg item msg
    = OnClickOutside
    | OnClickButton
    | OnClickItem msg
    | OnKeyDown (item -> msg) (List (OUI.Menu.Item item)) Key
    | OnBlur


{-| Initialise the State. The given id must be unique in the currently displayed
components
-}
init : String -> State
init id =
    { id = id
    , opened = False
    , highlighted = -1
    }


{-| Update the state given a message
-}
update : Msg item msg -> State -> ( State, Cmd msg )
update msg state =
    updateWithoutPerform msg state
        |> Tuple.mapSecond (Maybe.map performEffect >> Maybe.withDefault Cmd.none)


{-| Catch clicks outside an opened menu
-}
onOutsideClick : (Msg item msg -> msg) -> State -> Sub msg
onOutsideClick map state =
    if state.opened then
        OUI.Helpers.onOutsideClick state.id (map OnClickOutside)

    else
        Sub.none


{-| Internal update returns Effect instead of Cmd
-}
type Effect msg
    = Loopback msg


hasItems : List (OUI.Menu.Item item) -> Bool
hasItems =
    List.foldl
        (\item r ->
            case item of
                OUI.Menu.Item _ ->
                    True

                OUI.Menu.Divider ->
                    r
        )
        False


prevIndex : List (OUI.Menu.Item item) -> Int -> Int
prevIndex items index =
    if hasItems items then
        let
            newIndex : Int
            newIndex =
                if index <= 0 then
                    List.length items - 1

                else
                    index - 1

            item : Maybe (OUI.Menu.Item item)
            item =
                List.drop newIndex items
                    |> List.head
        in
        if item == Just OUI.Menu.Divider then
            prevIndex items newIndex

        else
            newIndex

    else
        -1


nextIndex : List (OUI.Menu.Item item) -> Int -> Int
nextIndex items index =
    if hasItems items then
        let
            newIndex : Int
            newIndex =
                if index >= List.length items - 1 then
                    0

                else
                    index + 1

            item : Maybe (OUI.Menu.Item item)
            item =
                List.drop newIndex items
                    |> List.head
        in
        if item == Just OUI.Menu.Divider then
            nextIndex items newIndex

        else
            newIndex

    else
        -1


getAtIndex : Int -> List (OUI.Menu.Item item) -> Maybe item
getAtIndex index =
    List.drop index
        >> List.head
        >> Maybe.andThen
            (\menuitem ->
                case menuitem of
                    OUI.Menu.Item item ->
                        Just item

                    OUI.Menu.Divider ->
                        Nothing
            )


{-| Do the update but returns a Effect instead of a Cmd

The Effect can be converted to a Cmd with [performEffect](#performEffect)

-}
updateWithoutPerform : Msg item msg -> State -> ( State, Maybe (Effect msg) )
updateWithoutPerform msg state =
    case msg of
        OnClickOutside ->
            ( { state
                | opened = False
                , highlighted = -1
              }
            , Nothing
            )

        OnClickButton ->
            ( { state | opened = not state.opened }, Nothing )

        OnClickItem selectMsg ->
            ( { state
                | opened = False
                , highlighted = -1
              }
            , Just <| Loopback selectMsg
            )

        OnBlur ->
            ( { state
                | opened = False
                , highlighted = -1
              }
            , Nothing
            )

        OnKeyDown _ items ArrowUp ->
            ( { state
                | highlighted =
                    prevIndex items state.highlighted
              }
            , Nothing
            )

        OnKeyDown _ items ArrowDown ->
            ( { state
                | opened = True
                , highlighted =
                    nextIndex items state.highlighted
              }
            , Nothing
            )

        OnKeyDown onClick items Enter ->
            ( { state
                | opened = False
                , highlighted = -1
              }
            , items
                |> getAtIndex state.highlighted
                |> Maybe.map (onClick >> Loopback)
            )

        OnKeyDown _ _ Esc ->
            ( { state
                | opened = False
                , highlighted = -1
              }
            , Nothing
            )


{-| Change a [`Effect`](#Effect) into a [`Cmd`](https://package.elm-lang.org/packages/elm/core/latest/Platform-Cmd#Cmd)

It simply does:

    performEffect : Effect msg -> Cmd msg
    performEffect (Loopback msg) =
        Task.perform identity <| Task.succeed msg

-}
performEffect : Effect msg -> Cmd msg
performEffect (Loopback msg) =
    Task.perform identity <| Task.succeed msg


{-| get the button
-}
getButton : MenuButton btnC item msg -> OUI.Button.Button { btnC | hasAction : () } msg
getButton (MenuButton props) =
    props.button


{-| get the menu
-}
getMenu : MenuButton btnC item msg -> OUI.Menu.Menu item msg
getMenu (MenuButton props) =
    props.menu


{-| get the menu alignment
-}
getMenuAlign : MenuButton btnC item msg -> Align
getMenuAlign (MenuButton props) =
    props.menuAlign


{-| get the keydown message
-}
getOnKeyDown : MenuButton btnC item msg -> Key -> msg
getOnKeyDown (MenuButton props) =
    props.onKeyDown


{-| get the lose focus message
-}
getOnLoseFocus : MenuButton btnC item msg -> msg
getOnLoseFocus (MenuButton props) =
    props.onLoseFocus


{-| get the open/close icons
-}
getOpenCloseIcons : MenuButton btnC item msg -> Maybe ( Icon, Icon )
getOpenCloseIcons (MenuButton props) =
    props.openCloseIcons
