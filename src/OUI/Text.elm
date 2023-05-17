module OUI.Text exposing
    ( Type(..), Size(..), Text(..)
    , text, withSize, withType
    , displayLarge, displayMedium, displaySmall
    , headlineLarge, headlineMedium, headlineSmall
    , titleLarge, titleMedium, titleSmall
    , labelLarge, labelMedium, labelSmall
    , bodyLarge, bodyMedium, bodySmall
    )

{-|

@docs Type, Size, Text
@docs text, withSize, withType


# Direct constructors

@docs displayLarge, displayMedium, displaySmall
@docs headlineLarge, headlineMedium, headlineSmall
@docs titleLarge, titleMedium, titleSmall
@docs labelLarge, labelMedium, labelSmall
@docs bodyLarge, bodyMedium, bodySmall

-}


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


{-| A Text component
-}
type Text
    = Text Type Size String


{-| Create a new text component

with default "body" type and "medium" size

-}
text : String -> Text
text =
    Text Body Medium


{-| set the text size
-}
withSize : Size -> Text -> Text
withSize value (Text type_ _ s) =
    Text type_ value s


{-| set the text type
-}
withType : Type -> Text -> Text
withType value (Text _ size s) =
    Text value size s


{-| create a display small text
-}
displaySmall : String -> Text
displaySmall =
    Text Display Small


{-| create a display medium text
-}
displayMedium : String -> Text
displayMedium =
    Text Display Medium


{-| create a display large text
-}
displayLarge : String -> Text
displayLarge =
    Text Display Large


{-| create a headline small text
-}
headlineSmall : String -> Text
headlineSmall =
    Text Headline Small


{-| create a headline medium text
-}
headlineMedium : String -> Text
headlineMedium =
    Text Headline Medium


{-| create a headline large text
-}
headlineLarge : String -> Text
headlineLarge =
    Text Headline Large


{-| create a title small text
-}
titleSmall : String -> Text
titleSmall =
    Text Title Small


{-| create a title medium text
-}
titleMedium : String -> Text
titleMedium =
    Text Title Medium


{-| create a title large text
-}
titleLarge : String -> Text
titleLarge =
    Text Title Large


{-| create a label small text
-}
labelSmall : String -> Text
labelSmall =
    Text Label Small


{-| create a label medium text
-}
labelMedium : String -> Text
labelMedium =
    Text Label Medium


{-| create a label large text
-}
labelLarge : String -> Text
labelLarge =
    Text Label Large


{-| create a body small text
-}
bodySmall : String -> Text
bodySmall =
    Text Body Small


{-| create a body medium text
-}
bodyMedium : String -> Text
bodyMedium =
    Text Body Medium


{-| create a body large text
-}
bodyLarge : String -> Text
bodyLarge =
    Text Body Large
