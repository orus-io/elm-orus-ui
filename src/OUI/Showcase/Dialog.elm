module OUI.Showcase.Dialog exposing (book)

import Element exposing (Element)
import OUI.Dialog as Dialog
import OUI.Element.Modal as Modal
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Material


book : Explorer.Book themeExt () ()
book =
    Explorer.book "Dialog"
        |> Explorer.withStaticChapter demo
        |> Explorer.withStaticChapter iconDemo
        |> Explorer.withStaticChapter longTextDemo
        |> Explorer.withStaticChapter fullscreenDemo


demo : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
demo shared =
    Element.el
        ([ Element.width Element.fill
         , Element.height <| Element.px 200
         ]
            ++ ([ Dialog.new "A Dialog"
                    |> Dialog.withSupportingText "This dialog has no icon and only a 'dismiss' action"
                    |> Dialog.onDismiss "Cancel" (Explorer.logEvent "Cancel")
                    |> OUI.Material.dialog shared.theme []
                ]
                    |> Modal.single
               )
        )
        (Element.text "Some content")


iconDemo : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
iconDemo shared =
    Element.el
        ([ Element.width Element.fill
         , Element.height <| Element.px 300
         ]
            ++ ([ Dialog.new "A Dialog"
                    |> Dialog.withIcon OUI.Icon.check
                    |> Dialog.withSupportingText "This dialog has a hero icon and both actions, and a medium width"
                    |> Dialog.withWidth Dialog.Medium
                    |> Dialog.onAccept "OK" (Explorer.logEvent "OK")
                    |> Dialog.onDismiss "Dismiss" (Explorer.logEvent "Dismiss")
                    |> OUI.Material.dialog shared.theme []
                ]
                    |> Modal.single
               )
        )
        (Element.text "Some content")


longTextDemo : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
longTextDemo shared =
    Element.el
        ([ Element.width Element.fill
         , Element.height <| Element.px 300
         ]
            ++ ([ Dialog.new "A Dialog"
                    |> Dialog.withSupportingText "This dialog has a only a 'accept' button. It also has a longer supporting text, which should be wrapped."
                    |> Dialog.withWidth Dialog.Large
                    |> Dialog.onAccept "OK" (Explorer.logEvent "OK")
                    |> OUI.Material.dialog shared.theme []
                ]
                    |> Modal.single
               )
        )
        (Element.text "Some content")


fullscreenDemo : Explorer.Shared themeExt -> Element (Explorer.BookMsg ())
fullscreenDemo shared =
    Element.el
        ([ Element.width <| Element.px 250
         , Element.height <| Element.px 300
         ]
            ++ ([ Dialog.new "A Dialog"
                    |> Dialog.withSupportingText "This dialog is in fullscreen mode. This mode is meant for small devices"
                    |> Dialog.withWidth Dialog.Fullscreen
                    |> Dialog.onAccept "OK" (Explorer.logEvent "OK")
                    |> Dialog.onDismiss "Cancel" (Explorer.logEvent "Cancel")
                    |> OUI.Material.dialog shared.theme []
                ]
                    |> Modal.single
               )
        )
        (Element.text "Some content")
