module OUI.Showcase.Buttons exposing (..)

import Element exposing (Element)
import OUI
import OUI.Button as Button exposing (Button)
import OUI.Explorer as Explorer exposing (Explorer)
import OUI.Icon exposing (clear)
import OUI.Material as Material
import OUI.Material.Theme


book =
    Explorer.book "Buttons"
        |> Explorer.withStaticChapter commonButtons


{-| A common button with/without icon, as a link, disabled
-}
commonButtonVariants :
    OUI.Material.Theme.Theme
    -> String
    -> (Button { hasNoIcon : (), needOnClickOrDisabled : () } (Explorer.BookMsg msg) -> Button { hasNoIcon : (), needOnClickOrDisabled : () } (Explorer.BookMsg msg))
    -> List (Element (Explorer.BookMsg msg))
commonButtonVariants theme label btnType =
    [ -- no icon, action
      Button.new label
        |> btnType
        |> Button.onClick (Explorer.logEvent <| "Clicked " ++ label)
        |> Material.button theme [ Element.centerX ]
    , -- icon, action
      Button.new "with Icon"
        |> btnType
        |> Button.withIcon clear
        |> Button.onClick (Explorer.logEvent <| "Clicked " ++ label ++ " + icon")
        |> Material.button theme [ Element.centerX ]
    , -- no icon, link
      Button.new "Link"
        |> btnType
        |> Button.link "#/Basics/Buttons"
        |> Material.button theme [ Element.centerX ]
    , -- icon, link
      Button.new "Link Icon"
        |> btnType
        |> Button.withIcon clear
        |> Button.link "#/Basics/Buttons"
        |> Material.button theme [ Element.centerX ]
    , -- icon, disabled
      Button.new "Disabled"
        |> btnType
        |> Button.withIcon clear
        |> Button.disabled
        |> Material.button theme [ Element.centerX ]
    ]


commonButtons : Explorer.Shared -> Element (Explorer.BookMsg ())
commonButtons { theme } =
    let
        btnRow label btnType =
            commonButtonVariants theme label btnType
                |> (::) (Element.text label)
                |> List.map (Element.el [ Element.width <| Element.px 100 ])
                |> Element.row [ Element.spacing 30 ]
    in
    Element.column [ Element.spacing 30 ]
        [ Element.text "Common buttons"
        , Element.column [ Element.spacing 30 ]
            [ btnRow "Elevated" Button.elevatedButton
            , btnRow "Filled" Button.filledButton
            , btnRow "Tonal" Button.tonalButton
            , btnRow "Outlined" Button.outlinedButton
            , btnRow "Text" Button.textButton
            ]
        , Element.text "FAB"
        , Element.row [ Element.spacing 30 ]
            (let
                btn s =
                    Button.new (s ++ "FAB")
                        |> Button.withIcon clear

                clickBtn s =
                    btn s
                        |> Button.onClick (Explorer.logEvent <| "Clicked " ++ s ++ " FAB")

                linkBtn s =
                    btn s
                        |> Button.link "#/Basics/Button"
             in
             [ clickBtn "Small"
                |> Button.smallFAB
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Small"
                |> Button.smallFAB
                |> Material.button theme [ Element.centerX ]
             , clickBtn "Medium"
                |> Button.mediumFAB
                |> Button.color OUI.Secondary
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Medium"
                |> Button.mediumFAB
                |> Button.color OUI.Secondary
                |> Material.button theme [ Element.centerX ]
             , clickBtn "Large"
                |> Button.largeFAB
                |> Button.color OUI.Tertiary
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Large"
                |> Button.largeFAB
                |> Button.color OUI.Tertiary
                |> Material.button theme [ Element.centerX ]
             ]
            )
        , Element.text "Icon Buttons"
        , Element.row [ Element.spacing 30 ]
            (let
                btn s =
                    Button.new (s ++ " Icon")
                        |> Button.withIcon clear

                clickBtn s =
                    btn s
                        |> Button.onClick (Explorer.logEvent <| "Clicked " ++ s ++ " Icon")

                linkBtn s =
                    btn s
                        |> Button.link "#/Basics/Button"
             in
             [ clickBtn "Standard"
                |> Button.iconButton
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Standard"
                |> Button.iconButton
                |> Material.button theme [ Element.centerX ]
             , clickBtn "Filled"
                |> Button.filledIconButton
                |> Button.color OUI.Primary
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Filled"
                |> Button.filledIconButton
                |> Button.color OUI.Primary
                |> Material.button theme [ Element.centerX ]
             , clickBtn "Outlined"
                |> Button.outlinedIconButton
                |> Button.color OUI.Primary
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Outlined"
                |> Button.outlinedIconButton
                |> Button.color OUI.Primary
                |> Material.button theme [ Element.centerX ]
             ]
            )
        ]
