module OUI.Text exposing (..)


type Type
    = Display
    | Headline
    | Title
    | Label
    | Body


type Size
    = Small
    | Medium
    | Large


type Text
    = Text Type Size String


text : String -> Text
text =
    Text Body Medium


withSize : Size -> Text -> Text
withSize value (Text type_ _ s) =
    Text type_ value s


withType : Type -> Text -> Text
withType value (Text _ size s) =
    Text value size s


displaySmall : String -> Text
displaySmall =
    Text Display Small


displayMedium : String -> Text
displayMedium =
    Text Display Medium


displayLarge : String -> Text
displayLarge =
    Text Display Large


headlineSmall : String -> Text
headlineSmall =
    Text Headline Small


headlineMedium : String -> Text
headlineMedium =
    Text Headline Medium


headlineLarge : String -> Text
headlineLarge =
    Text Headline Large


titleSmall : String -> Text
titleSmall =
    Text Title Small


titleMedium : String -> Text
titleMedium =
    Text Title Medium


titleLarge : String -> Text
titleLarge =
    Text Title Large


labelSmall : String -> Text
labelSmall =
    Text Label Small


labelMedium : String -> Text
labelMedium =
    Text Label Medium


labelLarge : String -> Text
labelLarge =
    Text Label Large


bodySmall : String -> Text
bodySmall =
    Text Body Small


bodyMedium : String -> Text
bodyMedium =
    Text Body Medium


bodyLarge : String -> Text
bodyLarge =
    Text Body Large
