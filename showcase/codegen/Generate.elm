module Generate exposing (main)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Op
import Gen.CodeGen.Generate as Generate
import Gen.OUI.Icon
import Gen.OUI.Showcase.Icons
import MatIcons


main : Program {} () ()
main =
    Generate.run
        [ file "Regular" [ "Material", "Icons" ]
        , file "Outlined" [ "Material", "Icons", "Outlined" ]
        , file "Round" [ "Material", "Icons", "Round" ]
        ]


file : String -> List String -> Elm.File
file filename importFrom =
    Elm.file [ "IcidassetMaterialIcons", filename ]
        [ Elm.declaration "book" <|
            Elm.withType  (
                Type.namedWith [ "OUI", "Explorer" ]
                "Book"
                [Type.unit
                , Type.named ["OUI", "Showcase", "Icons"] "Model"
                , Type.named ["OUI", "Showcase", "Icons"] "Msg"]
                )
            <|
                (MatIcons.iconList
                |> List.map
                    (\( category, icons ) ->
                        icons
                            |> List.map
                                (\name ->
                                    Elm.tuple
                                        (Elm.string name)
                                        (Gen.OUI.Icon.call_.elmMaterialIcons
                                            (Elm.value
                                                { importFrom = [ "Material", "Icons", "Types" ]
                                                , name = "Color"
                                                , annotation = Just (Type.namedWith ["Material", "Icons", "Types"] "Coloring" [])
                                                }
                                            )
                                            (Elm.value
                                                { importFrom = importFrom
                                                , name = name
                                                , annotation = Just (Type.namedWith ["Material", "Icons", "Types"] "Icon" [])
                                                }
                                            )
                                        )
                                )
                            |> Elm.list
                            |> Gen.OUI.Showcase.Icons.call_.withChapter (Elm.string category)
                            |> Elm.functionReduced "book"
                    )
                |> List.foldl
                    Elm.Op.pipe
                    (Gen.OUI.Showcase.Icons.call_.book (Elm.string filename))
            )
        ]
