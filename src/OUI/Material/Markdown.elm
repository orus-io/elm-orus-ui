module OUI.Material.Markdown exposing (renderer)

import Element exposing (Element)
import Element.Font as Font
import Html
import Html.Attributes
import Markdown.Block as Block
import Markdown.Html
import Markdown.Renderer
import OUI.Checkbox
import OUI.Material as Material
import OUI.Material.Theme exposing (Theme)
import OUI.Material.Typography as Typography
import OUI.Text


renderer : Theme themeExt -> Markdown.Renderer.Renderer (Element msg)
renderer ({ typescale } as theme) =
    { heading =
        \{ level, children } ->
            case level of
                Block.H1 ->
                    Element.paragraph (Typography.attrs OUI.Text.Display OUI.Text.Small typescale) children

                Block.H2 ->
                    Element.paragraph (Typography.attrs OUI.Text.Headline OUI.Text.Large typescale) children

                Block.H3 ->
                    Element.paragraph (Typography.attrs OUI.Text.Headline OUI.Text.Medium typescale) children

                Block.H4 ->
                    Element.paragraph (Typography.attrs OUI.Text.Headline OUI.Text.Small typescale) children

                Block.H5 ->
                    Element.paragraph (Typography.attrs OUI.Text.Title OUI.Text.Large typescale) children

                Block.H6 ->
                    Element.paragraph (Typography.attrs OUI.Text.Title OUI.Text.Medium typescale) children
    , paragraph =
        Element.paragraph
            (Typography.attrs OUI.Text.Body OUI.Text.Large typescale)
    , hardLineBreak = Html.br [] [] |> Element.html
    , blockQuote = Element.column [ Font.family [ Font.monospace ] ]
    , strong =
        Element.paragraph [ Font.bold ]
    , emphasis =
        Element.paragraph [ Font.italic ]
    , strikethrough =
        Element.paragraph [ Font.strike ]
    , codeSpan =
        Element.el [ Font.family [ Font.monospace ] ]
            << Element.text
    , link =
        -- TODO handle link.title
        \link content ->
            Element.link []
                { url = link.destination
                , label = Element.paragraph [] content
                }
    , image =
        -- TODO handle imageInfo.title
        \imageInfo ->
            Element.image []
                { src = imageInfo.src
                , description = imageInfo.alt
                }
    , text =
        Element.text
    , unorderedList =
        \items ->
            Element.column []
                (items
                    |> List.map
                        (\item ->
                            case item of
                                Block.ListItem task children ->
                                    let
                                        checkbox : Element msg
                                        checkbox =
                                            case task of
                                                Block.NoTask ->
                                                    Element.text ""

                                                Block.IncompleteTask ->
                                                    OUI.Checkbox.new
                                                        |> OUI.Checkbox.disabled
                                                        |> OUI.Checkbox.withChecked False
                                                        |> Material.checkbox theme []

                                                Block.CompletedTask ->
                                                    OUI.Checkbox.new
                                                        |> OUI.Checkbox.disabled
                                                        |> OUI.Checkbox.withChecked True
                                                        |> Material.checkbox theme []
                                    in
                                    Element.row [] (checkbox :: children)
                        )
                )
    , orderedList =
        \startingIndex items ->
            Element.column []
                (items
                    |> List.indexedMap
                        (\i itemBlocks ->
                            Element.row []
                                (Element.text (String.fromInt (i + startingIndex) ++ ".") :: itemBlocks)
                        )
                )
    , html = Markdown.Html.oneOf []
    , codeBlock =
        \{ body, language } ->
            let
                classes : List (Html.Attribute msg)
                classes =
                    -- Only the first word is used in the class
                    case Maybe.map String.words language of
                        Just (actualLanguage :: _) ->
                            [ Html.Attributes.class <| "language-" ++ actualLanguage ]

                        _ ->
                            []
            in
            Html.pre []
                [ Html.code classes
                    [ Html.text body
                    ]
                ]
                |> Element.html
    , thematicBreak = Html.hr [] [] |> Element.html
    , table = always Element.none
    , tableHeader = always Element.none
    , tableBody = always Element.none
    , tableRow = always Element.none
    , tableHeaderCell = \_ _ -> Element.none
    , tableCell = \_ _ -> Element.none
    }
