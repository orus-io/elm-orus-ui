module Main exposing (..)

import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Showcase as Showcase
import OUI.Showcase.Icons as Icons


main =
    Explorer.explorer
        |> Showcase.addPages
        |> Explorer.addBook
            (Icons.book "icidasset_elm-material-icons"
                [ ( "anchor", OUI.Icon.elmMaterialIcons Color Outlined.anchor )
                , ( "face", OUI.Icon.elmMaterialIcons Color Outlined.face )
                ]
            )
        |> Explorer.finalize
