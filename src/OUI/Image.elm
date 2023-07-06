module OUI.Image exposing (Image, Src, properties, svg, url, withDescription)

import Element.Region exposing (description)
import Html exposing (Html)
import Svg exposing (Svg)


type Image
    = Image Src String


type Src
    = Url String
    | Svg (Svg Never)


url : String -> Src
url =
    Url


svg : Svg Never -> Src
svg =
    Svg


withDescription : String -> Src -> Image
withDescription description src =
    Image src description


properties : Image -> { description : String, src : Src }
properties (Image src description) =
    { description = description
    , src = src
    }
