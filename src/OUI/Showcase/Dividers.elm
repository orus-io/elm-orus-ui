module OUI.Showcase.Dividers exposing (..)

import Color
import Element exposing (Element)
import Element.Border
import OUI
import OUI.Divider as Divider
import OUI.Explorer as Explorer exposing (Explorer)
import OUI.Material as Material
import OUI.Material.Color
import OUI.Material.Theme


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Dividers"
        |> Explorer.withStaticChapter commonDividers


commonDividers : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
commonDividers { theme } =
    Element.column
        [ Element.spacing 30
        , Element.width <| Element.px 400
        , Element.padding 10
        , Element.Border.solid
        , Element.Border.width 2
        , Element.Border.color <| OUI.Material.Color.toElementColor Color.white
        ]
        [ Element.text "Common dividers"
        , Element.column [ Element.spacing 30, Element.width Element.fill ]
            [ Element.text "Full width divider"
            , Divider.new
                |> Divider.fullWidthDivider
                |> Divider.color OUI.Error
                |> Material.divider theme []
            , Element.text "Part width divider"
            , Divider.new
                |> Divider.insetDivider
                |> Material.divider theme []
            , Element.text "lorem ipsum"
            ]
        ]
