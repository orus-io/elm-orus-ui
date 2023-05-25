module OUI.Material.Typography exposing (..)

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


attrs : Typescale -> OUI.Text.Type -> OUI.Text.Size -> List (Attribute msg)
attrs typescale type_ size =
    typographyAttrs
        (typescale
            |> (case type_ of
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
            |> (case size of
                    OUI.Text.Small ->
                        .small

                    OUI.Text.Medium ->
                        .medium

                    OUI.Text.Large ->
                        .large
               )
        )


render : Typescale -> OUI.Text.Text -> Element msg
render typescale (OUI.Text.Text type_ size text) =
    Element.el (attrs typescale type_ size) <|
        Element.text text


renderWithAttrs : Typescale -> List (Attribute msg) -> OUI.Text.Text -> Element msg
renderWithAttrs typescale customAttrs (OUI.Text.Text type_ size text) =
    Element.el (attrs typescale type_ size ++ customAttrs) <|
        Element.text text
