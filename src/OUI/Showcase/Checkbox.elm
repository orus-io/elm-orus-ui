module OUI.Showcase.Checkbox exposing (book)

import Element exposing (Element)
import OUI
import OUI.Checkbox as Checkbox
import OUI.Explorer as Explorer
import OUI.Icon exposing (clear)
import OUI.Material as Material


book : Explorer.Book () ()
book =
    Explorer.book "Checkbox"
        |> Explorer.withStaticChapter checkbox


onChange : String -> Bool -> Explorer.BookMsg ()
onChange name checked =
    Explorer.logEvent <|
        name
            ++ " changes to "
            ++ (if checked then
                    "'checked'"

                else
                    "'unchecked'"
               )


checkbox : Explorer.Shared -> Element (Explorer.BookMsg ())
checkbox { theme } =
    Element.column [ Element.spacing 30 ]
        [ Element.text "Checkbox"
        , Element.row [ Element.spacing 30 ]
            [ Checkbox.new
                |> Checkbox.onChange (onChange "unchecked")
                |> Checkbox.withChecked False
                |> Material.checkbox theme []
            , Checkbox.new
                |> Checkbox.onChange (onChange "checked")
                |> Checkbox.withChecked True
                |> Material.checkbox theme []
            , Checkbox.new
                |> Checkbox.disabled
                |> Checkbox.withChecked False
                |> Material.checkbox theme []
            , Checkbox.new
                |> Checkbox.disabled
                |> Checkbox.withChecked True
                |> Material.checkbox theme []
            , Checkbox.new
                |> Checkbox.onChange (onChange "custom icon")
                |> Checkbox.withChecked True
                |> Checkbox.withIcon clear
                |> Material.checkbox theme []
            , Checkbox.new
                |> Checkbox.onChange (onChange "unchecked error")
                |> Checkbox.withChecked False
                |> Checkbox.withColor OUI.Error
                |> Material.checkbox theme []
            , Checkbox.new
                |> Checkbox.onChange (onChange "checked error")
                |> Checkbox.withChecked True
                |> Checkbox.withColor OUI.Error
                |> Material.checkbox theme []
            ]
        ]
