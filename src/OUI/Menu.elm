module OUI.Menu exposing
    ( Menu
    , new
    , onClick
    , properties
    , withIcon
    , withItems
    , withTrailingIcon
    )

{-| A general purpose menu
-}

import OUI.Icon exposing (Icon)
import OUI.Text


type Menu item msg
    = Menu
        { items : List item
        , itemToText : item -> String
        , itemToIcon : item -> Maybe Icon
        , itemToTrailingIcon : item -> Maybe Icon
        , itemSelected : item -> Bool
        , onClick : Maybe (item -> msg)
        , textType : OUI.Text.Type
        , textSize : OUI.Text.Size
        }


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


onClick : (item -> msg) -> Menu item msg -> Menu item msg
onClick msg (Menu props) =
    Menu
        { props
            | onClick = Just msg
        }


withItems : List item -> Menu item msg -> Menu item msg
withItems items (Menu props) =
    Menu
        { props
            | items = items
        }


withIcon : (item -> Maybe Icon) -> Menu item msg -> Menu item msg
withIcon itemToIcon (Menu props) =
    Menu
        { props
            | itemToIcon = itemToIcon
        }


withTrailingIcon : (item -> Maybe Icon) -> Menu item msg -> Menu item msg
withTrailingIcon itemToIcon (Menu props) =
    Menu
        { props
            | itemToTrailingIcon = itemToIcon
        }


properties :
    Menu item msg
    ->
        { items : List item
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
