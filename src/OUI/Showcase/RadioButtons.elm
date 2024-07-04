module OUI.Showcase.RadioButtons exposing (book)

import Element exposing (Element)
import OUI
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Material as Material
import OUI.RadioButton as RadioButton
import OUI.Text as Text


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Radio Buttons"
        |> Explorer.withStaticChapter radiobutton


onChange : String -> Bool -> Explorer.BookMsg ()
onChange name selected =
    Explorer.logEvent <|
        name
            ++ " changes to "
            ++ (if selected then
                    "'selected'"

                else
                    "'unselected'"
               )


radiobutton : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
radiobutton { theme } =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30 ]
        [ divider
        , Element.row [ Element.spacing 30 ]
            [ Element.column [ Element.spacing 55, Element.padding 30 ]
                [ Element.none |> Element.el []
                , Text.titleSmall "Basic" |> Material.text theme
                , Text.titleSmall "Disabled" |> Material.text theme
                , Text.titleSmall "Error" |> Material.text theme
                ]
            , Element.column [ Element.spacing 30 ]
                [ Text.titleSmall "Unselected" |> Material.text theme
                , RadioButton.new
                    |> RadioButton.onChange (onChange "unselected")
                    |> RadioButton.withSelected False
                    |> Material.radiobutton theme []
                , RadioButton.new
                    |> RadioButton.disabled
                    |> RadioButton.withSelected False
                    |> Material.radiobutton theme []
                , RadioButton.new
                    |> RadioButton.onChange (onChange "unselected error")
                    |> RadioButton.withSelected False
                    |> RadioButton.withColor OUI.Error
                    |> Material.radiobutton theme []
                ]
            , Element.column [ Element.spacing 30 ]
                [ Text.titleSmall "Selected" |> Material.text theme
                , RadioButton.new
                    |> RadioButton.onChange (onChange "selected")
                    |> RadioButton.withSelected True
                    |> Material.radiobutton theme []
                , RadioButton.new
                    |> RadioButton.disabled
                    |> RadioButton.withSelected True
                    |> Material.radiobutton theme []
                , RadioButton.new
                    |> RadioButton.onChange (onChange "selected error")
                    |> RadioButton.withSelected True
                    |> RadioButton.withColor OUI.Error
                    |> Material.radiobutton theme []
                ]
            ]
        ]
