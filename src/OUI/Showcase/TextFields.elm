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
import OUI.TextField as TextField exposing (TextField, multiline)


book : Explorer.Book Model Msg
book =
    Explorer.statefulBook "Text Fields"
        { init =
            \_ ->
                { inputs = Dict.empty
                }
                    |> Effect.withNone
        , update =
            update
        , subscriptions = \_ _ -> Sub.none
        }
        |> Explorer.withChapter (textfields False)
        |> Explorer.withChapter (textfields True)


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
    { inputs : Dict String InputState }


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


update : a -> Msg -> Model -> ( Model, Effect sharedMsg msg )
update _ msg model =
    case msg of
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


textfields : Bool -> Explorer.Shared -> Model -> Element (Explorer.BookMsg Msg)
textfields multiline { theme } model =
    let
        key : String -> String
        key name =
            name
                ++ (if multiline then
                        "-multiline"

                    else
                        ""
                   )

        textField : String -> String -> TextField Msg
        textField label name =
            TextField.new label (OnChange (key name)) (inputText (key name) model)
                |> TextField.onFocusBlur (OnFocus (key name)) (OnLoseFocus (key name))
                |> TextField.withFocused (inputHasFocus (key name) model)

        render : TextField msg -> Element msg
        render =
            (if multiline then
                TextField.multiline True

             else
                identity
            )
                >> Material.textField theme
                    [ Element.centerX
                    , Element.centerY
                    , Element.width Element.fill
                    ]
    in
    Element.row
        [ Border.width 1
        , theme.colorscheme.outline
            |> OUI.Material.Color.toElementColor
            |> Border.color
        , theme.colorscheme.surfaceContainer
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
                |> Element.map Explorer.bookMsg
            , textField "Filled" "filledLeadIcon"
                |> TextField.withSupportingText "A filled text field with leading icon"
                |> TextField.withLeadingIcon check
                |> TextField.withType TextField.Filled
                |> render
                |> Element.map Explorer.bookMsg
            , textField "Filled" "filledTrailIcon"
                |> TextField.withSupportingText "A filled text field with trailing icon"
                |> TextField.withTrailingIcon clear
                |> TextField.withType TextField.Filled
                |> render
                |> Element.map Explorer.bookMsg
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
                |> Element.map Explorer.bookMsg
            , textField "Filled" "filledErrorIcon"
                |> TextField.withSupportingText "A filled text field with a error icon"
                |> TextField.withType TextField.Filled
                |> TextField.withErrorIcon clear
                |> TextField.withColor OUI.Error
                |> render
                |> Element.map Explorer.bookMsg
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
                |> Element.map Explorer.bookMsg
            , textField "Outlined" "outlinedLeadIcon"
                |> TextField.withSupportingText "A outlined text field with leading icon"
                |> TextField.withLeadingIcon check
                |> TextField.withType TextField.Outlined
                |> render
                |> Element.map Explorer.bookMsg
            , textField "Outlined" "outlinedTrailIcon"
                |> TextField.withSupportingText "A outlined text field with trailing icon"
                |> TextField.withTrailingIcon clear
                |> TextField.withType TextField.Outlined
                |> render
                |> Element.map Explorer.bookMsg
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
                |> Element.map Explorer.bookMsg
            , textField "Outlined" "outlinedErrorIcon"
                |> TextField.withSupportingText "A outlined text field with a error icon"
                |> TextField.withType TextField.Outlined
                |> TextField.withErrorIcon clear
                |> TextField.withColor OUI.Error
                |> render
                |> Element.map Explorer.bookMsg
            ]
        ]
