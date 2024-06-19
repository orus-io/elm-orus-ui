module OUI.Dialog exposing
    ( Dialog, new
    , withIcon, withSupportingText
    , onDismiss, onAccept
    , headline, icon, supportingText, accept, dismiss
    )

{-| Dialogs provide important prompts in a user flow


# Constructors

@docs Dialog, new

@docs withIcon, withSupportingText

@docs onDismiss, onAccept


# Getters

@docs headline, icon, supportingText, accept, dismiss

-}

import OUI.Icon exposing (Icon)


{-| A dialog
-}
type Dialog msg
    = Dialog
        { headline : String
        , icon : Maybe Icon
        , supportingText : Maybe String
        , accept : Maybe ( String, msg )
        , dismiss : Maybe ( String, msg )
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
accept : Dialog msg -> Maybe ( String, msg )
accept (Dialog dialog) =
    dialog.accept


{-| -}
dismiss : Dialog msg -> Maybe ( String, msg )
dismiss (Dialog dialog) =
    dialog.dismiss
