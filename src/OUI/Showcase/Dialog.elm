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
                    |> Dialog.withSupportingText "This dialog has a hero icon and both actions"
                    |> Dialog.onAccept "OK" (Explorer.logEvent "OK")
                    |> Dialog.onDismiss "Dismiss" (Explorer.logEvent "Dismiss")
                    |> OUI.Material.dialog shared.theme []
                ]
                    |> Modal.single
               )
        )
        (Element.text "Some content")
