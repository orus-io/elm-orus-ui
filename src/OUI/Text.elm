module OUI.Text exposing
    ( Type(..), Size(..), Color(..), Text
    , text, withSize, withType
    , onColor, withColor, withCustomColor, withTextColor
    , displayLarge, displayMedium, displaySmall
    , headlineLarge, headlineMedium, headlineSmall
    , titleLarge, titleMedium, titleSmall
    , labelLarge, labelMedium, labelSmall
    , bodyLarge, bodyMedium, bodySmall
    , properties
    )

{-|

@docs Type, Size, Color, Text
@docs text, withSize, withType
@docs onColor, withColor, withCustomColor, withTextColor


# Direct constructors

@docs displayLarge, displayMedium, displaySmall
@docs headlineLarge, headlineMedium, headlineSmall
@docs titleLarge, titleMedium, titleSmall
@docs labelLarge, labelMedium, labelSmall
@docs bodyLarge, bodyMedium, bodySmall


# Internal

@docs properties

-}

import Color
import OUI


{-| Text types
-}
type Type
    = Display
    | Headline
    | Title
    | Label
    | Body


{-| Text sizes
-}
type Size
    = Small
    | Medium
    | Large


{-| Text Color
-}
type Color
    = NoColor
    | Color OUI.Color
    | OnColor OUI.Color
    | Custom Color.Color


{-| A Text component
-}
type Text
    = Text
        { type_ : Type
        , size : Size
        , color : Color
        , text : String
        }


{-| Create a new text component

with default "body" type and "medium" size

-}
text : String -> Text
text s =
    Text
        { type_ = Body
        , size = Medium
        , color = NoColor
        , text = s
        }


{-| set the text type
-}
withType : Type -> Text -> Text
withType value (Text props) =
    Text { props | type_ = value }


{-| set the text size
-}
withSize : Size -> Text -> Text
withSize value (Text props) =
    Text { props | size = value }


{-| Define the text color given the background color.
-}
onColor : OUI.Color -> Text -> Text
onColor value (Text props) =
    Text { props | color = OnColor value }


{-| Set the text color
-}
withColor : OUI.Color -> Text -> Text
withColor value (Text props) =
    Text { props | color = Color value }


{-| Set a custom text
-}
withCustomColor : Color.Color -> Text -> Text
withCustomColor value (Text props) =
    Text { props | color = Custom value }


{-| Set the text color
-}
withTextColor : Color -> Text -> Text
withTextColor value (Text props) =
    Text { props | color = value }


textTypeSize : Type -> Size -> String -> Text
textTypeSize type_ size s =
    text s
        |> withType type_
        |> withSize size


{-| create a display small text
-}
displaySmall : String -> Text
displaySmall =
    textTypeSize Display Small


{-| create a display medium text
-}
displayMedium : String -> Text
displayMedium =
    textTypeSize Display Medium


{-| create a display large text
-}
displayLarge : String -> Text
displayLarge =
    textTypeSize Display Large


{-| create a headline small text
-}
headlineSmall : String -> Text
headlineSmall =
    textTypeSize Headline Small


{-| create a headline medium text
-}
headlineMedium : String -> Text
headlineMedium =
    textTypeSize Headline Medium


{-| create a headline large text
-}
headlineLarge : String -> Text
headlineLarge =
    textTypeSize Headline Large


{-| create a title small text
-}
titleSmall : String -> Text
titleSmall =
    textTypeSize Title Small


{-| create a title medium text
-}
titleMedium : String -> Text
titleMedium =
    textTypeSize Title Medium


{-| create a title large text
-}
titleLarge : String -> Text
titleLarge =
    textTypeSize Title Large


{-| create a label small text
-}
labelSmall : String -> Text
labelSmall =
    textTypeSize Label Small


{-| create a label medium text
-}
labelMedium : String -> Text
labelMedium =
    textTypeSize Label Medium


{-| create a label large text
-}
labelLarge : String -> Text
labelLarge =
    textTypeSize Label Large


{-| create a body small text
-}
bodySmall : String -> Text
bodySmall =
    textTypeSize Body Small


{-| create a body medium text
-}
bodyMedium : String -> Text
bodyMedium =
    textTypeSize Body Medium


{-| create a body large text
-}
bodyLarge : String -> Text
bodyLarge =
    textTypeSize Body Large


{-| -}
properties :
    Text
    ->
        { type_ : Type
        , size : Size
        , color : Color
        , text : String
        }
properties (Text props) =
    props
