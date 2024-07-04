module OUI.Showcase.Navigation exposing (Model, Msg, book)

import Effect
import Element exposing (Element)
import OUI.Badge exposing (Badge)
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Icon
import OUI.Material as Material
import OUI.Navigation as Navigation exposing (Navigation)
import OUI.Text as Text


type alias Model =
    { expanded : Bool }


type Msg
    = Expand Bool


book : Explorer.Book themeExt Model Msg
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


addEntries : Navigation btnC String msg -> Navigation btnC String msg
addEntries =
    let
        badge50 : Badge
        badge50 =
            OUI.Badge.number 50

        badgeEmpty : Badge
        badgeEmpty =
            OUI.Badge.small

        badgeLorem : Badge
        badgeLorem =
            OUI.Badge.label "lorem ipsum!"
    in
    Navigation.addSectionHeader "Mail"
        >> Navigation.addEntryWithBadge "inbox" "Inbox" OUI.Icon.check badge50
        >> Navigation.addEntryWithBadge "trash" "Trash" OUI.Icon.clear badgeEmpty
        >> Navigation.addDivider
        >> Navigation.addEntryWithBadge "folder" "Folder" OUI.Icon.check badgeLorem
        >> Navigation.addEntry "folder2" "Folder" OUI.Icon.light_mode


nav : Navigation btnC String (Explorer.BookMsg msg)
nav =
    Navigation.new Explorer.logEvent
        |> addEntries


drawer : Explorer.Shared themeExt -> Element (Explorer.BookMsg Msg)
drawer { theme } =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30 ]
        [ divider
        , Text.titleLarge "Drawer" |> Material.text theme
        , Element.el
            [ Element.width Element.fill
            , Element.height <| Element.px 500
            ]
            (nav |> Material.navigation theme [])
        ]


rail : Explorer.Shared themeExt -> Element (Explorer.BookMsg Msg)
rail { theme } =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30, Element.width <| Element.px 360 ]
        [ divider
        , Text.titleLarge "Rail" |> Material.text theme
        , Element.el
            [ Element.width Element.fill
            , Element.height <| Element.px 500
            ]
            (nav
                |> Navigation.rail
                |> Material.navigation theme []
            )
        ]


modal : Explorer.Shared themeExt -> Element (Explorer.BookMsg Msg)
modal { theme } =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30 ]
        [ divider
        , Text.titleLarge "Modal" |> Material.text theme
        , Element.el
            [ Element.width Element.fill
            , Element.height <| Element.px 500
            ]
            (nav
                |> Navigation.modal (Explorer.logEvent "dismiss modal")
                |> Material.navigation theme []
            )
        ]


dynamic : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
dynamic { theme } { expanded } =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30, Element.width <| Element.px 360 ]
        [ divider
        , Text.titleLarge "Dynamic" |> Material.text theme
        , Element.el
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
        ]
