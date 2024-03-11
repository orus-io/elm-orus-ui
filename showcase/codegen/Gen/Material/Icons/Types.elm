module Gen.Material.Icons.Types exposing (annotation_, caseOf_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Material", "Icons", "Types" ]


annotation_ :
    { coloring : Type.Annotation, icon : Type.Annotation -> Type.Annotation }
annotation_ =
    { coloring = Type.namedWith [ "Material", "Icons", "Types" ] "Coloring" []
    , icon =
        \iconArg0 ->
            Type.alias
                moduleName_
                "Icon"
                [ iconArg0 ]
                (Type.function
                    [ Type.int
                    , Type.namedWith
                        [ "Material", "Icons", "Types" ]
                        "Coloring"
                        []
                    ]
                    (Type.namedWith [ "Svg" ] "Svg" [ Type.var "msg" ])
                )
    }


make_ : { color : Elm.Expression -> Elm.Expression, inherit : Elm.Expression }
make_ =
    { color =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Material", "Icons", "Types" ]
                    , name = "Color"
                    , annotation = Just (Type.namedWith [] "Coloring" [])
                    }
                )
                [ ar0 ]
    , inherit =
        Elm.value
            { importFrom = [ "Material", "Icons", "Types" ]
            , name = "Inherit"
            , annotation = Just (Type.namedWith [] "Coloring" [])
            }
    }


caseOf_ :
    { coloring :
        Elm.Expression
        -> { coloringTags_0_0
            | color : Elm.Expression -> Elm.Expression
            , inherit : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { coloring =
        \coloringExpression coloringTags ->
            Elm.Case.custom
                coloringExpression
                (Type.namedWith [ "Material", "Icons", "Types" ] "Coloring" [])
                [ Elm.Case.branch1
                    "Color"
                    ( "colorColor", Type.namedWith [ "Color" ] "Color" [] )
                    coloringTags.color
                , Elm.Case.branch0 "Inherit" coloringTags.inherit
                ]
    }