module OUI.Showcase.Colors exposing (Model, Msg, book)

import Color exposing (Color)
import Effect exposing (Effect)
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import OUI
import OUI.Button
import OUI.Explorer as Explorer
import OUI.Material
import OUI.Material.Color exposing (KeyColors)
import OUI.Material.Theme
import OUI.Material.Typography
import OUI.Menu
import OUI.MenuButton
import OUI.Text


colorCell : String -> Color -> Color -> Int -> Element msg
colorCell name color onColor height =
    Element.row
        [ Background.color (color |> OUI.Material.Color.toElementColor)
        , Font.color (onColor |> OUI.Material.Color.toElementColor)
        , Element.width Element.fill
        , Element.height <| Element.px height
        , Element.padding 15
        ]
        [ Element.el [ Element.alignTop ] <| Element.text name
        ]


showKeyColors : OUI.Material.Theme.Theme themeExt -> Element msg
showKeyColors theme =
    let
        scheme : OUI.Material.Color.Scheme
        scheme =
            OUI.Material.Theme.colorscheme theme

        typescale : OUI.Material.Typography.Typescale
        typescale =
            OUI.Material.Theme.typescale theme
    in
    Element.column
        ([ Element.spacing 5
         , Element.width <| Element.px 820
         ]
            ++ OUI.Material.Typography.attrs OUI.Text.Body OUI.Text.Small OUI.Text.NoColor typescale scheme
        )
        [ OUI.Text.titleMedium "Key Colors"
            |> OUI.Text.withColor OUI.Neutral
            |> OUI.Material.Typography.renderWithAttrs
                typescale
                scheme
                [ Element.paddingEach { bottom = 10, top = 0, left = 0, right = 0 }
                ]
        , Element.row [ Element.spacing 5, Element.width Element.fill ]
            [ Element.column [ Element.width Element.fill ]
                [ colorCell "Primary" scheme.surfaceContainer scheme.onSurface 40
                , colorCell "" scheme.keyColors.primary Color.white 70
                ]
            , Element.column [ Element.width Element.fill ]
                [ colorCell "Secondary" scheme.surfaceContainer scheme.onSurface 40
                , colorCell "" scheme.keyColors.secondary Color.white 70
                ]
            , Element.column [ Element.width Element.fill ]
                [ colorCell "Tertiary" scheme.surfaceContainer scheme.onSurface 40
                , colorCell "" scheme.keyColors.tertiary Color.white 70
                ]
            , Element.column [ Element.width Element.fill ]
                [ colorCell "Error" scheme.surfaceContainer scheme.onSurface 40
                , colorCell "" scheme.keyColors.error Color.white 70
                ]
            , Element.column [ Element.width Element.fill ]
                [ colorCell "Neutral" scheme.surfaceContainer scheme.onSurface 40
                , colorCell "" scheme.keyColors.neutral Color.white 70
                ]
            , Element.column [ Element.width Element.fill ]
                [ colorCell "Neutral Variant" scheme.surfaceContainer scheme.onSurface 40
                , colorCell "" scheme.keyColors.neutralVariant Color.white 70
                ]
            ]
        ]
        |> Element.el
            [ Background.color <| OUI.Material.Color.toElementColor scheme.surfaceContainer
            , Element.padding 15
            , Border.rounded 10
            , Border.color <| OUI.Material.Color.toElementColor scheme.outlineVariant
            , Border.width 1
            ]


