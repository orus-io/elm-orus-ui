module OUI.Material.Typography exposing (Typescale, Typography, attrs, getTypo, render, renderWithAttrs, renderWithTypography, typographyAttrs)

import Element exposing (Attribute, Element)
import Element.Font as Font
import OUI.Material.Color as Color
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


attrs :
    OUI.Text.Type
    -> OUI.Text.Size
    -> OUI.Text.Color
    -> Typescale
    -> Color.Scheme
    -> List (Attribute msg)
attrs type_ size color typescale colorscheme =
    typographyAttrs (getTypo type_ size typescale)
        ++ ((case color of
                OUI.Text.NoColor ->
                    Nothing

                OUI.Text.Color c ->
                    Just <| Color.getElementColor c colorscheme

                OUI.Text.OnColor c ->
                    Just <| Color.getOnElementColor c colorscheme

                OUI.Text.Custom c ->
                    Just <| Color.toElementColor c
            )
                |> Maybe.map (Font.color >> List.singleton)
                |> Maybe.withDefault []
           )


render :
    Typescale
    -> Color.Scheme
    -> OUI.Text.Text
    -> Element msg
render typescale colorscheme text =
    let
        props :
            { type_ : OUI.Text.Type
            , size : OUI.Text.Size
            , color : OUI.Text.Color
            , text : String
            }
        props =
            { type_ = OUI.Text.getType text
            , size = OUI.Text.getSize text
            , color = OUI.Text.getColor text
            , text = OUI.Text.getText text
            }
    in
    Element.el (attrs props.type_ props.size props.color typescale colorscheme) <|
        Element.text props.text


renderWithAttrs :
    Typescale
    -> Color.Scheme
    -> List (Attribute msg)
    -> OUI.Text.Text
    -> Element msg
renderWithAttrs typescale colorscheme customAttrs text =
    let
        props :
            { type_ : OUI.Text.Type
            , size : OUI.Text.Size
            , color : OUI.Text.Color
            , text : String
            }
        props =
            { type_ = OUI.Text.getType text
            , size = OUI.Text.getSize text
            , color = OUI.Text.getColor text
            , text = OUI.Text.getText text
            }
    in
    Element.el
        (attrs props.type_ props.size props.color typescale colorscheme
            ++ customAttrs
        )
    <|
        Element.text props.text
