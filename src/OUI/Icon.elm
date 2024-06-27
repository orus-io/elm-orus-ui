module OUI.Icon exposing
    ( Icon, withSize, withColor
    , blank, check, clear, light_mode, dark_mode, arrow_drop_down, arrow_drop_up
    , elmMaterialIcons, materialIcons
    , Renderer(..), getSize, getColor, getRenderer
    )

{-|


# Constructor

@docs Icon, withSize, withColor


# Stock icons

@docs blank, check, clear, light_mode, dark_mode, arrow_drop_down, arrow_drop_up


# Adapters

@docs elmMaterialIcons, materialIcons


# Internals

@docs Renderer, getSize, getColor, getRenderer

-}

import Color exposing (Color)
import Html exposing (Html)
import OUI
import Svg exposing (Svg)
import Svg.Attributes


{-| An Icon

The default size / color is decided by the final rendering (with
OUI.Material.renderIcon for instance).

When used inside other components, like buttons, the color & size will most
probably be ignored.

A future version may separated icons with size/color from raw icons

-}
type Icon
    = Icon
        { size : Maybe Int
        , color : Maybe OUI.Color
        , renderer : Renderer
        }


{-| renderer type of the Icon. Html or Svg
-}
type Renderer
    = Svg (Int -> Color -> Svg Never)
    | Html (Int -> Color -> Html Never)


{-| set the icon size
-}
withSize : Int -> Icon -> Icon
withSize value (Icon icon) =
    Icon { icon | size = Just value }


{-| set the icon color
-}
withColor : OUI.Color -> Icon -> Icon
withColor value (Icon icon) =
    Icon { icon | color = Just value }


fromRenderer : Renderer -> Icon
fromRenderer renderer =
    Icon
        { size = Nothing
        , color = Nothing
        , renderer = renderer
        }


{-| A blank icon, used as a placeholder
-}
blank : Icon
blank =
    fromRenderer <|
        Svg
            (\size _ ->
                let
                    sizeAsString : String
                    sizeAsString =
                        String.fromInt size
                in
                Svg.svg
                    [ Svg.Attributes.viewBox "0 0 24 24"
                    , Svg.Attributes.height sizeAsString
                    , Svg.Attributes.width sizeAsString
                    ]
                    []
            )


{-| The 'check' icon, taken from icidasset/elm-material-icons
-}
check : Icon
check =
    fromRenderer <|
        Svg
            (\size color ->
                let
                    sizeAsString : String
                    sizeAsString =
                        String.fromInt size
                in
                Svg.svg
                    [ Svg.Attributes.viewBox "0 0 24 24"
                    , Svg.Attributes.height sizeAsString
                    , Svg.Attributes.width sizeAsString
                    ]
                    [ Svg.g
                        [ Svg.Attributes.fill (Color.toCssString color) ]
                        [ Svg.path
                            [ Svg.Attributes.d "M0 0h24v24H0V0z", Svg.Attributes.fill "none" ]
                            []
                        , Svg.path
                            [ Svg.Attributes.d "M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z" ]
                            []
                        ]
                    ]
            )


{-| A simple 'clear' icon, taken from icidasset/elm-material-icons
-}
clear : Icon
clear =
    fromRenderer <|
        Svg
            (\size color ->
                let
                    sizeAsString : String
                    sizeAsString =
                        String.fromInt size
                in
                Svg.svg
                    [ Svg.Attributes.viewBox "0 0 24 24"
                    , Svg.Attributes.height sizeAsString
                    , Svg.Attributes.width sizeAsString
                    ]
                    [ Svg.g
                        [ Svg.Attributes.fill (Color.toCssString color) ]
                        [ Svg.path
                            [ Svg.Attributes.d "M0 0h24v24H0V0z", Svg.Attributes.fill "none" ]
                            []
                        , Svg.path
                            [ Svg.Attributes.d "M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z" ]
                            []
                        ]
                    ]
            )


