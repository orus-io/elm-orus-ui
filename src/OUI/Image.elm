module OUI.Image exposing
    ( Image, url, svg, withDescription
    , Src, getDescription, getSrc
    )

{-| Image component

@docs Image, url, svg, withDescription


# Internals

@docs Src, getDescription, getSrc

-}

import Svg exposing (Svg)


{-| An image
-}
type Image
    = Image Src String


{-| type of an Image source. It can be u URL or a Svg Icon
-}
type Src
    = Url String
    | Svg (Svg Never)


{-| Create an image from a URL
-}
url : String -> Src
url =
    Url


{-| Create an image from SVG node
-}
svg : Svg Never -> Src
svg =
    Svg


{-| Add a description to the image
-}
withDescription : String -> Src -> Image
withDescription description src =
    Image src description


{-| get the description
-}
getDescription : Image -> String
getDescription (Image _ description) =
    description


{-| get the src
-}
getSrc : Image -> Src
getSrc (Image src _) =
    src
