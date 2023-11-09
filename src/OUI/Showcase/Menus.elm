module OUI.Showcase.Menus exposing (book, chapter)

import Element exposing (Element)
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Material
import OUI.Menu as Menu


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Menu"
        |> Explorer.withChapter chapter


chapter : Explorer.Shared themeExt -> () -> Element (Explorer.BookMsg msg)
chapter shared _ =
    Element.wrappedRow [ Element.spacing 50 ]
        [ Menu.new identity
            |> Menu.addItems [ "one", "two", "three" ]
            |> Menu.onClick (\i -> Explorer.logEvent <| "clicked menu1/" ++ i)
            |> OUI.Material.menu shared.theme []
        , Menu.new identity
            |> Menu.onClick (\i -> Explorer.logEvent <| "clicked menu2/" ++ i)
            |> Menu.withIcon
                (\i ->
                    if i == "two" then
                        Just OUI.Icon.clear

                    else
                        Nothing
                )
            |> Menu.withTrailingIcon
                (\i ->
                    if i == "one" then
                        Just OUI.Icon.check

                    else
                        Nothing
                )
            |> Menu.addItems [ "one", "two", "three" ]
            |> Menu.addDivider
            |> Menu.addItems [ "a longer entry" ]
            |> OUI.Material.menu shared.theme []
        ]
