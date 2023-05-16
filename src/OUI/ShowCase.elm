module OUI.ShowCase exposing (addPages, main)

import OUI.Explorer as Explorer
import OUI.ShowCase.Colors as Colors
import OUI.ShowCase.Typography as Typography


addPages =
    Explorer.category "Styles"
        >> Explorer.addBook Colors.book
        >> Explorer.addBook Typography.book


main =
    Explorer.explorer
        |> addPages
        |> Explorer.finalize
