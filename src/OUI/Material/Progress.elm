module OUI.Material.Progress exposing (Theme, defaultTheme, render)

import Color
import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import OUI.Material.Color
import OUI.Progress exposing (Progress)
import Svg
import Svg.Attributes


type alias Theme =
    { activeIndicator : { thickness : Int }
    , trackIndicator : { thickness : Int }
    , circularSize : Int
    }


defaultTheme : Theme
defaultTheme =
    { activeIndicator = { thickness = 4 }
    , trackIndicator = { thickness = 4 }
    , circularSize = 48
    }


render :
    OUI.Material.Color.Scheme
    -> Theme
    -> List (Attribute msg)
    -> Progress
    -> Element msg
render colorscheme theme attrs progress =
    let
        props =
            OUI.Progress.properties progress
    in
    case ( props.type_, props.value ) of
        ( OUI.Progress.Circular, Nothing ) ->
            indeterminateCircular theme (OUI.Material.Color.getColor props.color colorscheme) attrs

        ( OUI.Progress.Circular, Just value ) ->
            determinateCircular theme
                (OUI.Material.Color.getColor props.color colorscheme)
                (OUI.Material.Color.getContainerColor props.color colorscheme)
                attrs
                value

        ( OUI.Progress.Linear, Nothing ) ->
            indeterminateLinear theme
                (OUI.Material.Color.getColor props.color colorscheme)
                (OUI.Material.Color.getContainerColor props.color colorscheme)
                attrs

        ( OUI.Progress.Linear, Just value ) ->
            determinateLinear theme
                (OUI.Material.Color.getColor props.color colorscheme)
                (OUI.Material.Color.getContainerColor props.color colorscheme)
                attrs
                value


indeterminateLinear :
    Theme
    -> Color.Color
    -> Color.Color
    -> List (Attribute msg)
    -> Element msg
indeterminateLinear theme color trackColor attrs =
    let
        thickest =
            max theme.activeIndicator.thickness theme.trackIndicator.thickness
    in
    Element.row
        ((Element.height <| Element.px thickest)
            :: attrs
        )
        [ Element.row
            [ Element.width <| Element.fillPortion 1
            , Element.height <| Element.px theme.trackIndicator.thickness
            , Element.clipX
            ]
          <|
            [ Element.el
                [ Element.width Element.fill
                , Element.height <| Element.px theme.trackIndicator.thickness
                , Background.color <| OUI.Material.Color.toElementColor trackColor
                , Border.rounded theme.trackIndicator.thickness
                ]
                Element.none
            , Element.el
                [ Element.width <| Element.px thickest
                ]
                Element.none
            ]
        , Element.el
            [ Element.width <| Element.fillPortion 1
            , Element.height <| Element.px theme.activeIndicator.thickness
            , Background.color <| OUI.Material.Color.toElementColor color
            , Border.rounded theme.activeIndicator.thickness
            ]
            Element.none
        , Element.row
            [ Element.width <| Element.fillPortion 1
            , Element.height <| Element.px theme.trackIndicator.thickness
            , Element.clipX
            ]
          <|
            [ Element.el
                [ Element.width <| Element.px thickest
                ]
                Element.none
            , Element.el
                [ Element.width Element.fill
                , Element.height <| Element.px theme.trackIndicator.thickness
                , Background.color <| OUI.Material.Color.toElementColor trackColor
                , Border.rounded theme.trackIndicator.thickness
                ]
                Element.none
            ]
        ]


determinateLinear :
    Theme
    -> Color.Color
    -> Color.Color
    -> List (Attribute msg)
    -> Float
    -> Element msg
