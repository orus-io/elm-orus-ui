module OUI.Material.Icon exposing (render, renderWithSizeColor)

import Color exposing (Color)
import Element exposing (Attribute, Element)
import OUI
import OUI.Icon exposing (Icon)
import OUI.Material.Color
import Svg


renderWithSizeColor : Int -> Color -> List (Attribute msg) -> Icon -> Element msg
renderWithSizeColor size color attrs icon =
    let
        properties :
            { size : Maybe Int
            , color : Maybe OUI.Color
            , renderer : OUI.Icon.Renderer
            }
        properties =
            { size = OUI.Icon.getSize icon
            , color = OUI.Icon.getColor icon
            , renderer = OUI.Icon.getRenderer icon
            }
    in
    (case properties.renderer of
        OUI.Icon.Html renderHtml ->
            renderHtml size color
                |> Element.html
                |> Element.map never

        OUI.Icon.Svg renderSvg ->
            renderSvg size color
                |> List.singleton
                |> Svg.svg []
                |> Element.html
                |> Element.map never
    )
        |> Element.el
            ((Element.width <| Element.px size)
                :: (Element.height <| Element.px size)
                :: attrs
            )


render : OUI.Material.Color.Scheme -> List (Attribute msg) -> Icon -> Element msg
render colorscheme attrs icon =
    let
        properties :
            { size : Maybe Int
            , color : Maybe OUI.Color
            , renderer : OUI.Icon.Renderer
            }
        properties =
            { size = OUI.Icon.getSize icon
            , color = OUI.Icon.getColor icon
            , renderer = OUI.Icon.getRenderer icon
            }

        size : Int
        size =
            properties.size |> Maybe.withDefault 24

        color : Color
        color =
            OUI.Material.Color.getColor
                (properties.color |> Maybe.withDefault OUI.Primary)
                colorscheme
    in
    renderWithSizeColor size color attrs icon
