module OUI.Material.TextField exposing (Theme, defaultTheme, filterMaybe, ifThenElse, render, transition)

import Color
import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html.Attributes
import OUI
import OUI.Button as Button
import OUI.Material.Button as Button
import OUI.Material.Color
import OUI.Material.Icon
import OUI.Material.Typography
import OUI.Text
import OUI.TextField


ifThenElse : Bool -> a -> a -> a
ifThenElse value ifTrue ifFalse =
    if value then
        ifTrue

    else
        ifFalse


filterMaybe : List (Maybe a) -> List a
filterMaybe =
    List.filterMap identity


transition : String -> Attribute msg
transition =
    Html.Attributes.style "transition"
        >> Element.htmlAttribute


type alias Theme =
    { height : Int
    , leftRightPaddingWithoutIcon : Int
    , leftRightPaddingWithIcon : Int
    , paddingBetweenIconAndText : Int
    , supportingTextTopPadding : Int
    , paddingBetweenSupportingTextAndCharacterCounter : Int
    , iconSize : Int
    , filled :
        { topBottomPadding : Int
        }
    , outlined :
        { labelLeftRightPadding : Int
        , labelBottom : Int
        , shape : Int
        }
    }


defaultTheme : Theme
defaultTheme =
    { height = 56
    , leftRightPaddingWithoutIcon = 16
    , leftRightPaddingWithIcon = 12
    , paddingBetweenIconAndText = 16
    , supportingTextTopPadding = 4
    , paddingBetweenSupportingTextAndCharacterCounter = 16
    , iconSize = 24
    , filled =
        { topBottomPadding = 8
        }
    , outlined =
        { labelLeftRightPadding = 4
        , labelBottom = 8
        , shape = 4 -- TODO use shape.corner.extra-small
        }
    }


render :
    OUI.Material.Typography.Typescale
    -> OUI.Material.Color.Scheme
    -> Button.Theme
    -> Theme
    -> List (Attribute msg)
    -> OUI.TextField.TextField msg
    -> Element msg
