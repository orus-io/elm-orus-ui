module OUI.Tabs exposing
    ( Tabs
    , Type(..)
    , new
    , properties
    , secondary
    , withBadge
    , withIcon
    , withItems
    , withSelected
    , withType
    )

import OUI
import OUI.Badge exposing (Badge)
import OUI.Icon exposing (Icon)


type Type
    = Primary
    | Secondary


type alias Item key item =
    ( key, item )


type Tabs key item msg
    = Tabs
        { type_ : Type
        , items : List (Item key item)
        , itemToText : item -> String
        , itemToIcon : item -> Maybe Icon
        , itemToBadge : item -> Maybe Badge
        , selected : Maybe key
        , onClick : key -> msg
        , color : OUI.Color
        }


new : (item -> String) -> (key -> msg) -> Tabs key item msg
new itemToText onClick =
    Tabs
        { type_ = Primary
        , items = []
        , itemToText = itemToText
        , itemToIcon = always Nothing
        , itemToBadge = always Nothing
        , selected = Nothing
        , onClick = onClick
        , color = OUI.Primary
        }


withItems : List ( key, item ) -> Tabs key item msg -> Tabs key item msg
withItems items (Tabs tabs) =
    Tabs
        { tabs
            | items = items
        }


withType : Type -> Tabs key item msg -> Tabs key item msg
withType value (Tabs tabs) =
    Tabs
        { tabs
            | type_ = value
        }


secondary : Tabs key item msg -> Tabs key item msg
secondary =
    withType Secondary


withIcon : (item -> Maybe Icon) -> Tabs key item msg -> Tabs key item msg
withIcon value (Tabs tabs) =
    Tabs
        { tabs
            | itemToIcon = value
        }


withBadge : (item -> Maybe Badge) -> Tabs key item msg -> Tabs key item msg
withBadge value (Tabs tabs) =
    Tabs
        { tabs
            | itemToBadge = value
        }


withSelected : key -> Tabs key item msg -> Tabs key item msg
withSelected key (Tabs tabs) =
    Tabs
        { tabs
            | selected = Just key
        }


properties :
    Tabs key item msg
    ->
        { type_ : Type
        , items : List ( key, item )
        , itemToText : item -> String
        , itemToIcon : item -> Maybe Icon
        , itemToBadge : item -> Maybe Badge
        , selected : Maybe key
        , onClick : key -> msg
        , color : OUI.Color
        }
properties (Tabs props) =
    props