determinateLinear theme color trackColor attrs value =
    let
        thickest =
            max theme.activeIndicator.thickness theme.trackIndicator.thickness

        clampedProgress =
            clamp 0 1.0 value

        isZero =
            clampedProgress == 0

        activeLen =
            clampedProgress * 1000 |> floor
    in
    Element.row
        ((Element.height <| Element.px thickest)
            :: (Element.inFront <|
                    Element.el
                        [ Element.width <| Element.px theme.trackIndicator.thickness
                        , Element.height <| Element.px theme.trackIndicator.thickness
                        , Border.rounded theme.trackIndicator.thickness
                        , Element.alignRight
                        , Background.color <| OUI.Material.Color.toElementColor color
                        ]
                        Element.none
               )
            :: attrs
        )
        [ if activeLen /= 0 then
            Element.el
                [ Element.width <| Element.fillPortion activeLen
                , Element.height <| Element.px theme.activeIndicator.thickness
                , Background.color <| OUI.Material.Color.toElementColor color
                , Border.rounded theme.activeIndicator.thickness
                ]
                Element.none

          else
            Element.none
        , if activeLen /= 1000 then
            Element.row
                [ Element.width <| Element.fillPortion (1000 - activeLen)
                , Element.height <| Element.px theme.trackIndicator.thickness
                , Element.clipX
                ]
            <|
                [ Element.el
                    [ Element.width <|
                        Element.px <|
                            if activeLen == 0 then
                                0

                            else
                                thickest
                    ]
                    Element.none
                , Element.el
                    [ Element.width Element.fill
                    , Element.height <| Element.px theme.trackIndicator.thickness
                    , Background.color <| OUI.Material.Color.toElementColor trackColor
                    , Border.rounded theme.trackIndicator.thickness
                    ]
                    Element.none
                ]

          else
            Element.none
        ]


indeterminateCircular : Theme -> Color.Color -> List (Attribute msg) -> Element msg
indeterminateCircular theme color attribs =
    -- Based on example at https://codepen.io/FezVrasta/pen/oXrgdR
    Svg.svg
        [ Svg.Attributes.height <| String.fromInt theme.circularSize ++ "px"
        , Svg.Attributes.width <| String.fromInt theme.circularSize ++ "px"
        , Svg.Attributes.viewBox "0 0 66 66"
        , Svg.Attributes.xmlSpace "http://www.w3.org/2000/svg"
        ]
        [ Svg.g []
            [ Svg.animateTransform
                [ Svg.Attributes.attributeName "transform"
                , Svg.Attributes.type_ "rotate"
                , Svg.Attributes.values "0 33 33;270 33 33"
                , Svg.Attributes.begin "0s"
                , Svg.Attributes.dur "1.4s"
                , Svg.Attributes.fill "freeze"
                , Svg.Attributes.repeatCount "indefinite"
                ]
                []
            , Svg.circle
                [ Svg.Attributes.fill "none"
                , Svg.Attributes.stroke (Color.toCssString color)
                , Svg.Attributes.strokeWidth "5"
                , Svg.Attributes.strokeLinecap "round"
                , Svg.Attributes.cx "33"
                , Svg.Attributes.cy "33"
                , Svg.Attributes.r "30"
                , Svg.Attributes.strokeDasharray "187"
                , Svg.Attributes.strokeDashoffset "610"
                ]
                [ Svg.animateTransform
                    [ Svg.Attributes.attributeName "transform"
                    , Svg.Attributes.type_ "rotate"
                    , Svg.Attributes.values "0 33 33;135 33 33;450 33 33"
                    , Svg.Attributes.begin "0s"
                    , Svg.Attributes.dur "1.4s"
                    , Svg.Attributes.fill "freeze"
                    , Svg.Attributes.repeatCount "indefinite"
                    ]
                    []
                , Svg.animate
                    [ Svg.Attributes.attributeName "stroke-dashoffset"
                    , Svg.Attributes.values "187;46.75;187"
                    , Svg.Attributes.begin "0s"
                    , Svg.Attributes.dur "1.4s"
                    , Svg.Attributes.fill "freeze"
                    , Svg.Attributes.repeatCount "indefinite"
                    ]
                    []
                ]
            ]
        ]
        |> Element.html
        |> Element.el attribs


