module OUI.Showcase.RadioButtons exposing (book)

import Element exposing (Element)
import OUI
import OUI.Explorer as Explorer
import OUI.Icon exposing (clear)
import OUI.Material as Material
import OUI.RadioButton as RadioButton


book : Explorer.Book () ()
book =
    Explorer.book "RadioButton"
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


radiobutton : Explorer.Shared -> Element (Explorer.BookMsg ())
radiobutton { theme } =
    Element.column [ Element.spacing 30 ]
        [ Element.text "RadioButton"
        , Element.row [ Element.spacing 30 ]
            [ RadioButton.new
                |> RadioButton.onChange (onChange "unselected")
                |> RadioButton.withSelected False
                |> Material.radiobutton theme []
            , RadioButton.new
                |> RadioButton.onChange (onChange "selected")
                |> RadioButton.withSelected True
                |> Material.radiobutton theme []
            , RadioButton.new
                |> RadioButton.disabled
                |> RadioButton.withSelected False
                |> Material.radiobutton theme []
            , RadioButton.new
                |> RadioButton.disabled
                |> RadioButton.withSelected True
                |> Material.radiobutton theme []
            , RadioButton.new
                |> RadioButton.onChange (onChange "unselected error")
                |> RadioButton.withSelected False
                |> RadioButton.withColor OUI.Error
                |> Material.radiobutton theme []
            , RadioButton.new
                |> RadioButton.onChange (onChange "selected error")
                |> RadioButton.withSelected True
                |> RadioButton.withColor OUI.Error
                |> Material.radiobutton theme []
            ]
        ]
