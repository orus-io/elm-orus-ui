module OUI.Menu exposing
    ( Menu, Item(..)
    , new, onClick, withIcon, withTrailingIcon
    , addItems, addDivider
    , getItems, getItemToText, getItemToIcon, getItemToTrailingIcon, getItemSelected, getOnClick, getTextType, getTextSize
    )

{-| A general purpose menu


# Types

@docs Menu, Item


# Menu builders

@docs new, onClick, withIcon, withTrailingIcon

@docs addItems, addDivider


# Internals

@docs getItems, getItemToText, getItemToIcon, getItemToTrailingIcon, getItemSelected, getOnClick, getTextType, getTextSize

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


{-| get the items
-}
getItems : Menu item msg -> List (Item item)
getItems (Menu props) =
    props.items


{-| get the item to text function
-}
getItemToText : Menu item msg -> item -> String
getItemToText (Menu props) =
    props.itemToText


{-| get the item to icon function
-}
getItemToIcon : Menu item msg -> item -> Maybe Icon
getItemToIcon (Menu props) =
    props.itemToIcon


{-| get the item to trailing icon function
-}
getItemToTrailingIcon : Menu item msg -> item -> Maybe Icon
getItemToTrailingIcon (Menu props) =
    props.itemToTrailingIcon


{-| get the selected item
-}
getItemSelected : Menu item msg -> item -> Bool
getItemSelected (Menu props) =
    props.itemSelected


{-| get the on click handler
-}
getOnClick : Menu item msg -> Maybe (item -> msg)
getOnClick (Menu props) =
    props.onClick


{-| get the text type
-}
getTextType : Menu item msg -> OUI.Text.Type
getTextType (Menu props) =
    props.textType


{-| get the text size
-}
getTextSize : Menu item msg -> OUI.Text.Size
getTextSize (Menu props) =
    props.textSize