determinateCircular :
    Theme
    -> Color.Color
    -> Color.Color
    -> List (Attribute msg)
    -> Float
    -> Element msg
determinateCircular theme color trackColor attribs progress =
    -- With help from https://css-tricks.com/building-progress-ring-quickly/
    let
        thickest =
            max theme.activeIndicator.thickness theme.trackIndicator.thickness

        radius =
            toFloat (theme.circularSize - thickest)
                / 2
                |> floor

        circumference =
            3.1416 * toFloat radius * 2.0

        activeThicknessD =
            toFloat theme.activeIndicator.thickness
                * 360
                / circumference
                |> floor

        gapSize =
            toFloat thickest
                * 2
                * 360
                / circumference
                |> round

        clampedProgress =
            clamp 0 1 progress

        isZero =
            clampedProgress == 0

        isFull =
            clampedProgress == 1

        activeLen =
            if isZero then
                0

            else
                ceiling (360 * clampedProgress)
                    |> max activeThicknessD

        trackLen =
            if isZero then
                360

            else if isFull then
                0

            else
                (360 - activeLen - (2 * gapSize))
                    |> max 0

        activeStrokeDashoffset =
            String.fromFloat <|
                if isFull then
                    0

                else if isZero then
                    360

                else
                    360
                        - activeLen
                        + activeThicknessD
                        |> toFloat
                        |> min 359.9

        activeIndicatorRotation =
            -90
                + (activeThicknessD // 2)
                |> String.fromInt

        trackStrokeDashoffset =
            if isZero then
                0

            else
                360 - trackLen

        trackIndicatorRotation =
            (-90
                + gapSize
                + activeLen
            )
                |> String.fromInt

        size =
            String.fromInt theme.circularSize

        halfSize =
            String.fromInt <| theme.circularSize // 2

        activeThickness =
            String.fromInt theme.activeIndicator.thickness

        trackThickness =
            String.fromInt theme.trackIndicator.thickness
    in
    Svg.svg
        [ Svg.Attributes.height <| size ++ "px"
        , Svg.Attributes.width <| size ++ "px"
        , Svg.Attributes.viewBox <| "0 0 " ++ size ++ " " ++ size
        , Svg.Attributes.xmlSpace "http://www.w3.org/2000/svg"
        ]
        [ Svg.g []
            [ Svg.circle
                [ Svg.Attributes.fill "none"
                , Svg.Attributes.pathLength "360"
                , Svg.Attributes.stroke (Color.toCssString trackColor)
                , Svg.Attributes.strokeWidth trackThickness
                , Svg.Attributes.strokeLinecap "round"
                , Svg.Attributes.cx halfSize
                , Svg.Attributes.cy halfSize
                , Svg.Attributes.r <| String.fromInt radius
                , Svg.Attributes.strokeDasharray "360 360"
                , Svg.Attributes.strokeDashoffset (String.fromInt trackStrokeDashoffset)
                , Svg.Attributes.transform <| "rotate(" ++ trackIndicatorRotation ++ " " ++ halfSize ++ " " ++ halfSize ++ ")"
                ]
                []
            , Svg.circle
                [ Svg.Attributes.fill "none"
                , Svg.Attributes.pathLength "360"
                , Svg.Attributes.stroke (Color.toCssString color)
                , Svg.Attributes.strokeWidth activeThickness
                , Svg.Attributes.strokeLinecap "round"
                , Svg.Attributes.cx halfSize
                , Svg.Attributes.cy halfSize
                , Svg.Attributes.r <| String.fromInt radius
                , Svg.Attributes.strokeDasharray "360 360"
                , Svg.Attributes.strokeDashoffset activeStrokeDashoffset
                , Svg.Attributes.transform <| "rotate(" ++ activeIndicatorRotation ++ " " ++ halfSize ++ " " ++ halfSize ++ ")"
                ]
                []
            ]
        ]
        |> Element.html
        |> Element.el attribs
