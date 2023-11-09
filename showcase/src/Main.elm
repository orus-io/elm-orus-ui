module Main exposing (..)

import Browser
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Showcase as Showcase
import OUI.Showcase.Icons as Icons


intro : String
intro =
    """
Elm Orus UI is a toolkit for building user interface. It provides an elegant*
API to create and configure components and a rendering module name 'Material'.

The design is based on the Material Design 3, and is fully customizable with
a 'Theme' type that holds all the layout key values for each component, and 
a colorscheme.

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
                    ]
            )
        |> Explorer.finalize
        |> Browser.application
