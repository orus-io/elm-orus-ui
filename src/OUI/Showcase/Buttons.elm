module OUI.Showcase.Buttons exposing (..)

import Element exposing (Element)
import OUI
import OUI.Button as Button
import OUI.Explorer as Explorer
import OUI.Icon exposing (clear)
import OUI.Material as Material


book =
    Explorer.book "Buttons"
        |> Explorer.withStaticChapter commonButtons


commonButtons : Explorer.Shared -> Element (Explorer.BookMsg ())
commonButtons { theme } =
    Element.column [ Element.spacing 30 ]
        [ Element.text "Common buttons"
        , Element.row [ Element.spacing 30 ]
            [ Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Elevated"
                    |> Button.withIcon clear
                    |> Button.onClick (Explorer.logEvent "Clicked Elevated")
                    |> Button.elevatedButton
                    |> Material.button theme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Elevated"
                    |> Button.withIcon clear
                    |> Button.disabled
                    |> Button.elevatedButton
                    |> Material.button theme [ Element.centerX ]
                ]
            , Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Filled"
                    |> Button.withIcon clear
                    |> Button.onClick (Explorer.logEvent "Clicked Filled")
                    |> Button.filledButton
                    |> Material.button theme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Filled"
                    |> Button.withIcon clear
                    |> Button.disabled
                    |> Button.filledButton
                    |> Material.button theme [ Element.centerX ]
                ]
            , Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Tonal"
                    |> Button.withIcon clear
                    |> Button.onClick (Explorer.logEvent "Clicked Tonal")
                    |> Button.tonalButton
                    |> Material.button theme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Tonal"
                    |> Button.withIcon clear
                    |> Button.disabled
                    |> Button.tonalButton
                    |> Material.button theme [ Element.centerX ]
                ]
            , Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Outlined"
                    |> Button.withIcon clear
                    |> Button.onClick (Explorer.logEvent "Clicked Outlined")
                    |> Button.outlinedButton
                    |> Material.button theme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Outlined"
                    |> Button.withIcon clear
                    |> Button.disabled
                    |> Button.outlinedButton
                    |> Material.button theme [ Element.centerX ]
                ]
            , Element.column [ Element.spacing 30 ]
                [ Button.new
                    |> Button.withText "Text"
                    |> Button.withIcon clear
                    |> Button.onClick (Explorer.logEvent "Clicked Text")
                    |> Button.textButton
                    |> Material.button theme [ Element.centerX ]
                , Button.new
                    |> Button.withText "Text"
                    |> Button.withIcon clear
                    |> Button.disabled
                    |> Button.textButton
                    |> Material.button theme [ Element.centerX ]
                ]
            ]
        , Element.text "FAB"
        , Element.row [ Element.spacing 30 ]
            (let
                btn s =
                    Button.new
                        |> Button.withText (s ++ "FAB")
                        |> Button.withIcon clear
                        |> Button.onClick (Explorer.logEvent <| "Clicked " ++ s ++ " FAB")
             in
             [ btn "Small"
                |> Button.smallFAB
                |> Material.button theme [ Element.centerX ]
             , btn "Medium"
                |> Button.mediumFAB
                |> Button.color OUI.Secondary
                |> Material.button theme [ Element.centerX ]
             , btn "Large"
                |> Button.largeFAB
                |> Button.color OUI.Tertiary
                |> Material.button theme [ Element.centerX ]
             ]
            )
        , Element.text "Icon Buttons"
        , Element.row [ Element.spacing 30 ]
            (let
                btn s =
                    Button.new
                        |> Button.withText (s ++ " Icon")
                        |> Button.withIcon clear
                        |> Button.onClick (Explorer.logEvent <| "Clicked " ++ s ++ " Icon")
             in
             [ btn "Standard"
                |> Button.iconButton
                |> Material.button theme [ Element.centerX ]
             , btn "Filled"
                |> Button.filledIconButton
                |> Button.color OUI.Primary
                |> Material.button theme [ Element.centerX ]
             , btn "Outlined"
                |> Button.outlinedIconButton
                |> Button.color OUI.Primary
                |> Material.button theme [ Element.centerX ]
             ]
            )
        ]
