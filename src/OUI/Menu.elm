module OUI.Menu exposing
    ( Menu, Item(..)
    , new, onClick, withIcon, withTrailingIcon
    , addItems, addDivider
    , properties
    )

{-| A general purpose menu


# Types

@docs Menu, Item


# Menu builders

@docs new, onClick, withIcon, withTrailingIcon

@docs addItems, addDivider


# Internals

@docs properties

-}

import OUI.Icon exposing (Icon)
import OUI.Text


{-| A menu
-}
type Menu item msg
    = Menu
        { items : List (Item item)
        , itemToText : item -> String
        , itemToIcon : item -> Maybe Icon
        , itemToTrailingIcon : item -> Maybe Icon
        , itemSelected : item -> Bool
        , onClick : Maybe (item -> msg)
        , textType : OUI.Text.Type
        , textSize : OUI.Text.Size
        }


{-| A menu item
-}
type Item item
    = Item item
    | Divider


{-| Creates a simple text menu
-}
new : (item -> String) -> Menu item msg
new itemToText =
    Menu
        { itemToText = itemToText
        , items = []
        , itemToIcon = \_ -> Nothing
        , itemToTrailingIcon = \_ -> Nothing
        , itemSelected = \_ -> False
        , onClick = Nothing
        , textType = OUI.Text.Label
        , textSize = OUI.Text.Large
        }


{-| Set an event handler for when an item is clicked
-}
onClick : (item -> msg) -> Menu item msg -> Menu item msg
onClick msg (Menu props) =
    Menu
        { props
            | onClick = Just msg
        }


{-| Set the menu items
-}
addItems : List item -> Menu item msg -> Menu item msg
addItems items (Menu props) =
    Menu
        { props
            | items = props.items ++ List.map Item items
        }


{-| Add a divider the menu items
-}
addDivider : Menu item msg -> Menu item msg
addDivider (Menu props) =
    Menu
        { props
            | items = props.items ++ [ Divider ]
        }


{-| Add leading icons to the menu
-}
withIcon : (item -> Maybe Icon) -> Menu item msg -> Menu item msg
withIcon itemToIcon (Menu props) =
    Menu
        { props
            | itemToIcon = itemToIcon
        }


{-| Add trailing icons to the menu
-}
withTrailingIcon : (item -> Maybe Icon) -> Menu item msg -> Menu item msg
withTrailingIcon itemToIcon (Menu props) =
    Menu
        { props
            | itemToTrailingIcon = itemToIcon
        }


{-| properties
-}
properties :
    Menu item msg
    ->
        { items : List (Item item)
        , itemToText : item -> String
        , itemToIcon : item -> Maybe Icon
        , itemToTrailingIcon : item -> Maybe Icon
        , itemSelected : item -> Bool
        , onClick : Maybe (item -> msg)
        , textType : OUI.Text.Type
        , textSize : OUI.Text.Size
        }
properties (Menu props) =
    props