{-| 'Dark Mode' icon, taken from icidasset/elm-material-icons
-}
dark_mode : Icon
dark_mode =
    fromRenderer <|
        Svg
            (\size color ->
                let
                    sizeAsString : String
                    sizeAsString =
                        String.fromInt size
                in
                Svg.svg
                    [ Svg.Attributes.viewBox "0 0 24 24"
                    , Svg.Attributes.enableBackground "new 0 0 24 24"
                    , Svg.Attributes.height sizeAsString
                    , Svg.Attributes.width sizeAsString
                    ]
                    [ Svg.rect
                        [ Svg.Attributes.fill "none"
                        ]
                        []
                    , Svg.g
                        [ Svg.Attributes.fill (Color.toCssString color) ]
                        [ Svg.path
                            [ Svg.Attributes.d "M9.37,5.51C9.19,6.15,9.1,6.82,9.1,7.5c0,4.08,3.32,7.4,7.4,7.4c0.68,0,1.35-0.09,1.99-0.27C17.45,17.19,14.93,19,12,19 c-3.86,0-7-3.14-7-7C5,9.07,6.81,6.55,9.37,5.51z M12,3c-4.97,0-9,4.03-9,9s4.03,9,9,9s9-4.03,9-9c0-0.46-0.04-0.92-0.1-1.36 c-0.98,1.37-2.58,2.26-4.4,2.26c-2.98,0-5.4-2.42-5.4-5.4c0-1.81,0.89-3.42,2.26-4.4C12.92,3.04,12.46,3,12,3L12,3z" ]
                            []
                        ]
                    ]
            )


{-| 'Light Mode' icon, taken from icidasset/elm-material-icons
-}
light_mode : Icon
light_mode =
    fromRenderer <|
        Svg
            (\size color ->
                let
                    sizeAsString : String
                    sizeAsString =
                        String.fromInt size
                in
                Svg.svg
                    [ Svg.Attributes.viewBox "0 0 24 24"
                    , Svg.Attributes.enableBackground "new 0 0 24 24"
                    , Svg.Attributes.height sizeAsString
                    , Svg.Attributes.width sizeAsString
                    ]
                    [ Svg.rect
                        [ Svg.Attributes.fill "none"
                        ]
                        []
                    , Svg.g
                        [ Svg.Attributes.fill (Color.toCssString color) ]
                        [ Svg.path
                            [ Svg.Attributes.d "M12,9c1.65,0,3,1.35,3,3s-1.35,3-3,3s-3-1.35-3-3S10.35,9,12,9 M12,7c-2.76,0-5,2.24-5,5s2.24,5,5,5s5-2.24,5-5 S14.76,7,12,7L12,7z M2,13l2,0c0.55,0,1-0.45,1-1s-0.45-1-1-1l-2,0c-0.55,0-1,0.45-1,1S1.45,13,2,13z M20,13l2,0c0.55,0,1-0.45,1-1 s-0.45-1-1-1l-2,0c-0.55,0-1,0.45-1,1S19.45,13,20,13z M11,2v2c0,0.55,0.45,1,1,1s1-0.45,1-1V2c0-0.55-0.45-1-1-1S11,1.45,11,2z M11,20v2c0,0.55,0.45,1,1,1s1-0.45,1-1v-2c0-0.55-0.45-1-1-1C11.45,19,11,19.45,11,20z M5.99,4.58c-0.39-0.39-1.03-0.39-1.41,0 c-0.39,0.39-0.39,1.03,0,1.41l1.06,1.06c0.39,0.39,1.03,0.39,1.41,0s0.39-1.03,0-1.41L5.99,4.58z M18.36,16.95 c-0.39-0.39-1.03-0.39-1.41,0c-0.39,0.39-0.39,1.03,0,1.41l1.06,1.06c0.39,0.39,1.03,0.39,1.41,0c0.39-0.39,0.39-1.03,0-1.41 L18.36,16.95z M19.42,5.99c0.39-0.39,0.39-1.03,0-1.41c-0.39-0.39-1.03-0.39-1.41,0l-1.06,1.06c-0.39,0.39-0.39,1.03,0,1.41 s1.03,0.39,1.41,0L19.42,5.99z M7.05,18.36c0.39-0.39,0.39-1.03,0-1.41c-0.39-0.39-1.03-0.39-1.41,0l-1.06,1.06 c-0.39,0.39-0.39,1.03,0,1.41s1.03,0.39,1.41,0L7.05,18.36z" ]
                            []
                        ]
                    ]
            )