render typescale colorscheme buttonTheme theme attrs textfield =
    let
        p =
            OUI.TextField.properties textfield

        isEmpty =
            p.value == ""

        hasError =
            OUI.Material.Color.isError p.color

        isOutlined =
            p.type_ == OUI.TextField.Outlined

        isFilled =
            p.type_ == OUI.TextField.Filled

        labelHoldPlace =
            isEmpty && not p.hasFocus

        hasLeadingIcon =
            p.leadingIcon /= Nothing

        focusEvents =
            List.filterMap identity
                [ p.onFocus |> Maybe.map Events.onFocus
                , p.onLoseFocus |> Maybe.map Events.onLoseFocus
                ]

        bgColorAttr =
            case p.type_ of
                OUI.TextField.Filled ->
                    colorscheme.surfaceContainerHighest
                        |> OUI.Material.Color.toElementColor
                        |> Background.color

                OUI.TextField.Outlined ->
                    colorscheme.surface
                        |> OUI.Material.Color.toElementColor
                        |> Background.color

        topBorderWidth =
            if isOutlined then
                ifThenElse p.hasFocus 2 1

            else
                0

        bottomBorderWidth =
            ifThenElse p.hasFocus 2 1

        leftBorderWidth =
            if isOutlined then
                ifThenElse p.hasFocus 2 1

            else
                0

        rightBorderWidth =
            if isOutlined then
                ifThenElse p.hasFocus 2 1

            else
                0

        inputMoveDownBy =
            if isFilled && not labelHoldPlace then
                (theme.height - theme.filled.topBottomPadding)
                    - (theme.height // 2 + typescale.body.large.lineHeight // 2)

            else
                0

        borderColor =
            if hasError || p.hasFocus then
                OUI.Material.Color.getElementColor p.color colorscheme

            else
                OUI.Material.Color.toElementColor colorscheme.onSurfaceVariant

        borderAttrs =
            transition "color 0.15s"
                :: Border.color borderColor
                :: (case p.type_ of
                        OUI.TextField.Filled ->
                            [ Border.widthEach
                                { bottom = bottomBorderWidth
                                , top = 0
                                , right = 0
                                , left = 0
                                }
                            ]

                        OUI.TextField.Outlined ->
                            [ Border.widthEach
                                { bottom = bottomBorderWidth
                                , top = topBorderWidth
                                , right = rightBorderWidth
                                , left = leftBorderWidth
                                }
                            , Border.rounded theme.outlined.shape
                            ]
                   )

        heightAttr =
            if p.isMultiline then
                [ Element.scrollbarY
                , Element.height Element.fill
                ]

            else
                [ Element.height <| Element.px theme.height ]

        paddingAttrs =
            let
                hasTrailingIcon =
                    p.trailingIcon /= Nothing

                hasClickableTrailingIcon =
                    p.trailingIcon /= Nothing && p.onTrailingIconClick /= Nothing

                trailingIconOffset =
                    if hasClickableTrailingIcon then
                        (buttonTheme.icon.containerSize - buttonTheme.icon.iconSize) // 2

                    else
                        0
            in
            case p.type_ of
                OUI.TextField.Filled ->
                    let
                        baseverticalPadding =
                            if p.isMultiline then
                                0

                            else
                                0
                    in
                    [ Element.paddingEach
                        { top =
                            baseverticalPadding
                                + ifThenElse labelHoldPlace
                                    bottomBorderWidth
                                    theme.filled.topBottomPadding
                        , bottom =
                            baseverticalPadding
                                + ifThenElse labelHoldPlace
                                    0
                                    (theme.filled.topBottomPadding - bottomBorderWidth)
                        , left =
                            ifThenElse hasLeadingIcon
                                theme.leftRightPaddingWithIcon
                                theme.leftRightPaddingWithoutIcon
                        , right =
                            ifThenElse hasTrailingIcon
                                (theme.leftRightPaddingWithIcon - trailingIconOffset)
                                theme.leftRightPaddingWithoutIcon
                        }
                    , Element.spacing theme.paddingBetweenIconAndText
                    ]

                OUI.TextField.Outlined ->
                    let
                        basePadding =
                            ((theme.height // 2 - typescale.body.large.lineHeight // 2)
                                - 4
                            )
                                // 2
                    in
                    [ Element.paddingEach
                        { top =
                            basePadding
                                + ifThenElse p.hasFocus 0 1
                        , bottom =
                            basePadding
                                + ifThenElse p.hasFocus 0 1
                        , left =
                            ifThenElse hasLeadingIcon
                                (theme.leftRightPaddingWithIcon - leftBorderWidth)
                                (theme.leftRightPaddingWithoutIcon - leftBorderWidth)
                        , right =
                            ifThenElse hasTrailingIcon
                                (theme.leftRightPaddingWithIcon - rightBorderWidth - trailingIconOffset)
                                (theme.leftRightPaddingWithoutIcon - rightBorderWidth)
                        }
                    , Element.spacing theme.paddingBetweenIconAndText
                    ]

        labelElement =
            let
                inputLeftOffset =
                    if hasLeadingIcon then
                        theme.leftRightPaddingWithIcon + theme.iconSize + theme.paddingBetweenIconAndText

                    else
                        theme.leftRightPaddingWithoutIcon

                label =
                    p.label

                labelColor =
                    if hasError || p.hasFocus then
                        OUI.Material.Color.getElementColor p.color colorscheme

                    else
                        OUI.Material.Color.toElementColor colorscheme.onSurface

                staticAttrs =
                    [ transition "all 0.15s"
                    , Font.color labelColor
                    , Element.htmlAttribute <| Html.Attributes.style "pointer-events" "none"
                    ]
            in
            if labelHoldPlace then
                OUI.Text.bodyLarge label
                    |> OUI.Material.Typography.renderWithAttrs typescale [ transition "font-size 0.15s" ]
                    |> Element.el
                        (staticAttrs
                            ++ [ Element.moveDown <|
                                    toFloat <|
                                        (theme.height // 2 - typescale.body.large.size // 2)
                                            - topBorderWidth
                               , Element.moveRight <|
                                    toFloat <|
                                        inputLeftOffset
                                            - leftBorderWidth
                               ]
                        )

            else if isOutlined then
                let
                    topOffset =
                        typescale.body.small.size // 2
                in
                OUI.Text.bodySmall label
                    |> OUI.Material.Typography.renderWithAttrs typescale [ transition "font-size 0.15s" ]
                    |> Element.el
                        (staticAttrs
                            ++ [ Element.moveUp <| toFloat <| topOffset
                               , Element.moveRight <|
                                    toFloat <|
                                        (theme.leftRightPaddingWithoutIcon - theme.outlined.labelLeftRightPadding)
                               , Element.paddingXY theme.outlined.labelLeftRightPadding 0
                               , Element.htmlAttribute
                                    (Html.Attributes.style "background"
                                        ("linear-gradient(to bottom, transparent 0 "
                                            ++ String.fromInt topOffset
                                            ++ "px, "
                                            ++ Color.toCssString colorscheme.surface
                                            ++ " "
                                            ++ String.fromInt topOffset
                                            ++ "px)"
                                        )
                                    )
                               ]
                        )

            else
                OUI.Text.bodySmall label
                    |> OUI.Material.Typography.renderWithAttrs typescale [ transition "font-size 0.15s" ]
                    |> Element.el
                        (staticAttrs
                            ++ [ Element.moveDown <|
                                    toFloat <|
                                        theme.filled.topBottomPadding
                                            + (typescale.body.large.lineHeight - typescale.body.large.size)
                                            // 2
                               , Element.moveRight <|
                                    toFloat <|
                                        inputLeftOffset
                                            - leftBorderWidth
                               ]
                        )

        fontColorAttr =
            colorscheme.onSurface
                |> OUI.Material.Color.toElementColor
                |> Font.color

        trailingIcon =
            case ( hasError, p.errorIcon ) of
                ( True, Just icon ) ->
                    Just
                        (OUI.Material.Icon.renderWithSizeColor 24 colorscheme.error [] icon)

                _ ->
                    p.trailingIcon
                        |> Maybe.map
                            (\icon ->
                                case p.onTrailingIconClick of
                                    Nothing ->
                                        OUI.Material.Icon.renderWithSizeColor 24 colorscheme.onSurfaceVariant [] icon

                                    Just onClick ->
                                        Button.new p.label
                                            |> Button.withIcon icon
                                            |> Button.onClick onClick
                                            |> Button.color (ifThenElse p.hasFocus p.color OUI.Neutral)
                                            |> Button.iconButton
                                            |> Button.render typescale colorscheme buttonTheme [ Element.centerX, Element.centerY ]
                            )

        input_attrs =
            bgColorAttr
                :: Border.width 0
                -- 12 is the default vertical padding of Input.text
                -- and is needed to have enough height for the text
                :: Element.paddingXY 0 12
                :: (Element.moveDown <| toFloat inputMoveDownBy)
                :: Element.width Element.fill
                :: focusEvents
                ++ OUI.Material.Typography.attrs OUI.Text.Body OUI.Text.Large typescale
                ++ (if p.isMultiline then
                        [ Element.height Element.fill ]

                    else
                        []
                   )
    in
    Element.column
        (Element.spacing theme.supportingTextTopPadding
            :: Element.inFront labelElement
            :: (if p.isMultiline then
                    [ Element.height <| Element.px <| theme.height * 3 ]

                else
                    []
               )
            ++ attrs
        )
    <|
        Element.row
            (bgColorAttr
                :: fontColorAttr
                :: Element.width Element.fill
                :: borderAttrs
                ++ heightAttr
                ++ paddingAttrs
            )
            (filterMaybe
                [ p.leadingIcon
                    |> Maybe.map
                        (OUI.Material.Icon.renderWithSizeColor 24 colorscheme.onSurfaceVariant [])
                , Just <|
                    if p.isMultiline then
                        Input.multiline input_attrs
                            { onChange = p.onChange
                            , text = p.value
                            , label = Input.labelHidden p.label
                            , placeholder = Nothing
                            , spellcheck = p.spellcheck
                            }

                    else
                        Input.text input_attrs
                            { onChange = p.onChange
                            , text = p.value
                            , label = Input.labelHidden p.label
                            , placeholder = Nothing
                            }
                , trailingIcon
                ]
            )
            :: (case p.supportingText of
                    Just text ->
                        [ Element.el
                            [ colorscheme.onSurfaceVariant
                                |> OUI.Material.Color.toElementColor
                                |> Font.color
                            , Element.paddingXY theme.leftRightPaddingWithoutIcon 0
                            ]
                            (OUI.Text.bodySmall text
                                |> OUI.Material.Typography.render typescale
                            )
                        ]

                    Nothing ->
                        []
               )
