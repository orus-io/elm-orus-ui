module OUI.Showcase.Typography exposing (..)

import Element exposing (Element)
import OUI.Explorer as Explorer
import OUI.Material as Material
import OUI.Text as Text


book =
    Explorer.book "Typography"
        |> Explorer.withMarkdownChapter """
# Typography

The material typescale
    """
        |> Explorer.withStaticChapter
            (\{ theme } ->
                Element.column
                    []
                    [ Text.displayLarge "Display Large" |> Material.renderText theme
                    , Text.displayMedium "Display Medium" |> Material.renderText theme
                    , Text.displaySmall "Display Small" |> Material.renderText theme
                    , Text.headlineLarge "Headline Large" |> Material.renderText theme
                    , Text.headlineMedium "Headline Medium" |> Material.renderText theme
                    , Text.headlineSmall "Headline Small" |> Material.renderText theme
                    , Text.titleLarge "Title Large" |> Material.renderText theme
                    , Text.titleMedium "Title Medium" |> Material.renderText theme
                    , Text.titleSmall "Title Small" |> Material.renderText theme
                    , Text.labelLarge "Label Large" |> Material.renderText theme
                    , Text.labelMedium "Label Medium" |> Material.renderText theme
                    , Text.labelSmall "Label Small" |> Material.renderText theme
                    , Text.bodyLarge "Body Large" |> Material.renderText theme
                    , Text.bodyMedium "Body Medium" |> Material.renderText theme
                    , Text.bodySmall "Body Small" |> Material.renderText theme
                    ]
            )
