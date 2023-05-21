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
            [ Switch.new
                |> Switch.onChange (onChange "unselected")
                |> Switch.withSelected False
                |> Material.renderSwitch theme []
            , Switch.new
                |> Switch.onChange (onChange "selected")
                |> Switch.withSelected True
                |> Material.renderSwitch theme []
            , Switch.new
                |> Switch.withSelected False
                |> Material.renderSwitch theme []
            , Switch.new
                |> Switch.withSelected True
                |> Material.renderSwitch theme []
            , Switch.new
                |> Switch.onChange (onChange "unselected icon")
                |> Switch.withSelected False
                |> Switch.withIconUnselected clear
                |> Material.renderSwitch theme []
            , Switch.new
                |> Switch.onChange (onChange "selected icon")
                |> Switch.withSelected True
                |> Switch.withIconSelected check
                |> Material.renderSwitch theme []
            , Switch.new
                |> Switch.onChange (onChange "unselected error")
                |> Switch.withSelected False
                |> Switch.withColor OUI.Error
                |> Material.renderSwitch theme []
            , Switch.new
                |> Switch.onChange (onChange "selected error")
                |> Switch.withSelected True
                |> Switch.withColor OUI.Error
                |> Material.renderSwitch theme []
            ]
        ]
