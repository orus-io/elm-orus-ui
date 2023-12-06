module Main exposing (..)

import Browser
import Color exposing (Color)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Material.Color
import OUI.Material.Theme as Theme exposing (Theme)
import OUI.Material.Typography
import OUI.Showcase as Showcase
import OUI.Showcase.Icons as Icons


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

This UI Explorer is a little crude for now but will get nicer when new components
get implemented.

*This is of course our feeling about it, and we hope you make it yours
"""


get_started : String
get_started =
    """
Elm Orus UI is still in a alpha state, and is not yet released on Elm packages.

To use it, you have to clone the project, and add its 'src' subdirectory into
your own project 'src' list.

"""

main =
    Explorer.explorer
        |> Explorer.setColorScheme lightColorscheme darkColorscheme
        |> Explorer.setTheme theme
        |> Explorer.addBook
            (Explorer.book "Introduction" |> Explorer.withMarkdownChapter intro)
        |> Explorer.addBook
            (Explorer.book "Get Started"
                |> Explorer.withMarkdownChapter get_started
            )
        |> Showcase.addPages
        |> Explorer.addBook
            (Icons.book "Material Icons"
                |> Icons.withChapter "basics"
                    [ ( "anchor", OUI.Icon.elmMaterialIcons Color Outlined.anchor )
                    , ( "face", OUI.Icon.elmMaterialIcons Color Outlined.face )
                    , ( "done_all", OUI.Icon.elmMaterialIcons Color Outlined.done_all )
                    ]
            )
        |> Explorer.finalize
        |> Browser.application


keyColors : OUI.Material.Color.KeyColors
keyColors =
    { primary =
        OUI.Material.Color.defaultKeyColors.primary

    -- Color.rgb255 50 255 100
    , secondary = OUI.Material.Color.defaultKeyColors.secondary
    , tertiary = OUI.Material.Color.defaultKeyColors.tertiary
    , neutral = OUI.Material.Color.defaultKeyColors.neutral
    , neutralVariant = OUI.Material.Color.defaultKeyColors.neutralVariant
    , error = OUI.Material.Color.defaultKeyColors.error
    }


lightColorscheme : OUI.Material.Color.Scheme
lightColorscheme =
    let
        light =
            OUI.Material.Color.lightFromKeyColors keyColors
    in
    light



--{ light | primary = Color.rgb255 130 160 255, onPrimary = Color.rgb255 255 230 210 }


darkColorscheme : OUI.Material.Color.Scheme
darkColorscheme =
    let
        dark =
            OUI.Material.Color.darkFromKeyColors keyColors
    in
    dark


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
