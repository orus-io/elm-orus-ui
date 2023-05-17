module Main exposing (..)

import OUI.Explorer as Explorer
import OUI.Showcase as Showcase


main =
    Explorer.explorer
        |> Showcase.addPages
        |> Explorer.finalize
