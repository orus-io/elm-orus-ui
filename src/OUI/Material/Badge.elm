module OUI.Material.Badge exposing (Theme, defaultTheme, render, renderBadge)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import OUI
import OUI.Badge exposing (Badge)
import OUI.Material.Color
import OUI.Material.Typography
import OUI.Text


defaultTheme : Theme
defaultTheme =
    { small =
        { shape = 3
        , size = 6
        , pos = ( 6, 6 )
        }
    , large =
        { shape = 8
        , size = 16
        , padding = 4
        , textSize = OUI.Text.Small
        , textType = OUI.Text.Label
        , textColor = OUI.Text.OnColor OUI.Error
        , pos = ( 6, 14 )
        }
    , color = OUI.Error
    }


{-| -}
type alias Theme =
    { small :
        { shape : Int
        , size : Int

        -- position of the badge bottom left corner relative to the top right corner of the element
        , pos : ( Int, Int )
        }
    , large :
        { shape : Int
        , size : Int
        , padding : Int
        , textSize : OUI.Text.Size
        , textType : OUI.Text.Type
        , textColor : OUI.Text.Color

        -- position of the badge bottom left corner relative to the top right corner of the element
        , pos : ( Int, Int )
        }
    , color : OUI.Color
    }


renderBadge :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> Badge
    -> Element msg
renderBadge typescale colorscheme theme attrs badge =
    let
        isSmall =
            case badge of
                OUI.Badge.Small ->
                    True

                _ ->
                    False

        ( shape, size ) =
            if isSmall then
                ( theme.small.shape, theme.small.size )

            else
                ( theme.large.shape, theme.large.size )

        sizeAttrs =
            if isSmall then
                [ Element.height <| Element.px size
                , Element.width <| Element.px size
                ]

            else
                [ Element.height <| Element.px size
                , Element.width <| Element.minimum size Element.shrink
                ]

        shortLabel =
            case badge of
                OUI.Badge.Small ->
                    ""

                OUI.Badge.Label s ->
                    if String.length s > 4 then
                        String.left 3 s ++ "…"

                    else
                        s

                OUI.Badge.Number i ->
                    if i > 999 then
                        "999+"

                    else
                        String.fromInt i

        label =
            case badge of
                OUI.Badge.Small ->
                    ""

                OUI.Badge.Label s ->
                    s

                OUI.Badge.Number i ->
                    String.fromInt i
    in
    Element.el
        (attrs
            ++ sizeAttrs
            ++ [ Border.rounded shape
               , Background.color <| OUI.Material.Color.getElementColor theme.color colorscheme
               , Element.paddingXY
                    (if isSmall then
                        0

                     else
                        theme.large.padding
                    )
                    0
               ]
            ++ OUI.Material.Typography.attrs
                theme.large.textType
                theme.large.textSize
                theme.large.textColor
                typescale
                colorscheme
            ++ attrs
            ++ [ Element.text label
                    |> Element.el [ Element.centerY ]
                    |> Element.el
                        [ Element.transparent True
                        , Element.mouseOver
                            [ Element.transparent False
                            ]
                        , Border.rounded shape
                        , Background.color <| OUI.Material.Color.getElementColor theme.color colorscheme
                        , Element.height <| Element.px size
                        , Element.paddingXY theme.large.padding 0
                        ]
                    |> Element.inFront
               ]
        )
    <|
        if isSmall then
            Element.none

        else
            Element.el [ Element.centerY ]
                (Element.text shortLabel)


render :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> Badge
    -> Attribute msg
render typescale colorscheme theme attrs badge =
    let
        isSmall =
            case badge of
                OUI.Badge.Small ->
                    True

                _ ->
                    False

        ( size, ( posX, posY ) ) =
            if isSmall then
                ( theme.small.size, theme.small.pos )

            else
                ( theme.large.size, theme.large.pos )

        posAttrs =
            Element.alignTop
                :: (if isSmall then
                        [ Element.moveLeft <| toFloat posX
                        , Element.moveUp <| toFloat (size - posY)
                        ]

                    else
                        [ Element.moveLeft <| toFloat posX
                        , Element.moveUp <| toFloat (size - posY)
                        ]
                   )
    in
    Element.onRight <|
        renderBadge typescale colorscheme theme (posAttrs ++ attrs) badge
