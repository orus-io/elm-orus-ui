module OUI.Showcase.Navigation exposing (Model, Msg, book)

import Effect
import Element exposing (Element)
import OUI.Explorer as Explorer exposing (Explorer)
import OUI.Icon
import OUI.Material as Material
import OUI.Navigation as Navigation


type alias Model =
    { expanded : Bool }


type Msg
    = Expand Bool


book : Explorer.Book Model Msg
book =
    Explorer.statefulBook "Navigation"
        { init = \_ -> { expanded = False } |> Effect.withNone
        , update =
            \_ msg model ->
                case msg of
                    Expand value ->
                        { model | expanded = value }
                            |> Effect.withNone
        , subscriptions = \_ _ -> Sub.none
        }
        |> Explorer.withStaticChapter drawer
        |> Explorer.withStaticChapter rail
        |> Explorer.withStaticChapter modal
        |> Explorer.withChapter dynamic


addEntries =
    Navigation.addSectionHeader "Mail"
        >> Navigation.addEntryWithBadge "inbox" "Inbox" OUI.Icon.check "50"
        >> Navigation.addEntryWithBadge "trash" "Trash" OUI.Icon.clear ""
        >> Navigation.addEntryWithBadge "folder" "Folder" OUI.Icon.check "4"
        >> Navigation.addEntry "folder2" "Folder" OUI.Icon.light_mode


nav =
    Navigation.new Explorer.logEvent
        |> addEntries


drawer : Explorer.Shared -> Element (Explorer.BookMsg Msg)
drawer { theme } =
    Element.el
        [ Element.width Element.fill
        , Element.height <| Element.px 500
        ]
        (nav |> Material.navigation theme [])


rail : Explorer.Shared -> Element (Explorer.BookMsg Msg)
rail { theme } =
    Element.el
        [ Element.width Element.fill
        , Element.height <| Element.px 500
        ]
        (nav
            |> Navigation.rail
            |> Material.navigation theme []
        )


modal : Explorer.Shared -> Element (Explorer.BookMsg Msg)
modal { theme } =
    Element.el
        [ Element.width Element.fill
        , Element.height <| Element.px 500
        ]
        (nav
            |> Navigation.modal (Explorer.logEvent "dismiss modal")
            |> Material.navigation theme []
        )


dynamic : Explorer.Shared -> Model -> Element (Explorer.BookMsg Msg)
dynamic { theme } { expanded } =
    Element.el
        [ Element.width Element.fill
        , Element.height <| Element.px 500
        ]
        (Navigation.new (\_ -> Explorer.bookMsg <| Expand <| not expanded)
            |> addEntries
            |> (if expanded then
                    Navigation.rail

                else
                    identity
               )
            |> Material.navigation theme []
        )
