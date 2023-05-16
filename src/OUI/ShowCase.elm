module OUI.ShowCase exposing (addPages, main)

import OUI.Explorer as Explorer
import OUI.ShowCase.Buttons as Buttons
import OUI.ShowCase.Colors as Colors
import OUI.ShowCase.Typography as Typography


addPages =
    Explorer.category "Styles"
        >> Explorer.addBook Colors.book
        >> Explorer.addBook Typography.book
        >> Explorer.category "Basics"
        >> Explorer.addBook Buttons.book


main =
    Explorer.explorer
        |> addPages
        |> Explorer.finalize
