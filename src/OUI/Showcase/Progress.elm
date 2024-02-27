module OUI.Showcase.Progress exposing (book)

import Element exposing (Element)
import OUI.Explorer as Explorer
import OUI.Material
import OUI.Progress
import OUI.Text


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Progress"
        |> Explorer.withStaticChapter progressChapter


progressChapter : Explorer.Shared themeExt -> Element msg
progressChapter shared =
    Element.table
        [ Element.spacing 20 ]
        { data =
            [ { text = "circular"
              , progress =
                    OUI.Progress.circular
              }
            , { text = "linear"
              , progress =
                    OUI.Progress.linear
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
            , { header =
                    OUI.Text.bodyLarge "0%"
                        |> OUI.Material.text shared.theme
                        |> Element.el [ Element.centerX ]
                        |> Element.el [ Element.width Element.fill ]
              , width = Element.fill
              , view =
                    \{ progress } ->
                        progress
                            |> OUI.Progress.withValue 0
                            |> OUI.Material.progress shared.theme [ Element.centerX ]
                            |> Element.el [ Element.width Element.fill ]
              }
            , { header =
                    OUI.Text.bodyLarge "1%"
                        |> OUI.Material.text shared.theme
                        |> Element.el [ Element.centerX ]
                        |> Element.el [ Element.width Element.fill ]
              , width = Element.fill
              , view =
                    \{ progress } ->
                        progress
                            |> OUI.Progress.withValue 0.01
                            |> OUI.Material.progress shared.theme [ Element.centerX ]
                            |> Element.el [ Element.width Element.fill ]
              }
            , { header =
                    OUI.Text.bodyLarge "25%"
                        |> OUI.Material.text shared.theme
                        |> Element.el [ Element.centerX ]
                        |> Element.el [ Element.width Element.fill ]
              , width = Element.fill
              , view =
                    \{ progress } ->
                        progress
                            |> OUI.Progress.withValue 0.25
                            |> OUI.Material.progress shared.theme [ Element.centerX ]
                            |> Element.el [ Element.width Element.fill ]
              }
            , { header =
                    OUI.Text.bodyLarge "37%"
                        |> OUI.Material.text shared.theme
                        |> Element.el [ Element.centerX ]
                        |> Element.el [ Element.width Element.fill ]
              , width = Element.fill
              , view =
                    \{ progress } ->
                        progress
                            |> OUI.Progress.withValue 0.37
                            |> OUI.Material.progress shared.theme [ Element.centerX ]
                            |> Element.el [ Element.width Element.fill ]
              }
            , { header =
                    OUI.Text.bodyLarge "50%"
                        |> OUI.Material.text shared.theme
                        |> Element.el [ Element.centerX ]
                        |> Element.el [ Element.width Element.fill ]
              , width = Element.fill
              , view =
                    \{ progress } ->
                        progress
                            |> OUI.Progress.withValue 0.5
                            |> OUI.Material.progress shared.theme [ Element.centerX ]
                            |> Element.el [ Element.width Element.fill ]
              }
            , { header =
                    OUI.Text.bodyLarge "99%"
                        |> OUI.Material.text shared.theme
                        |> Element.el [ Element.centerX ]
                        |> Element.el [ Element.width Element.fill ]
              , width = Element.fill
              , view =
                    \{ progress } ->
                        progress
                            |> OUI.Progress.withValue 0.99
                            |> OUI.Material.progress shared.theme [ Element.centerX ]
                            |> Element.el [ Element.width Element.fill ]
              }
            , { header =
                    OUI.Text.bodyLarge "100%"
                        |> OUI.Material.text shared.theme
                        |> Element.el [ Element.centerX ]
                        |> Element.el [ Element.width Element.fill ]
              , width = Element.fill
              , view =
                    \{ progress } ->
                        progress
                            |> OUI.Progress.withValue 1
                            |> OUI.Material.progress shared.theme [ Element.centerX ]
                            |> Element.el [ Element.width Element.fill ]
              }
            , { header =
                    OUI.Text.bodyLarge "undetermined"
                        |> OUI.Material.text shared.theme
                        |> Element.el [ Element.centerX ]
                        |> Element.el [ Element.width Element.fill ]
              , width = Element.fill
              , view =
                    \{ progress } ->
                        OUI.Material.progress shared.theme [ Element.centerX ] progress
                            |> Element.el [ Element.width Element.fill ]
              }
            ]
        }
