module OUI.Showcase.TextFields exposing (InputState, Model, Msg(..), book, inputHasFocus, inputText, newInputState, textfields, update)

import Dict exposing (Dict)
import Effect exposing (Effect)
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import OUI
import OUI.Explorer as Explorer
import OUI.Icon exposing (check, clear)
import OUI.Material as Material
import OUI.Material.Color
import OUI.Material.Theme as Theme
import OUI.Tabs
import OUI.TextField as TextField exposing (TextField)


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Text Fields"
        { init =
            \_ ->
                { inputs = Dict.empty
                , selectedTab = TextField.Text
                }
                    |> Effect.withNone
        , update =
            update
        , subscriptions = \_ _ -> Sub.none
        }
        |> Explorer.withChapter tabs


type alias InputState =
    { text : String
    , hasFocus : Bool
    }


newInputState : InputState
newInputState =
    { text = ""
    , hasFocus = False
    }


type alias Model =
    { inputs : Dict String InputState
    , selectedTab : TextField.Datatype
    }


inputText : String -> Model -> String
inputText name { inputs } =
    Dict.get name inputs
        |> Maybe.withDefault newInputState
        |> .text


inputHasFocus : String -> Model -> Bool
inputHasFocus name { inputs } =
    Dict.get name inputs
        |> Maybe.withDefault newInputState
        |> .hasFocus


type Msg
    = OnChange String String
    | OnFocus String
    | OnLoseFocus String
    | SelectTab TextField.Datatype


update : a -> Msg -> Model -> ( Model, Effect sharedMsg msg )
update _ msg model =
    case msg of
        SelectTab tab ->
            { model
                | selectedTab = tab
            }
                |> Effect.withNone

        OnChange name value ->
            let
                input : InputState
                input =
                    Dict.get name model.inputs
                        |> Maybe.withDefault newInputState
            in
            { model
                | inputs =
                    Dict.insert name
                        { input | text = value }
                        model.inputs
            }
                |> Effect.withNone

        OnFocus name ->
            let
                input : InputState
                input =
                    Dict.get name model.inputs
                        |> Maybe.withDefault newInputState
            in
            { model
                | inputs =
                    Dict.insert name
                        { input | hasFocus = True }
                        model.inputs
            }
                |> Effect.withNone

        OnLoseFocus name ->
            let
                input : InputState
                input =
                    Dict.get name model.inputs
                        |> Maybe.withDefault newInputState
            in
            { model
                | inputs =
                    Dict.insert name
                        { input | hasFocus = False }
                        model.inputs
            }
                |> Effect.withNone


tabs : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
tabs shared model =
    Element.column [ Element.width Element.fill, Element.spacing 2 ]
        [ OUI.Tabs.new identity (Explorer.bookMsg << SelectTab)
            |> OUI.Tabs.withItems
                [ ( TextField.Text, "Text" )
                , ( TextField.Search, "Search" )
                , ( TextField.Username, "Username" )
                , ( TextField.Email, "Email" )
                , ( TextField.Password False, "Password" )
                , ( TextField.Password True, "Password (show)" )
                , ( TextField.NewPassword False, "New Password" )
                , ( TextField.NewPassword True, "New Password (show)" )
                , ( TextField.Multiline, "Multiline" )
                ]
            |> OUI.Tabs.secondary
            |> OUI.Tabs.withSelected model.selectedTab
            |> Material.tabs shared.theme [ Element.width Element.fill ]
        , case model.selectedTab of
            TextField.Text ->
                textfields ( "text", identity ) shared model

            TextField.Search ->
                textfields ( "search", TextField.search ) shared model

            TextField.Username ->
                textfields ( "username", TextField.username ) shared model

            TextField.Email ->
                textfields ( "email", TextField.email ) shared model

            TextField.Password show ->
                textfields ( "password", TextField.password show ) shared model

            TextField.NewPassword show ->
                textfields ( "newpassword", TextField.newPassword show ) shared model

            TextField.Multiline ->
                textfields ( "multiline", TextField.multiline True ) shared model
        ]


