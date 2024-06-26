module OUI.Dialog exposing
    ( Dialog, Width(..), new
    , withIcon, withSupportingText, withWidth
    , onDismiss, onAccept
    , headline, icon, supportingText, width, accept, dismiss
    )

{-| Dialogs provide important prompts in a user flow


# Constructors

@docs Dialog, Width, new

@docs withIcon, withSupportingText, withWidth

@docs onDismiss, onAccept


# Getters

@docs headline, icon, supportingText, width, accept, dismiss

-}

import OUI.Icon exposing (Icon)


{-| Dialog width
-}
type Width
    = Small
    | Medium
    | Large
    | AutoWidth
    | Fullscreen


{-| A dialog
-}
type Dialog msg
    = Dialog
        { headline : String
        , icon : Maybe Icon
        , supportingText : Maybe String
        , accept : Maybe ( String, msg )
        , dismiss : Maybe ( String, msg )
        , width : Width
        }


{-| Creates a new dialog with a single headline and a dismiss action
-}
new : String -> Dialog msg
new headlineText =
    Dialog
        { headline = headlineText
        , icon = Nothing
        , supportingText = Nothing
        , accept = Nothing
        , dismiss = Nothing
        , width = Small
        }


{-| set a width
-}
withWidth : Width -> Dialog msg -> Dialog msg
withWidth value (Dialog dialog) =
    Dialog
        { dialog
            | width = value
        }


{-| add a hero icon
-}
withIcon : Icon -> Dialog msg -> Dialog msg
withIcon newIcon (Dialog dialog) =
    Dialog
        { dialog
            | icon = Just newIcon
        }


{-| add a supporting text
-}
withSupportingText : String -> Dialog msg -> Dialog msg
withSupportingText text (Dialog dialog) =
    Dialog
        { dialog
            | supportingText = Just text
        }


{-| add a 'accept' action
-}
onAccept : String -> msg -> Dialog msg -> Dialog msg
onAccept label msg (Dialog dialog) =
    Dialog
        { dialog
            | accept = Just ( label, msg )
        }


{-| add a 'dismiss' action
-}
onDismiss : String -> msg -> Dialog msg -> Dialog msg
onDismiss label msg (Dialog dialog) =
    Dialog
        { dialog
            | dismiss = Just ( label, msg )
        }


{-| -}
icon : Dialog msg -> Maybe Icon
icon (Dialog dialog) =
    dialog.icon


{-| -}
headline : Dialog msg -> String
headline (Dialog dialog) =
    dialog.headline


{-| -}
supportingText : Dialog msg -> Maybe String
supportingText (Dialog dialog) =
    dialog.supportingText


{-| -}
width : Dialog msg -> Width
width (Dialog dialog) =
    dialog.width


{-| -}
accept : Dialog msg -> Maybe ( String, msg )
accept (Dialog dialog) =
    dialog.accept


{-| -}
dismiss : Dialog msg -> Maybe ( String, msg )
dismiss (Dialog dialog) =
    dialog.dismiss
