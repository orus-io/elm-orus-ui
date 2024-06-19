module OUI.Material.Dialog exposing (Theme, defaultTheme, render)

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import OUI.Button exposing (Button)
import OUI.Dialog as Dialog exposing (Dialog, dismiss)
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
    }


render :
    Typescale
    -> Color.Scheme
    -> OUI.Material.Button.Theme
    -> Theme
    -> List (Attribute msg)
    -> Dialog msg
    -> Modal msg
render typescale colorscheme buttonTheme theme attrs dialog =
    let
        hasIcon : Bool
        hasIcon =
            Dialog.icon dialog /= Nothing

        actions : List (Element msg)
        actions =
            List.filterMap
                (Maybe.map
                    (\( label, msg ) ->
                        OUI.Button.new label
                            |> OUI.Button.textButton
                            |> OUI.Button.onClick msg
                            |> OUI.Material.Button.render typescale colorscheme buttonTheme Nothing [ Element.alignRight ]
                    )
                )
                [ Dialog.dismiss dialog
                , Dialog.accept dialog
                ]
    in
    { content =
        Element.column
            [ Element.centerX
            , Element.centerY
            , Element.width <|
                Element.minimum theme.containerWidth.min <|
                    Element.maximum theme.containerWidth.max <|
                        Element.shrink
            , Element.padding theme.padding
            , Border.rounded theme.containerShape
            , Background.color <|
                Color.toElementColor colorscheme.surfaceContainerHigh
            ]
        <|
            (case Dialog.icon dialog of
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
                ++ [ Dialog.headline dialog
                        |> OUI.Text.headlineSmall
                        |> Typography.renderWithAttrs typescale
                            colorscheme
                            [ if hasIcon then
                                Element.centerX

                              else
                                Element.alignLeft
                            ]
                   ]
                ++ (case Dialog.supportingText dialog of
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
                ++ (case actions of
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
        Dialog.dismiss dialog
            |> Maybe.map Tuple.second
    }
