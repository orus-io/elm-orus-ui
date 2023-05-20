module OUI.Showcase exposing (addPages)

{-| Provides pages for a OUI.Explorer

@docs addPages

-}

import OUI.Explorer as Explorer exposing (Explorer)
import OUI.Showcase.Buttons as Buttons
import OUI.Showcase.Checkbox as Checkbox
import OUI.Showcase.Colors as Colors
import OUI.Showcase.Typography as Typography
import Spa
import Spa.PageStack


{-| add the default showcase pages to a Explorer
-}
addPages :
    Explorer Explorer.Shared Explorer.SharedMsg current previous currentMsg previousMsg
    ->
        Explorer
            Explorer.Shared
            Explorer.SharedMsg
            ()
            (Spa.PageStack.Model
                Spa.SetupError
                ()
                (Spa.PageStack.Model
                    Spa.SetupError
                    ()
                    (Spa.PageStack.Model
                        Spa.SetupError
                        ()
                        (Spa.PageStack.Model Spa.SetupError current previous)
                    )
                )
            )
            Explorer.BookMsg
            (Spa.PageStack.Msg
                Explorer.Route
                Explorer.BookMsg
                (Spa.PageStack.Msg
                    Explorer.Route
                    Explorer.BookMsg
                    (Spa.PageStack.Msg
                        Explorer.Route
                        Explorer.BookMsg
                        (Spa.PageStack.Msg Explorer.Route currentMsg previousMsg)
                    )
                )
            )
addPages =
    Explorer.category "Styles"
        >> Explorer.addBook Colors.book
        >> Explorer.addBook Typography.book
        >> Explorer.category "Basics"
        >> Explorer.addBook Buttons.book
        >> Explorer.addBook Checkbox.book
