module OUI.Material.Dialog exposing (Theme, defaultTheme, render)

import Element exposing (Attribute)
import Element.Background as Background
import Element.Border as Border
import OUI
import OUI.Button
import OUI.Dialog as Dialog exposing (Dialog)
import OUI.Element.Modal exposing (Modal)
import OUI.Icon
import OUI.Material.Button
import OUI.Material.Color as Color
import OUI.Material.Icon
import OUI.Material.Typography as Typography exposing (Typescale)
import OUI.Text


type alias Theme =
    { containerShape : Int
    , containerWidth : { min : Int, max : Int }
    , iconSize : Int
    , padding : Int
    , paddingBetweenButtons : Int
    , paddingBetweenIconAndTitle : Int
    , paddingBetweenTitleAndBody : Int
    , paddingBetweenBodyAndAction : Int
    , fsCloseIcon : OUI.Icon.Icon
    }


defaultTheme : Theme
defaultTheme =
    { containerShape = 28
    , containerWidth = { min = 280, max = 560 }
    , iconSize = 24
    , padding = 24
    , paddingBetweenButtons = 8
    , paddingBetweenIconAndTitle = 16
    , paddingBetweenTitleAndBody = 16
    , paddingBetweenBodyAndAction = 24
    , fsCloseIcon = OUI.Icon.clear
    }


render :
    Typescale
    -> Color.Scheme
    -> OUI.Material.Button.Theme
    -> Theme
    -> List (Attribute msg)
    -> Maybe (Element.Element msg)
    -> Dialog msg
    -> Modal msg
render typescale colorscheme buttonTheme theme attrs content dialog =
    let
        hasIcon : Bool
        hasIcon =
            Dialog.getIcon dialog /= Nothing

        dismissAction : Maybe ( String, msg )
        dismissAction =
            Dialog.getDismiss dialog

        acceptAction : Maybe ( String, msg )
        acceptAction =
            Dialog.getAccept dialog

        isfullscreen : Bool
        isfullscreen =
            Dialog.getWidth dialog == Dialog.Fullscreen
    in
    { content =
        Element.column
            (attrs
                ++ [ Element.centerX
                   , Element.centerY
                   , Element.width <|
                        case Dialog.getWidth dialog of
                            Dialog.Small ->
                                Element.px theme.containerWidth.min

                            Dialog.Medium ->
                                Element.px <| (theme.containerWidth.min + theme.containerWidth.max) // 2

                            Dialog.Large ->
                                Element.px theme.containerWidth.max

                            Dialog.AutoWidth ->
                                Element.minimum theme.containerWidth.min <|
                                    Element.maximum theme.containerWidth.max <|
                                        Element.shrink

                            Dialog.Fullscreen ->
                                Element.fill
                   , Element.height <|
                        if isfullscreen then
                            Element.fill

                        else
                            Element.shrink
                   , Element.padding theme.padding
                   , Border.rounded <|
                        if isfullscreen then
                            0

                        else
                            theme.containerShape
                   , Background.color <|
                        Color.toElementColor colorscheme.surfaceContainerHigh
                   ]
            )
        <|
            (case Dialog.getIcon dialog of
                Just icon ->
                    [ icon
                        |> OUI.Icon.withSize theme.iconSize
                        |> OUI.Material.Icon.render colorscheme
                            [ Element.centerX
                            ]
                        |> Element.el
                            [ Element.width Element.fill
                            , Element.paddingEach
                                { top = 0
                                , bottom = theme.paddingBetweenIconAndTitle
                                , left = 0
                                , right = 0
                                }
                            ]
                    ]

                Nothing ->
                    []
            )
                ++ [ Dialog.getHeadline dialog
                        |> OUI.Text.headlineSmall
                        |> Typography.renderWithAttrs typescale
                            colorscheme
                            [ case ( isfullscreen, hasIcon ) of
                                ( True, _ ) ->
                                    Element.alignLeft

                                ( False, True ) ->
                                    Element.centerX

                                ( False, False ) ->
                                    Element.alignLeft
                            ]
                        |> (if isfullscreen then
                                \h ->
                                    Element.row
                                        [ Element.width Element.fill
                                        ]
                                        [ case dismissAction of
                                            Just ( label, msg ) ->
                                                OUI.Button.new label
                                                    |> OUI.Button.withIcon theme.fsCloseIcon
                                                    |> OUI.Button.iconButton
                                                    |> OUI.Button.onClick msg
                                                    |> OUI.Button.color OUI.Neutral
                                                    |> OUI.Material.Button.render typescale colorscheme buttonTheme Nothing []

                                            Nothing ->
                                                Element.none
                                        , h
                                        , case acceptAction of
                                            Just ( label, msg ) ->
                                                OUI.Button.new label
                                                    |> OUI.Button.textButton
                                                    |> OUI.Button.onClick msg
                                                    |> OUI.Material.Button.render typescale colorscheme buttonTheme Nothing [ Element.alignRight ]

                                            Nothing ->
                                                Element.none
                                        ]

                            else
                                identity
                           )
                   ]
                ++ (case Dialog.getSupportingText dialog of
                        Just text ->
                            [ Element.paragraph
                                []
                                [ OUI.Text.bodyMedium text
                                    |> Typography.render typescale colorscheme
                                ]
                                |> Element.el
                                    [ if hasIcon then
                                        Element.centerX

                                      else
                                        Element.alignLeft
                                    , Element.paddingEach
                                        { top = theme.paddingBetweenTitleAndBody
                                        , bottom = 0
                                        , right = 0
                                        , left = 0
                                        }
                                    ]
                            ]

                        Nothing ->
                            []
                   )
                ++ (case content of
                        Just el ->
                            [ Element.el
                                [ Element.paddingEach
                                    { top = theme.paddingBetweenTitleAndBody
                                    , bottom = 0
                                    , right = 0
                                    , left = 0
                                    }
                                , Element.width Element.fill
                                ]
                                el
                            ]

                        Nothing ->
                            []
                   )
                ++ (if isfullscreen then
                        []

                    else
                        case
                            List.filterMap
                                (Maybe.map
                                    (\( label, msg ) ->
                                        OUI.Button.new label
                                            |> OUI.Button.textButton
                                            |> OUI.Button.onClick msg
                                            |> OUI.Material.Button.render typescale colorscheme buttonTheme Nothing [ Element.alignRight ]
                                    )
                                )
                                [ dismissAction
                                , acceptAction
                                ]
                        of
                            [] ->
                                []

                            buttons ->
                                [ Element.row
                                    [ Element.width Element.fill
                                    , Element.paddingEach
                                        { top = theme.paddingBetweenBodyAndAction
                                        , bottom = 0
                                        , left = 0
                                        , right = 0
                                        }
                                    , Element.spacing theme.paddingBetweenButtons
                                    ]
                                    buttons
                                ]
                   )
    , onDismiss =
        Dialog.getDismiss dialog
            |> Maybe.map Tuple.second
    }
