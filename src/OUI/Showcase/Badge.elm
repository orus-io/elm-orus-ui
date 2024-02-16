module OUI.Showcase.Badge exposing (book)

import Element exposing (Element)
import OUI.Badge
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Material
import OUI.Text


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Badge"
        |> Explorer.withStaticChapter badges


badges : Explorer.Shared themeExt -> Element msg
badges shared =
    Element.table
        [ Element.spacing 20 ]
        { data =
            [ { text = "small"
              , badge = OUI.Badge.small
              }
            , { text = "with text"
              , badge = OUI.Badge.label "new"
              }
            , { text = "with large text"
              , badge = OUI.Badge.label "Lorem Ipsus"
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
                        >> OUI.Text.bodyLarge
                        >> OUI.Material.text shared.theme
              }
            , { header = Element.none
              , width = Element.shrink
              , view =
                    \{ badge } ->
                        OUI.Icon.light_mode
                            |> OUI.Material.icon shared.theme
                                [ badge
                                    |> OUI.Material.badge shared.theme []
                                ]
                            |> Element.el []
              }
            ]
        }
