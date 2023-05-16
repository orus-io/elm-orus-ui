module OUI.ShowCase.Buttons exposing (..)

import Element exposing (Element)
import OUI.Button as Button
import OUI.Explorer as Explorer
import OUI.Material as Material
import OUI.Material.Theme exposing (defaultTheme)


book =
    Explorer.book "Buttons"
        |> Explorer.withStaticChapter commonButtons


commonButtons : Element Explorer.BookMsg
commonButtons =
    Element.column [ Element.spacing 30 ]
        [ Element.row [ Element.spacing 30 ]
            [ Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Elevated"
                    |> Button.withIcon "+"
                    |> Button.onClick (Explorer.event "Clicked Elevated")
                    |> Button.elevatedButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Elevated"
                    |> Button.withIcon "+"
                    |> Button.disabled
                    |> Button.elevatedButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                ]
            , Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Filled"
                    |> Button.withIcon "+"
                    |> Button.onClick (Explorer.event "Clicked Filled")
                    |> Button.filledButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Filled"
                    |> Button.withIcon "+"
                    |> Button.disabled
                    |> Button.filledButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                ]
            , Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Tonal"
                    |> Button.withIcon "+"
                    |> Button.onClick (Explorer.event "Clicked Tonal")
                    |> Button.tonalButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Tonal"
                    |> Button.withIcon "+"
                    |> Button.disabled
                    |> Button.tonalButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                ]
            , Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Outlined"
                    |> Button.withIcon "+"
                    |> Button.onClick (Explorer.event "Clicked Outlined")
                    |> Button.outlinedButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Outlined"
                    |> Button.withIcon "+"
                    |> Button.disabled
                    |> Button.outlinedButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                ]
            , Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Text"
                    |> Button.withIcon "+"
                    |> Button.onClick (Explorer.event "Clicked Text")
                    |> Button.textButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Text"
                    |> Button.withIcon "+"
                    |> Button.disabled
                    |> Button.textButton
                    |> Material.renderButton defaultTheme [ Element.centerX ]
                ]
            ]
        ]
