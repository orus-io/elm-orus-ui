module OUI.Showcase.Progress exposing (book)

import Element exposing (Element)
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Material as Material
import OUI.Progress
import OUI.Text


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Progress"
        |> Explorer.withStaticChapter progressChapter


progressChapter : Explorer.Shared themeExt -> Element msg
progressChapter { theme } =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column
        [ Element.spacing 20
        , Element.width <| Element.maximum 500 <| Element.fill
        , Element.padding 30
        ]
        [ divider
        , Element.table
            [ Element.spacing 20, Element.width <| Element.maximum 500 <| Element.fill ]
            { columns =
                [ { header = Element.none
                  , width = Element.shrink
                  , view =
                        .value
                            >> Maybe.map String.fromFloat
                            >> Maybe.withDefault "undetermined"
                            >> OUI.Text.bodyLarge
                            >> Material.text theme
                            >> Element.el [ Element.centerY ]
                  }
                , { header =
                        OUI.Text.bodyLarge "circular"
                            |> Material.text theme
                            |> Element.el [ Element.centerX ]
                  , width = Element.shrink
                  , view =
                        \{ value } ->
                            OUI.Progress.circular
                                |> (case value of
                                        Just v ->
                                            OUI.Progress.withValue v

                                        Nothing ->
                                            identity
                                   )
                                |> Material.progress theme [ Element.centerX ]
                                |> Element.el [ Element.width Element.fill ]
                  }
                , { header =
                        OUI.Text.bodyLarge "linear"
                            |> Material.text theme
                            |> Element.el [ Element.moveRight 100 ]
                  , width = Element.fill
                  , view =
                        \{ value } ->
                            OUI.Progress.linear
                                |> (case value of
                                        Just v ->
                                            OUI.Progress.withValue v

                                        Nothing ->
                                            identity
                                   )
                                |> Material.progress theme
                                    [ Element.width Element.fill
                                    , Element.centerY
                                    ]
                  }
                ]
            , data =
                [ { value = Just 0
                  }
                , { value = Just 0.01
                  }
                , { value = Just 0.25
                  }
                , { value = Just 0.37
                  }
                , { value = Just 0.5
                  }
                , { value = Just 0.99
                  }
                , { value = Just 1.0
                  }
                , { value = Nothing }
                ]
            }
        ]
