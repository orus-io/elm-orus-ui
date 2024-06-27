module OUI.Dialog exposing
    ( Dialog, Width(..), new
    , withIcon, withSupportingText, withWidth
    , onDismiss, onAccept
    , getHeadline, getIcon, getSupportingText, getWidth, getAccept, getDismiss
    )

{-| Dialogs provide important prompts in a user flow


# Constructors

@docs Dialog, Width, new

@docs withIcon, withSupportingText, withWidth

@docs onDismiss, onAccept


# Getters

@docs getHeadline, getIcon, getSupportingText, getWidth, getAccept, getDismiss

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


{-| get the icon
-}
getIcon : Dialog msg -> Maybe Icon
getIcon (Dialog dialog) =
    dialog.icon


{-| get the headline
-}
getHeadline : Dialog msg -> String
getHeadline (Dialog dialog) =
    dialog.headline


{-| get the supporting text
-}
getSupportingText : Dialog msg -> Maybe String
getSupportingText (Dialog dialog) =
    dialog.supportingText


{-| get the width
-}
getWidth : Dialog msg -> Width
getWidth (Dialog dialog) =
    dialog.width


{-| get the 'accept' action
-}
getAccept : Dialog msg -> Maybe ( String, msg )
getAccept (Dialog dialog) =
    dialog.accept


{-| get the 'dismiss' action
-}
getDismiss : Dialog msg -> Maybe ( String, msg )
getDismiss (Dialog dialog) =
    dialog.dismiss
