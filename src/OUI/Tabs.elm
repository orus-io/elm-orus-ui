module OUI.Tabs exposing
    ( Type(..), Tabs
    , new, withType, secondary, withIcon, withBadge, withItems, withSelected
    , properties
    )

{-| A tabs component that implement the material specs : <https://m3.material.io/components/tabs/overview>


# Types

@docs Type, Tabs


# Constructors

@docs new, withType, secondary, withIcon, withBadge, withItems, withSelected


# internals

@docs properties

-}

import OUI
import OUI.Badge exposing (Badge)
import OUI.Icon exposing (Icon)


{-| The tabs types
-}
type Type
    = Primary
    | Secondary


type alias Item key item =
    ( key, item )


{-| A tabs component
-}
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


{-| Creates a new Tabs
-}
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


{-| Set the items
-}
withItems : List ( key, item ) -> Tabs key item msg -> Tabs key item msg
withItems items (Tabs tabs) =
    Tabs
        { tabs
            | items = items
        }


{-| Change the tabs type
-}
withType : Type -> Tabs key item msg -> Tabs key item msg
withType value (Tabs tabs) =
    Tabs
        { tabs
            | type_ = value
        }


{-| Change the tabs type to "Secondary"
-}
secondary : Tabs key item msg -> Tabs key item msg
secondary =
    withType Secondary


{-| Add an icon extractor
-}
withIcon : (item -> Maybe Icon) -> Tabs key item msg -> Tabs key item msg
withIcon value (Tabs tabs) =
    Tabs
        { tabs
            | itemToIcon = value
        }


{-| Add a badge extractor
-}
withBadge : (item -> Maybe Badge) -> Tabs key item msg -> Tabs key item msg
withBadge value (Tabs tabs) =
    Tabs
        { tabs
            | itemToBadge = value
        }


{-| Set the selected item
-}
withSelected : key -> Tabs key item msg -> Tabs key item msg
withSelected key (Tabs tabs) =
    Tabs
        { tabs
            | selected = Just key
        }


{-| -}
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
