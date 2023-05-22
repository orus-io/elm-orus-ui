module OUI.Showcase.Switch exposing (book)

import Element exposing (Element)
import OUI
import OUI.Explorer as Explorer
import OUI.Icon exposing (check, clear)
import OUI.Material as Material
import OUI.Switch as Switch


book =
    Explorer.book "Switch"
        |> Explorer.withStaticChapter checkbox


onChange : String -> Bool -> Explorer.BookMsg
onChange name selected =
    Explorer.event <|
        name
            ++ " changes to "
            ++ (if selected then
                    "'selected'"

                else
                    "'unselected'"
               )


checkbox : Explorer.Shared -> Element Explorer.BookMsg
checkbox { theme } =
    Element.column [ Element.spacing 30 ]
        [ Element.text "Switch"
        , Element.row [ Element.spacing 30 ]
            [ Switch.new False
                |> Switch.onChange (onChange "unselected")
                |> Material.renderSwitch theme []
            , Switch.new True
                |> Switch.onChange (onChange "selected")
                |> Material.renderSwitch theme []
            , Switch.new False
                |> Material.renderSwitch theme []
            , Switch.new True
                |> Material.renderSwitch theme []
            , Switch.new False
                |> Switch.onChange (onChange "unselected icon")
                |> Switch.withIconUnselected clear
                |> Material.renderSwitch theme []
            , Switch.new True
                |> Switch.onChange (onChange "selected icon")
                |> Switch.withIconSelected check
                |> Material.renderSwitch theme []
            , Switch.new False
                |> Switch.onChange (onChange "unselected error")
                |> Switch.withColor OUI.Error
                |> Material.renderSwitch theme []
            , Switch.new True
                |> Switch.onChange (onChange "selected error")
                |> Switch.withColor OUI.Error
                |> Material.renderSwitch theme []
            ]
        ]
