module OUI.Progress exposing (Progress, Type(..), circular, linear, properties, withColor, withValue)

import OUI


type Type
    = Circular
    | Linear


type Progress
    = Progress
        { type_ : Type
        , color : OUI.Color
        , value : Maybe Float
        }


circular : Progress
circular =
    Progress
        { type_ = Circular
        , color = OUI.Primary
        , value = Nothing
        }


linear : Progress
linear =
    Progress
        { type_ = Linear
        , color = OUI.Primary
        , value = Nothing
        }


withColor : OUI.Color -> Progress -> Progress
withColor color (Progress progress) =
    Progress
        { progress
            | color = color
        }


withValue : Float -> Progress -> Progress
withValue value (Progress progress) =
    Progress
        { progress
            | value = Just value
        }


properties :
    Progress
    ->
        { type_ : Type
        , color : OUI.Color
        , value : Maybe Float
        }
properties (Progress progress) =
    progress
