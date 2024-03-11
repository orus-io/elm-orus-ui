module Gen.OUI.Showcase.Icons exposing (annotation_, book, call_, make_, moduleName_, values_, withChapter)

{-| 
@docs moduleName_, book, withChapter, annotation_, make_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "OUI", "Showcase", "Icons" ]


{-| book: 
    String
    -> OUI.Explorer.Book themeExt OUI.Showcase.Icons.Model OUI.Showcase.Icons.Msg
-}
book : String -> Elm.Expression
book bookArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "OUI", "Showcase", "Icons" ]
            , name = "book"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "OUI", "Explorer" ]
                            "Book"
                            [ Type.var "themeExt"
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Model"
                                []
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Msg"
                                []
                            ]
                        )
                    )
            }
        )
        [ Elm.string bookArg ]


{-| withChapter: 
    String
    -> List ( String, OUI.Icon.Icon )
    -> OUI.Explorer.Book themeExt OUI.Showcase.Icons.Model OUI.Showcase.Icons.Msg
    -> OUI.Explorer.Book themeExt OUI.Showcase.Icons.Model OUI.Showcase.Icons.Msg
-}
withChapter : String -> List Elm.Expression -> Elm.Expression -> Elm.Expression
withChapter withChapterArg withChapterArg0 withChapterArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "OUI", "Showcase", "Icons" ]
            , name = "withChapter"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                            )
                        , Type.namedWith
                            [ "OUI", "Explorer" ]
                            "Book"
                            [ Type.var "themeExt"
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Model"
                                []
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Msg"
                                []
                            ]
                        ]
                        (Type.namedWith
                            [ "OUI", "Explorer" ]
                            "Book"
                            [ Type.var "themeExt"
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Model"
                                []
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Msg"
                                []
                            ]
                        )
                    )
            }
        )
        [ Elm.string withChapterArg, Elm.list withChapterArg0, withChapterArg1 ]


annotation_ : { model : Type.Annotation, msg : Type.Annotation }
annotation_ =
    { model =
        Type.alias
            moduleName_
            "Model"
            []
            (Type.record
                [ ( "filter", Type.string ), ( "filterFocused", Type.bool ) ]
            )
    , msg = Type.namedWith [ "OUI", "Showcase", "Icons" ] "Msg" []
    }


make_ :
    { model :
        { filter : Elm.Expression, filterFocused : Elm.Expression }
        -> Elm.Expression
    }
make_ =
    { model =
        \model_args ->
            Elm.withType
                (Type.alias
                    [ "OUI", "Showcase", "Icons" ]
                    "Model"
                    []
                    (Type.record
                        [ ( "filter", Type.string )
                        , ( "filterFocused", Type.bool )
                        ]
                    )
                )
                (Elm.record
                    [ Tuple.pair "filter" model_args.filter
                    , Tuple.pair "filterFocused" model_args.filterFocused
                    ]
                )
    }


call_ :
    { book : Elm.Expression -> Elm.Expression
    , withChapter :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { book =
        \bookArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Showcase", "Icons" ]
                    , name = "book"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "OUI", "Explorer" ]
                                    "Book"
                                    [ Type.var "themeExt"
                                    , Type.namedWith
                                        [ "OUI", "Showcase", "Icons" ]
                                        "Model"
                                        []
                                    , Type.namedWith
                                        [ "OUI", "Showcase", "Icons" ]
                                        "Msg"
                                        []
                                    ]
                                )
                            )
                    }
                )
                [ bookArg ]
    , withChapter =
        \withChapterArg withChapterArg0 withChapterArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "OUI", "Showcase", "Icons" ]
                    , name = "withChapter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.list
                                    (Type.tuple
                                        Type.string
                                        (Type.namedWith
                                            [ "OUI", "Icon" ]
                                            "Icon"
                                            []
                                        )
                                    )
                                , Type.namedWith
                                    [ "OUI", "Explorer" ]
                                    "Book"
                                    [ Type.var "themeExt"
                                    , Type.namedWith
                                        [ "OUI", "Showcase", "Icons" ]
                                        "Model"
                                        []
                                    , Type.namedWith
                                        [ "OUI", "Showcase", "Icons" ]
                                        "Msg"
                                        []
                                    ]
                                ]
                                (Type.namedWith
                                    [ "OUI", "Explorer" ]
                                    "Book"
                                    [ Type.var "themeExt"
                                    , Type.namedWith
                                        [ "OUI", "Showcase", "Icons" ]
                                        "Model"
                                        []
                                    , Type.namedWith
                                        [ "OUI", "Showcase", "Icons" ]
                                        "Msg"
                                        []
                                    ]
                                )
                            )
                    }
                )
                [ withChapterArg, withChapterArg0, withChapterArg1 ]
    }


values_ : { book : Elm.Expression, withChapter : Elm.Expression }
values_ =
    { book =
        Elm.value
            { importFrom = [ "OUI", "Showcase", "Icons" ]
            , name = "book"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "OUI", "Explorer" ]
                            "Book"
                            [ Type.var "themeExt"
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Model"
                                []
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Msg"
                                []
                            ]
                        )
                    )
            }
    , withChapter =
        Elm.value
            { importFrom = [ "OUI", "Showcase", "Icons" ]
            , name = "withChapter"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "OUI", "Icon" ] "Icon" [])
                            )
                        , Type.namedWith
                            [ "OUI", "Explorer" ]
                            "Book"
                            [ Type.var "themeExt"
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Model"
                                []
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Msg"
                                []
                            ]
                        ]
                        (Type.namedWith
                            [ "OUI", "Explorer" ]
                            "Book"
                            [ Type.var "themeExt"
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Model"
                                []
                            , Type.namedWith
                                [ "OUI", "Showcase", "Icons" ]
                                "Msg"
                                []
                            ]
                        )
                    )
            }
    }