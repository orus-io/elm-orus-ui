module OUI.ShowCase exposing (addPages, main)

import OUI.Explorer as Explorer
import OUI.ShowCase.Colors as Colors


addPages =
    Explorer.category "Styles"
        >> Explorer.addBook Colors.book


main =
    Explorer.explorer
        |> addPages
        |> Explorer.finalize
