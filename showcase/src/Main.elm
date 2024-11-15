module Main exposing (..)

import Browser
import ColorThemes
import IcidassetMaterialIcons.Outlined as Outlined
import IcidassetMaterialIcons.Regular as Regular
import IcidassetMaterialIcons.Round as Round
import Material.Icons.Types exposing (Coloring(..))
import OUI.Explorer as Explorer
import OUI.Material.Color
import OUI.Material.Theme as Theme exposing (Theme)
import OUI.Material.Typography
import OUI.Showcase as Showcase


intro : String
intro =
    """
Elm Orus UI is a toolkit for building user interfaces. It provides an elegant*
API to create and configure components and a rendering module named 'Material'.

The design is based on [Material Design 3](https://m3.material.io/), and is
fully customizable with a 'Theme' type that holds all the layout key values for
each component, and a colorscheme.

The colorscheme can be generated from a few key colors as specified in
Material design.

This UI Explorer demonstrate all the components provided by Elm Orus UI. It can
also be extended with your own components and themes.

The package is available on [Elm Packages](https://package.elm-lang.org/packages/orus-io/elm-orus-ui/latest/),
but the source code is [available on Github](https://github.com/orus-io/elm-orus-ui).

*This is of course our feeling about it, and we hope you make it yours
"""


get_started : String
get_started =
    """

Add Elm Orus UI to your project:

```
elm install orus-io/elm-orus-ui
```

Have a look at the
[documentation](https://package.elm-lang.org/packages/orus-io/elm-orus-ui/latest/)
for code snippets.
"""


main =
    Explorer.explorer
        |> Explorer.setColorTheme OUI.Material.Color.defaultTheme
        |> Explorer.addColorTheme ColorThemes.spring
        |> Explorer.addColorTheme ColorThemes.autumn
        |> Explorer.addColorTheme ColorThemes.summer
        |> Explorer.addColorTheme ColorThemes.sky
        |> Explorer.setTheme theme
        |> Explorer.addBook
            (Explorer.book "Introduction" |> Explorer.withMarkdownChapter intro)
        |> Explorer.addBook
            (Explorer.book "Get Started"
                |> Explorer.withMarkdownChapter get_started
            )
        |> Showcase.addPages
        |> Explorer.category "Material Icons"
        |> Explorer.addBook Regular.book
        |> Explorer.addBook Outlined.book
        |> Explorer.addBook Round.book
        |> Explorer.finalize
        |> Browser.application


typescale : OUI.Material.Typography.Typescale
typescale =
    let
        base =
            Theme.defaultTypescale

        title =
            base.title

        titleMedium =
            title.medium
    in
    { base
        | title =
            { title
                | medium =
                    { titleMedium
                        | size =
                            --10
                            titleMedium.size
                    }
            }
    }


theme : Theme ()
theme =
    let
        base =
            Theme.defaultTheme

        button =
            Theme.button base

        buttonCommon =
            button.common
    in
    base
        |> Theme.withTypescale typescale
        |> Theme.withButton
            { button
                | common = buttonCommon

                --  | common = { buttonCommon | containerRadius = 8 }
            }
