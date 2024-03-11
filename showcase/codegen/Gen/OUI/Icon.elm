module Gen.OUI.Icon exposing (annotation_, arrow_drop_down, arrow_drop_up, blank, call_, caseOf_, check, clear, dark_mode, elmMaterialIcons, light_mode, make_, materialIcons, moduleName_, properties, values_, withColor, withSize)

{-| 
@docs moduleName_, properties, materialIcons, elmMaterialIcons, arrow_drop_up, arrow_drop_down, light_mode, dark_mode, clear, check, blank, withColor, withSize, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "OUI", "Icon" ]


{-| {-| returns the properties of an icon
-}

properties: OUI.Icon.Icon -> OUI.Icon.Properties
-}
properties : Elm.Expression -> Elm.Expression
properties propertiesArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "properties"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "OUI", "Icon" ] "Icon" [] ]
                        (Type.namedWith [ "OUI", "Icon" ] "Properties" [])
                    )
            }
        )
        [ propertiesArg ]


{-| {-| For using [danmarcab/material-icons](https://dark.elm.dmy.fr/packages/danmarcab/material-icons/latest/)

    import Material.Icons.Action
    import OUI.Icon exposing (Icon)

    check : Icon
    check =
        Material.Icons.Action.done
            |> OUI.Icon.materialIcons

-}

materialIcons: (Color.Color -> Int -> Svg.Svg Basics.Never) -> OUI.Icon.Icon
-}
materialIcons :
    (Elm.Expression -> Elm.Expression -> Elm.Expression) -> Elm.Expression
materialIcons materialIconsArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "materialIcons"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Color" ] "Color" [], Type.int ]
                            (Type.namedWith
                                [ "Svg" ]
                                "Svg"
                                [ Type.namedWith [ "Basics" ] "Never" [] ]
                            )
                        ]
                        (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                    )
            }
        )
        [ Elm.functionReduced
            "materialIconsUnpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (materialIconsArg functionReducedUnpack)
            )
        ]


{-| {-| For using [icidasset/elm-material-icons](https://dark.elm.dmy.fr/packages/icidasset/elm-material-icons/latest/)

    import Material.Icons exposing (offline_bolt)
    import Material.Icons.Types exposing (Coloring(..))
    import OUI.Icon exposing (Icon)

    check : Icon
    check =
        Material.Icons.done
            |> OUI.Icon.elmMaterialIcons Color

-}

elmMaterialIcons: 
    (Color.Color -> coloring)
    -> (Int -> coloring -> Html.Html Basics.Never)
    -> OUI.Icon.Icon
-}
elmMaterialIcons :
    (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
elmMaterialIcons elmMaterialIconsArg elmMaterialIconsArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "elmMaterialIcons"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Color" ] "Color" [] ]
                            (Type.var "coloring")
                        , Type.function
                            [ Type.int, Type.var "coloring" ]
                            (Type.namedWith
                                [ "Html" ]
                                "Html"
                                [ Type.namedWith [ "Basics" ] "Never" [] ]
                            )
                        ]
                        (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                    )
            }
        )
        [ Elm.functionReduced "elmMaterialIconsUnpack" elmMaterialIconsArg
        , Elm.functionReduced
            "elmMaterialIconsUnpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (elmMaterialIconsArg0 functionReducedUnpack)
            )
        ]


{-| {-| 'arrow drop up' icon, taken from icidasset/elm-material-icons
-}

arrow_drop_up: OUI.Icon.Icon
-}
arrow_drop_up : Elm.Expression
arrow_drop_up =
    Elm.value
        { importFrom = [ "OUI", "Icon" ]
        , name = "arrow_drop_up"
        , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
        }


{-| {-| 'arrow drop down' icon, taken from icidasset/elm-material-icons
-}

arrow_drop_down: OUI.Icon.Icon
-}
arrow_drop_down : Elm.Expression
arrow_drop_down =
    Elm.value
        { importFrom = [ "OUI", "Icon" ]
        , name = "arrow_drop_down"
        , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
        }


{-| {-| 'Light Mode' icon, taken from icidasset/elm-material-icons
-}

light_mode: OUI.Icon.Icon
-}
light_mode : Elm.Expression
light_mode =
    Elm.value
        { importFrom = [ "OUI", "Icon" ]
        , name = "light_mode"
        , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
        }


{-| {-| 'Dark Mode' icon, taken from icidasset/elm-material-icons
-}

dark_mode: OUI.Icon.Icon
-}
dark_mode : Elm.Expression
dark_mode =
    Elm.value
        { importFrom = [ "OUI", "Icon" ]
        , name = "dark_mode"
        , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
        }


