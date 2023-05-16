module OUI.Material exposing (..)

import Color
import Element


toElementColor : Color.Color -> Element.Color
toElementColor =
    Color.toRgba
        >> Element.fromRgb
