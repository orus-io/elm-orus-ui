module OUI.Showcase.Dividers exposing (book, commonDividers)

import Element exposing (Element)
import Element.Border
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Material as Material
import OUI.Material.Color
import OUI.Material.Theme as Theme
import OUI.Text as Text


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Dividers"
        |> Explorer.withStaticChapter commonDividers


commonDividers : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
commonDividers { theme } =
    let
        colorscheme : OUI.Material.Color.Scheme
        colorscheme =
            Theme.colorscheme theme
    in
    Element.column
        [ Element.spacing 16
        , Element.width <| Element.px 400
        , Element.Border.solid
        , Element.Border.rounded 8
        , Element.Border.width 1
        , colorscheme.surfaceContainer
            |> OUI.Material.Color.withShade colorscheme.onSurface
                OUI.Material.Color.hoverStateLayerOpacity
            |> OUI.Material.Color.toElementColor
            |> Element.Border.color
        ]
        [ Text.titleMedium "Full width divider"
            |> Material.text theme
            |> Element.el
                [ Element.paddingEach
                    { top = 16
                    , bottom = 0
                    , left = 16
                    , right = 16
                    }
                ]
        , Divider.new
            |> Material.divider theme []
        , Text.titleMedium "Inset divider"
            |> Material.text theme
            |> Element.el [ Element.paddingXY 16 0 ]
        , Divider.new
            |> Material.divider theme []
            |> Element.el [ Element.paddingXY 16 0, Element.width Element.fill ]
        , Element.none
            |> Element.el [ Element.height <| Element.px 40 ]
        ]