{-| {-| A simple 'clear' icon, taken from icidasset/elm-material-icons
-}

clear: OUI.Icon.Icon
-}
clear : Elm.Expression
clear =
    Elm.value
        { importFrom = [ "OUI", "Icon" ]
        , name = "clear"
        , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
        }


{-| {-| The 'check' icon, taken from icidasset/elm-material-icons
-}

check: OUI.Icon.Icon
-}
check : Elm.Expression
check =
    Elm.value
        { importFrom = [ "OUI", "Icon" ]
        , name = "check"
        , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
        }


{-| {-| A blank icon, used as a placeholder
-}

blank: OUI.Icon.Icon
-}
blank : Elm.Expression
blank =
    Elm.value
        { importFrom = [ "OUI", "Icon" ]
        , name = "blank"
        , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
        }


{-| {-| set the icon color
-}

withColor: OUI.Color -> OUI.Icon.Icon -> OUI.Icon.Icon
-}
withColor : Elm.Expression -> Elm.Expression -> Elm.Expression
withColor withColorArg withColorArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "withColor"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "OUI" ] "Color" []
                        , Type.namedWith [ "OUI", "Icon" ] "Icon" []
                        ]
                        (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                    )
            }
        )
        [ withColorArg, withColorArg0 ]


{-| {-| set the icon size
-}

withSize: Int -> OUI.Icon.Icon -> OUI.Icon.Icon
-}
withSize : Int -> Elm.Expression -> Elm.Expression
withSize withSizeArg withSizeArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "withSize"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.namedWith [ "OUI", "Icon" ] "Icon" [] ]
                        (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                    )
            }
        )
        [ Elm.int withSizeArg, withSizeArg0 ]


annotation_ :
    { properties : Type.Annotation
    , renderer : Type.Annotation
    , icon : Type.Annotation
    }
annotation_ =
    { properties =
        Type.alias
            moduleName_
            "Properties"
            []
            (Type.record
                [ ( "size", Type.maybe Type.int )
                , ( "color", Type.maybe (Type.namedWith [ "OUI" ] "Color" []) )
                , ( "renderer", Type.namedWith [ "OUI", "Icon" ] "Renderer" [] )
                ]
            )
    , renderer = Type.namedWith [ "OUI", "Icon" ] "Renderer" []
    , icon = Type.namedWith [ "OUI", "Icon" ] "Icon" []
    }


make_ :
    { properties :
        { size : Elm.Expression
        , color : Elm.Expression
        , renderer : Elm.Expression
        }
        -> Elm.Expression
    , svg : Elm.Expression -> Elm.Expression
    , html : Elm.Expression -> Elm.Expression
    }
make_ =
    { properties =
        \properties_args ->
            Elm.withType
                (Type.alias
                    [ "OUI", "Icon" ]
                    "Properties"
                    []
                    (Type.record
                        [ ( "size", Type.maybe Type.int )
                        , ( "color"
                          , Type.maybe (Type.namedWith [ "OUI" ] "Color" [])
                          )
                        , ( "renderer"
                          , Type.namedWith [ "OUI", "Icon" ] "Renderer" []
                          )
                        ]
                    )
                )
                (Elm.record
                    [ Tuple.pair "size" properties_args.size
                    , Tuple.pair "color" properties_args.color
                    , Tuple.pair "renderer" properties_args.renderer
                    ]
                )
    , svg =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Icon" ]
                    , name = "Svg"
                    , annotation = Just (Type.namedWith [] "Renderer" [])
                    }
                )
                [ ar0 ]
    , html =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Icon" ]
                    , name = "Html"
                    , annotation = Just (Type.namedWith [] "Renderer" [])
                    }
                )
                [ ar0 ]
    }


