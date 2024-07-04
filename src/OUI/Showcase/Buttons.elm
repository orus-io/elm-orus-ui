module OUI.Showcase.Buttons exposing (book, commonButtonVariants, commonButtons)

import Element exposing (Element)
import OUI
import OUI.Button as Button exposing (Button)
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Icon exposing (clear)
import OUI.Material as Material
import OUI.Material.Theme
import OUI.Text as Text


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Buttons"
        |> Explorer.withStaticChapter commonButtons


{-| A common button with/without icon, as a link, disabled
-}
commonButtonVariants :
    OUI.Material.Theme.Theme themeExt
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


commonButtons : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
commonButtons { theme } =
    let
        btnRow :
            String
            ->
                (Button
                    { hasNoIcon : ()
                    , needOnClickOrDisabled : ()
                    }
                    (Explorer.BookMsg msg)
                 ->
                    Button
                        { hasNoIcon : ()
                        , needOnClickOrDisabled : ()
                        }
                        (Explorer.BookMsg msg)
                )
            -> Element (Explorer.BookMsg msg)
        btnRow label btnType =
            commonButtonVariants theme label btnType
                |> (::) (Text.titleSmall label |> Material.text theme)
                |> List.map (Element.el [ Element.width <| Element.px 100 ])
                |> Element.row [ Element.spacing 30 ]

        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30 ]
        [ divider
        , Text.titleLarge "Common buttons" |> Material.text theme
        , Element.column [ Element.spacing 30 ]
            [ btnRow "Elevated" Button.elevatedButton
            , btnRow "Filled" Button.filledButton
            , btnRow "Outlined" Button.outlinedButton
            , btnRow "Text" Button.textButton
            ]
        , divider
        , Text.titleLarge "FAB" |> Material.text theme
        , Element.row [ Element.spacing 30 ]
            (let
                btn : String -> Button { hasIcon : (), needOnClickOrDisabled : () } (Explorer.BookMsg msg)
                btn s =
                    Button.new (s ++ "FAB")
                        |> Button.withIcon clear

                clickBtn : String -> Button { hasAction : (), hasIcon : () } (Explorer.BookMsg msg)
                clickBtn s =
                    btn s
                        |> Button.onClick (Explorer.logEvent <| "Clicked " ++ s ++ " FAB")

                linkBtn : String -> Button { hasAction : (), hasIcon : () } (Explorer.BookMsg msg)
                linkBtn s =
                    btn s
                        |> Button.link "#/Basics/Buttons"
             in
             [ clickBtn "Small"
                |> Button.smallFAB
                |> Button.color OUI.PrimaryContainer
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Small"
                |> Button.smallFAB
                |> Button.color OUI.PrimaryContainer
                |> Material.button theme [ Element.centerX ]
             , clickBtn "Medium"
                |> Button.mediumFAB
                |> Button.color OUI.SecondaryContainer
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Medium"
                |> Button.mediumFAB
                |> Button.color OUI.SecondaryContainer
                |> Material.button theme [ Element.centerX ]
             , clickBtn "Large"
                |> Button.largeFAB
                |> Button.color OUI.TertiaryContainer
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Large"
                |> Button.largeFAB
                |> Button.color OUI.TertiaryContainer
                |> Material.button theme [ Element.centerX ]
             , clickBtn "Extended"
                |> Button.extendedFAB
                |> Button.color OUI.Primary
                |> Material.button theme [ Element.centerX ]
             , linkBtn "Extended"
                |> Button.extendedFAB
                |> Button.color OUI.Primary
                |> Material.button theme [ Element.centerX ]
             ]
            )
        , divider
        , Text.titleLarge "Icon buttons" |> Material.text theme
        , Element.row [ Element.spacing 30 ]
            (let
                btn : String -> Button { hasIcon : (), needOnClickOrDisabled : () } (Explorer.BookMsg msg)
                btn s =
                    Button.new (s ++ " Icon")
                        |> Button.withIcon clear

                clickBtn : String -> Button { hasAction : (), hasIcon : () } (Explorer.BookMsg msg)
                clickBtn s =
                    btn s
                        |> Button.onClick (Explorer.logEvent <| "Clicked " ++ s ++ " Icon")

                linkBtn : String -> Button { hasAction : (), hasIcon : () } (Explorer.BookMsg msg)
                linkBtn s =
                    btn s
                        |> Button.link "#/Basics/Buttons"
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