{-| 'arrow drop down' icon, taken from icidasset/elm-material-icons
-}
arrow_drop_down : Icon
arrow_drop_down =
    fromRenderer <|
        Svg
            (\size color ->
                let
                    sizeAsString : String
                    sizeAsString =
                        String.fromInt size
                in
                Svg.svg
                    [ Svg.Attributes.viewBox "0 0 24 24"
                    , Svg.Attributes.enableBackground "new 0 0 24 24"
                    , Svg.Attributes.height sizeAsString
                    , Svg.Attributes.width sizeAsString
                    ]
                    [ Svg.path
                        [ Svg.Attributes.d "M0 0h24v24H0V0z", Svg.Attributes.fill "none" ]
                        []
                    , Svg.path
                        [ Svg.Attributes.d "M7 10l5 5 5-5H7z", Svg.Attributes.fill (Color.toCssString color) ]
                        []
                    ]
            )


{-| 'arrow drop up' icon, taken from icidasset/elm-material-icons
-}
arrow_drop_up : Icon
arrow_drop_up =
    fromRenderer <|
        Svg
            (\size color ->
                let
                    sizeAsString : String
                    sizeAsString =
                        String.fromInt size
                in
                Svg.svg
                    [ Svg.Attributes.viewBox "0 0 24 24"
                    , Svg.Attributes.enableBackground "new 0 0 24 24"
                    , Svg.Attributes.height sizeAsString
                    , Svg.Attributes.width sizeAsString
                    ]
                    [ Svg.path
                        [ Svg.Attributes.d "M0 0h24v24H0V0z", Svg.Attributes.fill "none" ]
                        []
                    , Svg.path
                        [ Svg.Attributes.d "M7 14l5-5 5 5H7z", Svg.Attributes.fill (Color.toCssString color) ]
                        []
                    ]
            )


{-| For using [icidasset/elm-material-icons](https://dark.elm.dmy.fr/packages/icidasset/elm-material-icons/latest/)

    import Material.Icons exposing (offline_bolt)
    import Material.Icons.Types exposing (Coloring(..))
    import OUI.Icon exposing (Icon)

    check : Icon
    check =
        Material.Icons.done
            |> OUI.Icon.elmMaterialIcons Color

-}
elmMaterialIcons : (Color -> coloring) -> (Int -> coloring -> Html Never) -> Icon
elmMaterialIcons wrapper fun =
    fromRenderer <|
        Html
            (\size color ->
                fun size (wrapper color)
            )


{-| For using [danmarcab/material-icons](https://dark.elm.dmy.fr/packages/danmarcab/material-icons/latest/)

    import Material.Icons.Action
    import OUI.Icon exposing (Icon)

    check : Icon
    check =
        Material.Icons.Action.done
            |> OUI.Icon.materialIcons

-}
materialIcons : (Color -> Int -> Svg Never) -> Icon
materialIcons fun =
    fromRenderer <|
        Svg
            (\size color ->
                fun color size
                    |> List.singleton
                    |> Svg.svg
                        [ Svg.Attributes.width <| String.fromInt size
                        , Svg.Attributes.height <| String.fromInt size
                        ]
            )


{-| get the size
-}
getSize : Icon -> Maybe Int
getSize (Icon props) =
    props.size


{-| get the color
-}
getColor : Icon -> Maybe OUI.Color
getColor (Icon props) =
    props.color


{-| get the renderer
-}
getRenderer : Icon -> Renderer
getRenderer (Icon props) =
    props.renderer