caseOf_ :
    { renderer :
        Elm.Expression
        -> { rendererTags_0_0
            | svg : Elm.Expression -> Elm.Expression
            , html : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { renderer =
        \rendererExpression rendererTags ->
            Elm.Case.custom
                rendererExpression
                (Type.namedWith [ "OUI", "Icon" ] "Renderer" [])
                [ Elm.Case.branch1
                    "Svg"
                    ( "one"
                    , Type.function
                        [ Type.int, Type.namedWith [ "Color" ] "Color" [] ]
                        (Type.namedWith
                            [ "Svg" ]
                            "Svg"
                            [ Type.namedWith [ "Basics" ] "Never" [] ]
                        )
                    )
                    rendererTags.svg
                , Elm.Case.branch1
                    "Html"
                    ( "one"
                    , Type.function
                        [ Type.int, Type.namedWith [ "Color" ] "Color" [] ]
                        (Type.namedWith
                            [ "Html" ]
                            "Html"
                            [ Type.namedWith [ "Basics" ] "Never" [] ]
                        )
                    )
                    rendererTags.html
                ]
    }


call_ :
    { properties : Elm.Expression -> Elm.Expression
    , materialIcons : Elm.Expression -> Elm.Expression
    , elmMaterialIcons : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withColor : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withSize : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { properties =
        \propertiesArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Icon" ]
                    , name = "properties"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "OUI", "Icon" ] "Icon" [] ]
                                (Type.namedWith
                                    [ "OUI", "Icon" ]
                                    "Properties"
                                    []
                                )
                            )
                    }
                )
                [ propertiesArg ]
    , materialIcons =
        \materialIconsArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Icon" ]
                    , name = "materialIcons"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Color" ] "Color" []
                                    , Type.int
                                    ]
                                    (Type.namedWith
                                        [ "Svg" ]
                                        "Svg"
                                        [ Type.namedWith [ "Basics" ] "Never" []
                                        ]
                                    )
                                ]
                                (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                            )
                    }
                )
                [ materialIconsArg ]
    , elmMaterialIcons =
        \elmMaterialIconsArg elmMaterialIconsArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Icon" ]
                    , name = "elmMaterialIcons"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Color" ] "Color" [] ]
                                    (Type.var "coloring")
                                , Type.function
                                    [ Type.int, Type.var "coloring" ]
                                    (Type.namedWith
                                        [ "Html" ]
                                        "Html"
                                        [ Type.namedWith [ "Basics" ] "Never" []
                                        ]
                                    )
                                ]
                                (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                            )
                    }
                )
                [ elmMaterialIconsArg, elmMaterialIconsArg0 ]
    , withColor =
        \withColorArg withColorArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Icon" ]
                    , name = "withColor"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "OUI" ] "Color" []
                                , Type.namedWith [ "OUI", "Icon" ] "Icon" []
                                ]
                                (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                            )
                    }
                )
                [ withColorArg, withColorArg0 ]
    , withSize =
        \withSizeArg withSizeArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Icon" ]
                    , name = "withSize"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.namedWith [ "OUI", "Icon" ] "Icon" []
                                ]
                                (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                            )
                    }
                )
                [ withSizeArg, withSizeArg0 ]
    }


values_ :
    { properties : Elm.Expression
    , materialIcons : Elm.Expression
    , elmMaterialIcons : Elm.Expression
    , arrow_drop_up : Elm.Expression
    , arrow_drop_down : Elm.Expression
    , light_mode : Elm.Expression
    , dark_mode : Elm.Expression
    , clear : Elm.Expression
    , check : Elm.Expression
    , blank : Elm.Expression
    , withColor : Elm.Expression
    , withSize : Elm.Expression
    }
values_ =
    { properties =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "properties"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "OUI", "Icon" ] "Icon" [] ]
                        (Type.namedWith [ "OUI", "Icon" ] "Properties" [])
                    )
            }
    , materialIcons =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "materialIcons"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Color" ] "Color" [], Type.int ]
                            (Type.namedWith
                                [ "Svg" ]
                                "Svg"
                                [ Type.namedWith [ "Basics" ] "Never" [] ]
                            )
                        ]
                        (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                    )
            }
    , elmMaterialIcons =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "elmMaterialIcons"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Color" ] "Color" [] ]
                            (Type.var "coloring")
                        , Type.function
                            [ Type.int, Type.var "coloring" ]
                            (Type.namedWith
                                [ "Html" ]
                                "Html"
                                [ Type.namedWith [ "Basics" ] "Never" [] ]
                            )
                        ]
                        (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                    )
            }
    , arrow_drop_up =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "arrow_drop_up"
            , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
            }
    , arrow_drop_down =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "arrow_drop_down"
            , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
            }
    , light_mode =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "light_mode"
            , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
            }
    , dark_mode =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "dark_mode"
            , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
            }
    , clear =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "clear"
            , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
            }
    , check =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "check"
            , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
            }
    , blank =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "blank"
            , annotation = Just (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
            }
    , withColor =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "withColor"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "OUI" ] "Color" []
                        , Type.namedWith [ "OUI", "Icon" ] "Icon" []
                        ]
                        (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                    )
            }
    , withSize =
        Elm.value
            { importFrom = [ "OUI", "Icon" ]
            , name = "withSize"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.namedWith [ "OUI", "Icon" ] "Icon" [] ]
                        (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                    )
            }
    }