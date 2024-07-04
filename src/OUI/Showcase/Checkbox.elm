module OUI.Showcase.Checkbox exposing (book)

import Element exposing (Element)
import OUI
import OUI.Checkbox as Checkbox
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Icon exposing (clear)
import OUI.Material as Material
import OUI.Text as Text


book : Explorer.Book themeExt () ()
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


checkbox : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
checkbox { theme } =
    let
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30 ]
        [ divider
        , Element.row [ Element.spacing 30, Element.padding 30 ]
            [ Element.column [ Element.spacing 55, Element.padding 30 ]
                [ Element.none |> Element.el []
                , Text.titleSmall "Basic" |> Material.text theme
                , Text.titleSmall "Disabled" |> Material.text theme
                , Text.titleSmall "Custom Icon" |> Material.text theme
                , Text.titleSmall "Error" |> Material.text theme
                ]
            , Element.column [ Element.spacing 30 ]
                [ Text.titleSmall "Unchecked" |> Material.text theme
                , Checkbox.new
                    |> Checkbox.onChange (onChange "unchecked")
                    |> Checkbox.withChecked False
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.disabled
                    |> Checkbox.withChecked False
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.onChange (onChange "custom icon unchecked")
                    |> Checkbox.withChecked False
                    |> Checkbox.withIcon clear
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.onChange (onChange "unchecked error")
                    |> Checkbox.withChecked False
                    |> Checkbox.withColor OUI.Error
                    |> Material.checkbox theme []
                ]
            , Element.column [ Element.spacing 30 ]
                [ Text.titleSmall "Checked" |> Material.text theme
                , Checkbox.new
                    |> Checkbox.onChange (onChange "checked")
                    |> Checkbox.withChecked True
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.disabled
                    |> Checkbox.withChecked True
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.onChange (onChange "custom icon checked")
                    |> Checkbox.withChecked True
                    |> Checkbox.withIcon clear
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.onChange (onChange "checked error")
                    |> Checkbox.withChecked True
                    |> Checkbox.withColor OUI.Error
                    |> Material.checkbox theme []
                ]
            ]
        ]
