module OUI.Material.Slider exposing (Theme, defaultTheme, render)

import Color
import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Input as Input
import OUI
import OUI.Material.Color
import OUI.Slider as Slider exposing (Slider)


type alias Theme =
    { trackHeight : Int
    , labelContainerHeight : Int
    , labelContainerWidth : Int
    , handleHeight : Int
    , handleWidth : Int
    }


defaultTheme : Theme
defaultTheme =
    { trackHeight = 16
    , labelContainerHeight = 44
    , labelContainerWidth = 48
    , handleHeight = 44
    , handleWidth = 4
    }


render : OUI.Material.Color.Scheme -> Theme -> List (Attribute msg) -> Slider msg -> Element msg
render colorscheme theme attrs slider =
    let
        onChange : Maybe (Float -> msg)
        onChange =
            Slider.getOnChange slider

        ( minValue, maxValue ) =
            Slider.getMinMax slider

        step : Maybe ( Float, Bool )
        step =
            Slider.getStep slider

        color : OUI.Color
        color =
            Slider.getColor slider

        value : Float
        value =
            Slider.getValue slider

        thumbAttrs : List (Attribute Never)
        thumbAttrs =
            [ Element.width <| Element.px theme.trackHeight
            , Element.height <| Element.px theme.handleHeight
            , Element.pointer
            , Element.inFront <|
                Element.el
                    [ Element.width <| Element.px theme.handleWidth
                    , Element.height <| Element.px theme.handleHeight
                    , Element.centerX
                    , Border.rounded theme.handleWidth
                    , Background.color <|
                        OUI.Material.Color.toElementColor <|
                            OUI.Material.Color.getColor color colorscheme
                    ]
                    Element.none
            ]

        trackDot : Color.Color -> Element msg
        trackDot dotColor =
            Element.el
                [ Element.width <| Element.px theme.trackHeight
                , Element.height <| Element.px theme.trackHeight
                ]
            <|
                Element.el
                    [ Element.centerX
                    , Element.centerY
                    , Element.width <| Element.px theme.handleWidth
                    , Element.height <| Element.px theme.handleWidth
                    , Background.color <| OUI.Material.Color.toElementColor dotColor
                    , Border.rounded theme.handleHeight
                    ]
                    Element.none

        trackDots : List (Attribute msg)
        trackDots =
            case step of
                Just ( stepSize, True ) ->
                    [ Element.inFront <|
                        Element.row
                            [ Element.width Element.fill
                            , Element.height Element.fill
                            ]
                        <|
                            trackDot
                                (OUI.Material.Color.getContainerColor color colorscheme)
                                :: (List.range 1 (round ((maxValue - minValue) / stepSize))
                                        |> List.foldr
                                            (\i ->
                                                List.append
                                                    [ Element.el [ Element.width Element.fill ] Element.none
                                                    , trackDot
                                                        (if (toFloat i * stepSize + minValue) < value then
                                                            OUI.Material.Color.getContainerColor color colorscheme

                                                         else
                                                            OUI.Material.Color.getColor color colorscheme
                                                        )
                                                    ]
                                            )
                                            []
                                   )
                    ]

                _ ->
                    [ trackDot (OUI.Material.Color.getColor color colorscheme)
                        |> Element.el [ Element.alignRight ]
                        |> Element.inFront
                    ]

        trackAttrs : List (Attribute msg)
        trackAttrs =
            [ Element.height <| Element.px <| max theme.trackHeight theme.handleHeight
            , Element.behindContent <|
                Element.row
                    ([ Element.width Element.fill
                     , Element.centerY
                     ]
                        ++ trackDots
                    )
                    [ Element.row
                        [ Element.height <| Element.px theme.trackHeight
                        , Element.width <| Element.fillPortion <| round ((value - minValue) * 1000)
                        , Element.centerY
                        ]
                        [ Element.el
                            [ Background.color <|
                                OUI.Material.Color.getElementColor color colorscheme
                            , Border.roundEach
                                { topLeft = theme.trackHeight // 2
                                , bottomLeft = theme.trackHeight // 2
                                , topRight = theme.handleWidth // 2
                                , bottomRight = theme.handleWidth // 2
                                }
                            , Element.width Element.fill
                            , Element.height <| Element.px theme.trackHeight
                            ]
                            Element.none
                        ]
                    , Element.el [ Element.width <| Element.px <| theme.trackHeight ] Element.none
                    , Element.row
                        [ Element.height <| Element.px theme.trackHeight
                        , Element.width <| Element.fillPortion <| round ((maxValue - value) * 1000)
                        , Element.centerY
                        ]
                        [ Element.el
                            [ Background.color <|
                                OUI.Material.Color.getContainerElementColor color colorscheme
                            , Border.roundEach
                                { topRight = theme.trackHeight // 2
                                , bottomRight = theme.trackHeight // 2
                                , topLeft = theme.handleWidth // 2
                                , bottomLeft = theme.handleWidth // 2
                                }
                            , Element.height <| Element.px theme.trackHeight
                            , Element.width <| Element.fill
                            , Element.centerY
                            , Element.alignRight
                            ]
                            Element.none
                        ]
                    ]
            ]
    in
    case onChange of
        Just fn ->
            Input.slider (attrs ++ trackAttrs)
                { onChange = fn
                , label = Input.labelHidden ""
                , min = 0
                , max = 100
                , value = value
                , thumb = Input.thumb thumbAttrs
                , step = step |> Maybe.map Tuple.first
                }

        Nothing ->
            Element.el (attrs ++ trackAttrs) Element.none
