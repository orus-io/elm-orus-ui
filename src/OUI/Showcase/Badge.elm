module OUI.Showcase.Badge exposing (book)

import Element exposing (Element)
import OUI.Badge
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Material as Material
import OUI.Text as Text


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Badge"
        |> Explorer.withStaticChapter badges


badges : Explorer.Shared themeExt -> Element msg
badges { theme } =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30 ]
        [ divider
        , Element.table
            [ Element.spacing 20 ]
            { data =
                [ { text = "small"
                  , badge = OUI.Badge.small
                  }
                , { text = "with text"
                  , badge = OUI.Badge.label "new"
                  }
                , { text = "with large text"
                  , badge = OUI.Badge.label "Lorem Ipsum"
                  }
                , { text = "with number"
                  , badge = OUI.Badge.number 10
                  }
                , { text = "with large number"
                  , badge = OUI.Badge.number 12348
                  }
                ]
            , columns =
                [ { header = Element.none
                  , width = Element.shrink
                  , view =
                        .text
                            >> Text.titleSmall
                            >> Material.text theme
                  }
                , { header = Element.none
                  , width = Element.shrink
                  , view =
                        \{ badge } ->
                            OUI.Icon.light_mode
                                |> Material.icon theme
                                    [ badge
                                        |> Material.badge theme []
                                    ]
                                |> Element.el []
                  }
                ]
            }
        ]