textfields : ( String, TextField (Explorer.BookMsg Msg) -> TextField (Explorer.BookMsg Msg) ) -> Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
textfields ( datatype, setDatatype ) { theme } model =
    let
        colorscheme : OUI.Material.Color.Scheme
        colorscheme =
            Theme.colorscheme theme

        key : String -> String
        key name =
            name ++ "-" ++ datatype

        textField : String -> String -> TextField (Explorer.BookMsg Msg)
        textField label name =
            TextField.new label
                (Explorer.bookMsg << (OnChange <| key name))
                (inputText (key name) model)
                |> TextField.onFocusBlur
                    (Explorer.bookMsg <| OnFocus <| key name)
                    (Explorer.bookMsg <| OnLoseFocus <| key name)
                |> TextField.withFocused (inputHasFocus (key name) model)

        render : TextField (Explorer.BookMsg Msg) -> Element (Explorer.BookMsg Msg)
        render =
            setDatatype
                >> Material.textField theme
                    [ Element.centerX
                    , Element.centerY
                    , Element.width Element.fill
                    ]
    in
    Element.row
        [ Border.width 1
        , colorscheme.outline
            |> OUI.Material.Color.toElementColor
            |> Border.color
        , colorscheme.surfaceContainer
            |> OUI.Material.Color.toElementColor
            |> Background.color
        ]
        [ Element.column
            [ Element.spacing 20
            , Element.width <| Element.px 500
            , Element.padding 40
            ]
            [ textField "Filled" "filled"
                |> TextField.withSupportingText "A filled text field"
                |> TextField.withType TextField.Filled
                |> render
            , textField "Filled" "filledLeadIcon"
                |> TextField.withSupportingText "A filled text field with leading icon"
                |> TextField.withLeadingIcon check
                |> TextField.withType TextField.Filled
                |> render
            , textField "Filled" "filledTrailIcon"
                |> TextField.withSupportingText "A filled text field with trailing icon"
                |> TextField.withTrailingIcon clear
                |> TextField.withType TextField.Filled
                |> render
            , let
                k : String
                k =
                    key "filledLeadTrailClickIcon"
              in
              TextField.new "Filled"
                (OnChange k
                    >> Explorer.bookMsg
                )
                (inputText k model)
                |> TextField.onFocusBlur
                    (OnFocus k |> Explorer.bookMsg)
                    (OnLoseFocus k |> Explorer.bookMsg)
                |> TextField.withFocused (inputHasFocus k model)
                |> TextField.withSupportingText "A filled text field with clickable trailing icon"
                |> TextField.withLeadingIcon check
                |> TextField.withClickableTrailingIcon (Explorer.logEvent "Clicked !") clear
                |> TextField.withType TextField.Filled
                |> render
            , textField "Filled" "filledError"
                |> TextField.withSupportingText "A filled text field with error"
                |> TextField.withType TextField.Filled
                |> TextField.withColor OUI.Error
                |> render
            , textField "Filled" "filledErrorIcon"
                |> TextField.withSupportingText "A filled text field with a error icon"
                |> TextField.withType TextField.Filled
                |> TextField.withErrorIcon clear
                |> TextField.withColor OUI.Error
                |> render
            ]
        , Element.column
            [ Element.spacing 20
            , Element.width <| Element.px 500
            , Element.padding 40
            ]
            [ textField "Outlined" "outlined"
                |> TextField.withType TextField.Outlined
                |> TextField.withSupportingText "A outlined text field"
                |> render
            , textField "Outlined" "outlinedLeadIcon"
                |> TextField.withSupportingText "A outlined text field with leading icon"
                |> TextField.withLeadingIcon check
                |> TextField.withType TextField.Outlined
                |> render
            , textField "Outlined" "outlinedTrailIcon"
                |> TextField.withSupportingText "A outlined text field with trailing icon"
                |> TextField.withTrailingIcon clear
                |> TextField.withType TextField.Outlined
                |> render
            , let
                k : String
                k =
                    key "outlinedLeadTrailClickIcon"
              in
              TextField.new "Outlined"
                (OnChange k
                    >> Explorer.bookMsg
                )
                (inputText k model)
                |> TextField.onFocusBlur
                    (OnFocus k |> Explorer.bookMsg)
                    (OnLoseFocus k |> Explorer.bookMsg)
                |> TextField.withFocused (inputHasFocus k model)
                |> TextField.withSupportingText "A outlined text field with clickable trailing icon"
                |> TextField.withLeadingIcon check
                |> TextField.withClickableTrailingIcon (Explorer.logEvent "Clicked !") clear
                |> TextField.withType TextField.Outlined
                |> render
            , textField "Outlined" "outlinedError"
                |> TextField.withSupportingText "A outlined text field with error"
                |> TextField.withType TextField.Outlined
                |> TextField.withColor OUI.Error
                |> render
            , textField "Outlined" "outlinedErrorIcon"
                |> TextField.withSupportingText "A outlined text field with a error icon"
                |> TextField.withType TextField.Outlined
                |> TextField.withErrorIcon clear
                |> TextField.withColor OUI.Error
                |> render
            ]
        ]