showColorScheme : String -> OUI.Material.Theme.Theme themeExt -> Element msg
showColorScheme title theme =
    let
        scheme : OUI.Material.Color.Scheme
        scheme =
            OUI.Material.Theme.colorscheme theme

        typescale : OUI.Material.Typography.Typescale
        typescale =
            OUI.Material.Theme.typescale theme
    in
    Element.column
        ([ Element.spacing 5
         , Element.width <| Element.px 820
         ]
            ++ OUI.Material.Typography.attrs OUI.Text.Body OUI.Text.Small OUI.Text.NoColor typescale scheme
        )
        [ OUI.Text.titleMedium title
            |> OUI.Text.withColor OUI.Neutral
            |> OUI.Material.Typography.renderWithAttrs
                typescale
                scheme
                [ Element.paddingEach { bottom = 10, top = 0, left = 0, right = 0 }
                ]
        , Element.row [ Element.spacing 5, Element.width Element.fill ]
            [ Element.column [ Element.spacing 5, Element.width Element.fill ]
                [ Element.column [ Element.width Element.fill ]
                    [ colorCell "Primary" scheme.primary scheme.onPrimary 100
                    , colorCell "On Primary" scheme.onPrimary scheme.primary 40
                    ]
                , Element.column [ Element.width Element.fill ]
                    [ colorCell "Primary Container" scheme.primaryContainer scheme.onPrimaryContainer 100
                    , colorCell "On Primary Container" scheme.onPrimaryContainer scheme.primaryContainer 40
                    ]
                ]
            , Element.column [ Element.spacing 5, Element.width Element.fill ]
                [ Element.column [ Element.width Element.fill ]
                    [ colorCell "Secondary" scheme.secondary scheme.onSecondary 100
                    , colorCell "On Secondary" scheme.onSecondary scheme.secondary 40
                    ]
                , Element.column [ Element.width Element.fill ]
                    [ colorCell "Secondary Container" scheme.secondaryContainer scheme.onSecondaryContainer 100
                    , colorCell "On Secondary Container" scheme.onSecondaryContainer scheme.secondaryContainer 40
                    ]
                ]
            , Element.column [ Element.spacing 5, Element.width Element.fill ]
                [ Element.column [ Element.width Element.fill ]
                    [ colorCell "Tertiary" scheme.tertiary scheme.onTertiary 100
                    , colorCell "On Tertiary" scheme.onTertiary scheme.tertiary 40
                    ]
                , Element.column [ Element.width Element.fill ]
                    [ colorCell "Tertiary Container" scheme.tertiaryContainer scheme.onTertiaryContainer 100
                    , colorCell "On Tertiary Container" scheme.onTertiaryContainer scheme.tertiaryContainer 40
                    ]
                ]
            , Element.column
                [ Element.spacing 5
                , Element.paddingEach { left = 10, top = 0, bottom = 0, right = 0 }
                , Element.width Element.fill
                ]
                [ Element.column [ Element.width Element.fill ]
                    [ colorCell "Error" scheme.error scheme.onError 100
                    , colorCell "On Error" scheme.onError scheme.error 40
                    ]
                , Element.column [ Element.width Element.fill ]
                    [ colorCell "Error Container" scheme.errorContainer scheme.onErrorContainer 100
                    , colorCell "On Error Container" scheme.onErrorContainer scheme.errorContainer 40
                    ]
                ]
            ]
        , Element.row
            [ Element.width Element.fill
            , Element.paddingEach
                { top = 10, left = 0, right = 0, bottom = 0 }
            ]
            [ colorCell "Surface Dim" scheme.surfaceDim scheme.onSurface 100
            , colorCell "Surface" scheme.surface scheme.onSurface 100
            , colorCell "Surface Bright" scheme.surfaceBright scheme.onSurface 100
            ]
        , Element.row
            [ Element.width Element.fill
            ]
            [ colorCell "Surface Container Lowest" scheme.surfaceContainerLowest scheme.onSurface 100
            , colorCell "Surface Container Low" scheme.surfaceContainerLow scheme.onSurface 100
            , colorCell "Surface Container" scheme.surfaceContainer scheme.onSurface 100
            , colorCell "Surface Container High" scheme.surfaceContainerHigh scheme.onSurface 100
            , colorCell "Surface Container Highest" scheme.surfaceContainerHighest scheme.onSurface 100
            ]
        , Element.row
            [ Element.width Element.fill
            ]
            [ colorCell "On Surface" scheme.onSurface scheme.surface 40
            , colorCell "On Surface Variant" scheme.onSurfaceVariant scheme.surfaceVariant 40
            , colorCell "Outline" scheme.outline scheme.surface 40
            , colorCell "Outline Variant" scheme.outlineVariant scheme.onSurface 40
            ]
        ]
        |> Element.el
            [ Background.color <| OUI.Material.Color.toElementColor scheme.surfaceContainer
            , Element.padding 15
            , Border.rounded 10
            , Border.color <| OUI.Material.Color.toElementColor scheme.outlineVariant
            , Border.width 1
            ]


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Colors"
        { init = init
        , update = update
        , subscriptions = \_ _ -> Sub.none
        }
        |> Explorer.withChapter
            (\shared model ->
                Element.row
                    [ Element.spacing 20
                    ]
                    [ "Current color scheme: "
                        |> OUI.Text.bodyLarge
                        |> OUI.Material.text shared.theme
                    , OUI.MenuButton.new ColorThemeButtonMsg
                        (\i ->
                            SelectColorScheme i
                                (Tuple.second shared.selectedColorScheme)
                        )
                        (OUI.Button.new
                            (Explorer.getSelectedColorTheme shared |> .name)
                        )
                        (OUI.Menu.new
                            (\i ->
                                Explorer.getColorTheme i shared
                                    |> .name
                            )
                            |> OUI.Menu.addItems (List.range 0 (List.length shared.colorThemeList - 1))
                        )
                        |> OUI.MenuButton.alignBottom
                        |> OUI.Material.menuButton shared.theme
                            model.colorThemeButton
                            [ Element.centerX
                            ]
                    ]
                    |> Element.map Explorer.bookMsg
            )
        |> Explorer.withStaticChapter
            (\shared ->
                shared.theme
                    |> showKeyColors
            )
        |> Explorer.withStaticChapter
            (\shared ->
                shared.theme
                    |> OUI.Material.Theme.withColorscheme
                        (shared.colorThemeList
                            |> List.drop (shared.selectedColorScheme |> Tuple.first)
                            |> List.head
                            |> Maybe.map (.schemes >> .light)
                            |> Maybe.withDefault OUI.Material.Color.defaultLightScheme
                        )
                    |> showColorScheme "Light Scheme"
            )
        |> Explorer.withStaticChapter
            (\shared ->
                shared.theme
                    |> OUI.Material.Theme.withColorscheme
                        (shared.colorThemeList
                            |> List.drop (shared.selectedColorScheme |> Tuple.first)
                            |> List.head
                            |> Maybe.map (.schemes >> .dark)
                            |> Maybe.withDefault OUI.Material.Color.defaultDarkScheme
                        )
                    |> showColorScheme "Dark Scheme"
            )


type Msg
    = ColorThemeButtonMsg (OUI.MenuButton.Msg Int Msg)
    | SelectColorScheme Int Explorer.ColorSchemeType


type alias Model =
    { colorThemeButton : OUI.MenuButton.State
    }


init : Explorer.Shared themeExt -> ( Model, Effect Explorer.SharedMsg Msg )
init shared =
    { colorThemeButton = OUI.MenuButton.init "color-page-color-theme-button" }
        |> Effect.withNone


update : Explorer.Shared themeExt -> Msg -> Model -> ( Model, Effect Explorer.SharedMsg Msg )
update _ msg model =
    case msg of
        ColorThemeButtonMsg buttonMsg ->
            let
                ( state, cmd ) =
                    OUI.MenuButton.update buttonMsg model.colorThemeButton
            in
            { model
                | colorThemeButton = state
            }
                |> Effect.withCmd cmd

        SelectColorScheme i t ->
            model
                |> Effect.withShared (Explorer.selectColorScheme i t)
