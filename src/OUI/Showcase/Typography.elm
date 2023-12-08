module OUI.Showcase.Typography exposing (book)

import Element
import OUI
import OUI.Explorer as Explorer
import OUI.Material as Material
import OUI.Text as Text


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Typography"
        |> Explorer.withMarkdownChapter """
The material typescale

Type styles include: display, headline, title, body, and label

Each type comes in three sizes: large, medium, small


"""
        |> Explorer.withStaticChapter
            (\{ theme } ->
                [ Text.bodyLarge "Different text pieces can be assembled with Element.paragraph, "
                , Text.bodySmall "here with smaller text, "
                , Text.bodyLarge " or here in color." |> Text.withColor OUI.Primary
                ]
                    |> List.map (Material.text theme)
                    |> Element.paragraph []
            )
        |> Explorer.withStaticChapter
            (\{ theme } ->
                Element.column [ Element.spacing 20 ]
                    [ Element.row [ Element.spacing 20 ]
                        [ Element.column
                            [ Element.spacing 10 ]
                            [ Text.displayLarge "Display Large" |> Material.text theme
                            , Text.displayMedium "Display Medium" |> Material.text theme
                            , Text.displaySmall "Display Small" |> Material.text theme
                            ]
                        , Element.column
                            [ Element.spacing 10 ]
                            [ Text.headlineLarge "Headline Large" |> Material.text theme
                            , Text.headlineMedium "Headline Medium" |> Material.text theme
                            , Text.headlineSmall "Headline Small" |> Material.text theme
                            ]
                        ]
                    , Element.row [ Element.spacing 20 ]
                        [ Element.column
                            [ Element.spacing 10 ]
                            [ Text.titleLarge "Title Large" |> Material.text theme
                            , Text.titleMedium "Title Medium" |> Material.text theme
                            , Text.titleSmall "Title Small" |> Material.text theme
                            ]
                        , Element.column
                            [ Element.spacing 10 ]
                            [ Text.labelLarge "Label Large" |> Material.text theme
                            , Text.labelMedium "Label Medium" |> Material.text theme
                            , Text.labelSmall "Label Small" |> Material.text theme
                            ]
                        , Element.column
                            [ Element.spacing 10 ]
                            [ Text.bodyLarge "Body Large" |> Material.text theme
                            , Text.bodyMedium "Body Medium" |> Material.text theme
                            , Text.bodySmall "Body Small" |> Material.text theme
                            ]
                        ]
                    ]
            )
