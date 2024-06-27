module OUI.Navigation exposing
    ( Navigation, new, withSelected
    , rail, modal
    , withFAB, withHeader, withImageHeader
    , addEntry, addEntryWithBadge
    , addSectionHeader, addDivider
    , Mode(..), Entry(..), EntryProperties, getFAB, getHeader, getImageHeader, getSelected, getEntries, getMode, getOnSelect, getOnDismiss, getActiveColor
    )

{-| A Navigation drawer(+rail) component

@docs Navigation, new, withSelected

@docs rail, modal

@docs withFAB, withHeader, withImageHeader


# Adding content

@docs addEntry, addEntryWithBadge
@docs addSectionHeader, addDivider


# Internals

@docs Mode, Entry, EntryProperties, getFAB, getHeader, getImageHeader, getSelected, getEntries, getMode, getOnSelect, getOnDismiss, getActiveColor

-}

import OUI exposing (Color(..))
import OUI.Badge exposing (Badge)
import OUI.Button exposing (Button)
import OUI.Icon exposing (Icon)
import OUI.Image exposing (Image)


{-| Properties of the Entry type
-}
type alias EntryProperties =
    { label : String
    , icon : Icon
    , badge : Maybe Badge
    }


{-| Type of Entry inside the Navigation component.
Settings -> this is a SectionHeader
Video -> this is an Entry
Audio
----- -> this is a Divider
Gameplay
Misc
-}
type Entry key
    = Entry key EntryProperties
    | SectionHeader String
    | Divider


{-| Mode of the Navigation component
-}
type Mode
    = Rail
    | Drawer
    | ModalDrawer


{-| Properties of the Navigation component
-}
type alias Properties btnC key msg =
    { imageHeader : Maybe Image
    , fab : Maybe (Button { btnC | hasAction : (), hasIcon : () } msg)
    , header : Maybe String
    , selected : Maybe key
    , entries : List (Entry key)
    , mode : Mode
    , onSelect : key -> msg
    , onDismiss : Maybe msg
    , activeColor : Color
    }


{-| A Navigation component
-}
type Navigation btnC key msg
    = Navigation (Properties btnC key msg)


{-| create a new empty Navigation drawer
-}
new : (key -> msg) -> Navigation btnC key msg
new onSelect =
    Navigation
        { onSelect = onSelect
        , onDismiss = Nothing
        , imageHeader = Nothing
        , header = Nothing
        , fab = Nothing
        , selected = Nothing
        , entries = []
        , mode = Drawer
        , activeColor = PrimaryContainer
        }


{-| Change the drawer into a rail
-}
rail : Navigation btnC key msg -> Navigation btnC key msg
rail (Navigation props) =
    Navigation { props | mode = Rail }


{-| Change to modal

A modal is a drawer that emit a 'onDismiss' message if the user clicks outside
of it

-}
modal : msg -> Navigation btnC key msg -> Navigation btnC key msg
modal onDismiss (Navigation props) =
    Navigation { props | mode = ModalDrawer, onDismiss = Just onDismiss }


{-| Add a image header on top of the trail/drawer
-}
withImageHeader : Image -> Navigation btnC key msg -> Navigation btnC key msg
withImageHeader image (Navigation props) =
    Navigation { props | imageHeader = Just image }


{-| Add a text header on top of the trail/drawer
-}
withHeader : String -> Navigation btnC key msg -> Navigation btnC key msg
withHeader text (Navigation props) =
    Navigation { props | header = Just text }


{-| Add a FAB button before the entries
-}
withFAB : Button { btnC | hasAction : (), hasIcon : () } msg -> Navigation btnC key msg -> Navigation btnC key msg
withFAB btn (Navigation props) =
    Navigation { props | fab = Just btn }


{-| Set the currently selected entry
-}
withSelected : key -> Navigation btnC key msg -> Navigation btnC key msg
withSelected key (Navigation props) =
    Navigation { props | selected = Just key }


{-| Add a section header
-}
addSectionHeader : String -> Navigation btnC key msg -> Navigation btnC key msg
addSectionHeader label (Navigation props) =
    Navigation
        { props
            | entries = List.append props.entries [ SectionHeader label ]
        }


{-| Add a divider
-}
addDivider : Navigation btnC key msg -> Navigation btnC key msg
addDivider (Navigation props) =
    Navigation
        { props
            | entries = List.append props.entries [ Divider ]
        }


{-| Add a regular entry
-}
addEntry : key -> String -> Icon -> Navigation btnC key msg -> Navigation btnC key msg
addEntry key label icon (Navigation props) =
    Navigation
        { props
            | entries = List.append props.entries [ Entry key { label = label, icon = icon, badge = Nothing } ]
        }


{-| Add an entry with a badge
-}
addEntryWithBadge : key -> String -> Icon -> Badge -> Navigation btnC key msg -> Navigation btnC key msg
addEntryWithBadge key label icon badge (Navigation props) =
    Navigation
        { props
            | entries = List.append props.entries [ Entry key { label = label, icon = icon, badge = Just badge } ]
        }


{-| get the image header
-}
getImageHeader : Navigation btnC key msg -> Maybe Image
getImageHeader (Navigation props) =
    props.imageHeader


{-| get the FAB button
-}
getFAB : Navigation btnC key msg -> Maybe (Button { btnC | hasAction : (), hasIcon : () } msg)
getFAB (Navigation props) =
    props.fab


{-| get the text header
-}
getHeader : Navigation btnC key msg -> Maybe String
getHeader (Navigation props) =
    props.header


{-| get the selected key
-}
getSelected : Navigation btnC key msg -> Maybe key
getSelected (Navigation props) =
    props.selected


{-| get the entries
-}
getEntries : Navigation btnC key msg -> List (Entry key)
getEntries (Navigation props) =
    props.entries


{-| get the mode
-}
getMode : Navigation btnC key msg -> Mode
getMode (Navigation props) =
    props.mode


{-| get the select message
-}
getOnSelect : Navigation btnC key msg -> key -> msg
getOnSelect (Navigation props) =
    props.onSelect


{-| get the dismiss message
-}
getOnDismiss : Navigation btnC key msg -> Maybe msg
getOnDismiss (Navigation props) =
    props.onDismiss


{-| get the active color
-}
getActiveColor : Navigation btnC key msg -> Color
getActiveColor (Navigation props) =
    props.activeColor
