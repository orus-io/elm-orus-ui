module OUI.Showcase.Icons exposing (..)

import Element exposing (Element)
import OUI.Explorer as Explorer
import OUI.Icon exposing (Icon)
import OUI.Material as Material
import OUI.Material.Theme as Theme


book : String -> List ( String, Icon ) -> Explorer.Book () ()
book title iconList =
    Explorer.book title
        |> Explorer.withStaticChapter
            (\_ -> Element.text title)
        |> Explorer.withStaticChapter
            (\{ theme } ->
                iconList
                    |> List.map
                        (\( label, icon ) ->
                            Element.column [ Element.spacing 10 ]
                                [ Material.renderIcon theme [ Element.centerX ] icon
                                , Element.text label
                                ]
                        )
                    |> Element.row [ Element.spacing 20 ]
            )
