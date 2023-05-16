module OUI.Material.Typography exposing (..)

import Element exposing (Element)
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


renderWithTypograph : Typography -> String -> Element msg
renderWithTypograph typography text =
    -- TODO take inspiration from Paack-UI.Text
    Element.el
        [ Font.family [ Font.typeface typography.font ]
        , Font.size typography.size
        ]
    <|
        Element.text text


render : Typescale -> OUI.Text.Text -> Element msg
render typescale (OUI.Text.Text type_ size text) =
    renderWithTypograph
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
        text
