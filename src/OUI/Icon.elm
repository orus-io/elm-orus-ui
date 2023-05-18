module OUI.Icon exposing
    ( Icon, withSize, withColor
    , elmMaterialIcons, materialIcons
    , Renderer(..), properties
    )

{-|


# Constructor

@docs Icon, withSize, withColor


# Adapters

@docs elmMaterialIcons, materialIcons


# Internals

@docs Renderer, properties

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


{-| -}
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


{-| returns the properties of an icon
-}
properties :
    Icon
    ->
        { size : Maybe Int
        , color : Maybe OUI.Color
        , renderer : Renderer
        }
properties (Icon props) =
    props
