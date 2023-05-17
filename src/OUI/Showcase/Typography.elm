module OUI.Showcase.Typography exposing (..)

import Element exposing (Element)
import OUI.Explorer as Explorer
import OUI.Material as Material
import OUI.Material.Theme exposing (defaultTheme)
import OUI.Text as Text


book =
    Explorer.book "Typography"
        |> Explorer.withMarkdownChapter """
# Typography

The material typescale
    """
        |> Explorer.withStaticChapter
            (Element.column []
                [ Text.displayLarge "Display Large" |> Material.renderText defaultTheme
                , Text.displayMedium "Display Medium" |> Material.renderText defaultTheme
                , Text.displaySmall "Display Small" |> Material.renderText defaultTheme
                , Text.headlineLarge "Headline Large" |> Material.renderText defaultTheme
                , Text.headlineMedium "Headline Medium" |> Material.renderText defaultTheme
                , Text.headlineSmall "Headline Small" |> Material.renderText defaultTheme
                , Text.titleLarge "Title Large" |> Material.renderText defaultTheme
                , Text.titleMedium "Title Medium" |> Material.renderText defaultTheme
                , Text.titleSmall "Title Small" |> Material.renderText defaultTheme
                , Text.labelLarge "Label Large" |> Material.renderText defaultTheme
                , Text.labelMedium "Label Medium" |> Material.renderText defaultTheme
                , Text.labelSmall "Label Small" |> Material.renderText defaultTheme
                , Text.bodyLarge "Body Large" |> Material.renderText defaultTheme
                , Text.bodyMedium "Body Medium" |> Material.renderText defaultTheme
                , Text.bodySmall "Body Small" |> Material.renderText defaultTheme
                ]
            )
