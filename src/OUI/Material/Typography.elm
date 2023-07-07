module OUI.Material.Typography exposing (Typescale, Typography, attrs, getTypo, render, renderWithAttrs, renderWithTypography, typographyAttrs)

import Element exposing (Attribute, Element)
import Element.Font as Font
import OUI.Text


type alias Typography =
    { font : String
    , lineHeight : Int
    , size : Int
    , tracking : Float
    , weight : Int
    }


type alias Typescale =
    { display :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    , headline :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    , title :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    , label :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    , body :
        { small : Typography
        , medium : Typography
        , large : Typography
        }
    }


typographyAttrs : Typography -> List (Attribute msg)
typographyAttrs typography =
    -- TODO take inspiration from Paack-UI.Text
    [ Font.family [ Font.typeface typography.font ]
    , Font.size typography.size
    , if typography.weight == 500 then
        Font.medium

      else
        Font.regular
    ]


renderWithTypography : Typography -> String -> Element msg
renderWithTypography typography text =
    Element.el (typographyAttrs typography) <|
        Element.text text


getTypo : OUI.Text.Type -> OUI.Text.Size -> Typescale -> Typography
getTypo type_ size =
    (case type_ of
        OUI.Text.Display ->
            .display

        OUI.Text.Headline ->
            .headline

        OUI.Text.Title ->
            .title

        OUI.Text.Label ->
            .label

        OUI.Text.Body ->
            .body
    )
        >> (case size of
                OUI.Text.Small ->
                    .small

                OUI.Text.Medium ->
                    .medium

                OUI.Text.Large ->
                    .large
           )


attrs : OUI.Text.Type -> OUI.Text.Size -> Typescale -> List (Attribute msg)
attrs type_ size =
    getTypo type_ size >> typographyAttrs


render : Typescale -> OUI.Text.Text -> Element msg
render typescale (OUI.Text.Text type_ size text) =
    Element.el (attrs type_ size typescale) <|
        Element.text text


renderWithAttrs : Typescale -> List (Attribute msg) -> OUI.Text.Text -> Element msg
renderWithAttrs typescale customAttrs (OUI.Text.Text type_ size text) =
    Element.el
        ((typescale
            |> getTypo type_ size
            |> .lineHeight
            |> Element.px
            |> Element.height
         )
            :: attrs type_ size typescale
            ++ customAttrs
        )
    <|
        Element.text text
