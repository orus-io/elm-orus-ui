module OUI.Material.Button exposing (..)

import Element exposing (Attribute, Element)
import Element.Border as Border
import Element.Input as Input
import OUI
import OUI.Button exposing (Button, getProperties)
import OUI.Material exposing (Palette)


defaultTheme : Theme
defaultTheme =
    let
        medium =
            { containerHeight = 40
            , containerRadius = 20
            , iconSize = 18
            , leftRightPadding = 24
            , leftPaddingWithIcon = 16
            , rightPaddingWithIcon = 16
            , paddingBetweenElements = 8

            --, labelTextAlignment =
            }
    in
    { small = medium
    , medium = medium
    , large = medium
    }


type alias Theme =
    { small : Layout
    , medium : Layout
    , large : Layout
    }


type alias Layout =
    { containerHeight : Int
    , containerRadius : Int
    , iconSize : Int
    , leftRightPadding : Int
    , leftPaddingWithIcon : Int
    , rightPaddingWithIcon : Int
    , paddingBetweenElements : Int

    -- Label text alignment Center-aligned
    }


borderAttrs : OUI.Button.Type -> Layout -> List (Attribute msg)
borderAttrs btnType layout =
    case btnType of
        OUI.Button.Elevated ->
            [ Border.rounded layout.containerRadius
            , Border.shadow
                { offset = ( 1, 1 )
                , size = 1
                , blur = 0
                , color = Element.rgb 0 0 0
                }
            ]

        _ ->
            []


render :
    Theme
    -> Palette
    -> List (Attribute msg)
    -> Button { constraints | hasText : (), hasAction : () } msg
    -> Element msg
render theme palette attrs button =
    let
        props =
            getProperties button

        layout =
            case props.size of
                OUI.Small ->
                    theme.small

                OUI.Medium ->
                    theme.medium

                OUI.Large ->
                    theme.large

        padding =
            case props.icon of
                Nothing ->
                    Element.paddingXY layout.leftRightPadding 0

                Just _ ->
                    Element.paddingEach
                        { top = 0
                        , bottom = 0
                        , left = layout.leftPaddingWithIcon
                        , right = layout.rightPaddingWithIcon
                        }

        label =
            case props.icon of
                Nothing ->
                    Element.text props.text

                Just icon ->
                    Element.row [ Element.spacing layout.paddingBetweenElements ]
                        [ Element.text icon, Element.text props.text ]
    in
    Input.button
        ((Element.height <| Element.px layout.containerHeight)
            :: padding
            :: attrs
            ++ borderAttrs props.type_ layout
        )
        { label = label
        , onPress = props.onClick
        }
