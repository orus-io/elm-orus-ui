module OUI.Showcase.TextFields exposing (..)

import Dict exposing (Dict)
import Effect exposing (Effect)
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import OUI
import OUI.Explorer as Explorer exposing (Explorer)
import OUI.Icon exposing (check, clear)
import OUI.Material as Material
import OUI.Material.Color
import OUI.TextField as TextField


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
        |> Explorer.withChapter textfields


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


update _ msg model =
    case msg of
        OnChange name value ->
            let
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


textfields : Explorer.Shared -> Model -> Element (Explorer.BookMsg Msg)
textfields { theme } model =
    let
        render =
            Material.renderTextField theme
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
            [ TextField.new "Filled" (OnChange "filled") (inputText "filled" model)
                |> TextField.onFocusBlur (OnFocus "filled") (OnLoseFocus "filled")
                |> TextField.withFocused (inputHasFocus "filled" model)
                |> TextField.withSupportingText "A filled text field"
                |> TextField.withType TextField.Filled
                |> render
                |> Element.map Explorer.bookMsg
            , TextField.new "Filled" (OnChange "filledLeadIcon") (inputText "filledLeadIcon" model)
                |> TextField.onFocusBlur (OnFocus "filledLeadIcon") (OnLoseFocus "filledLeadIcon")
                |> TextField.withFocused (inputHasFocus "filledLeadIcon" model)
                |> TextField.withSupportingText "A filled text field with leading icon"
                |> TextField.withLeadingIcon check
                |> TextField.withType TextField.Filled
                |> render
                |> Element.map Explorer.bookMsg
            , TextField.new "Filled" (OnChange "filledTrailIcon") (inputText "filledTrailIcon" model)
                |> TextField.onFocusBlur (OnFocus "filledTrailIcon") (OnLoseFocus "filledTrailIcon")
                |> TextField.withFocused (inputHasFocus "filledTrailIcon" model)
                |> TextField.withSupportingText "A filled text field with trailing icon"
                |> TextField.withTrailingIcon clear
                |> TextField.withType TextField.Filled
                |> render
                |> Element.map Explorer.bookMsg
            , TextField.new "Filled"
                (OnChange "filledLeadTrailClickIcon"
                    >> Explorer.bookMsg
                )
                (inputText "filledLeadTrailClickIcon" model)
                |> TextField.onFocusBlur
                    (OnFocus "filledLeadTrailClickIcon" |> Explorer.bookMsg)
                    (OnLoseFocus "filledLeadTrailClickIcon" |> Explorer.bookMsg)
                |> TextField.withFocused (inputHasFocus "filledLeadTrailClickIcon" model)
                |> TextField.withSupportingText "A filled text field with clickable trailing icon"
                |> TextField.withLeadingIcon check
                |> TextField.withClickableTrailingIcon (Explorer.logEvent "Clicked !") clear
                |> TextField.withType TextField.Filled
                |> render
            , TextField.new "Filled" (OnChange "filledError") (inputText "filledError" model)
                |> TextField.onFocusBlur (OnFocus "filledError") (OnLoseFocus "filledError")
                |> TextField.withFocused (inputHasFocus "filledError" model)
                |> TextField.withSupportingText "A filled text field with error"
                |> TextField.withType TextField.Filled
                |> TextField.withColor OUI.Error
                |> render
                |> Element.map Explorer.bookMsg
            , TextField.new "Filled" (OnChange "filledErrorIcon") (inputText "filledErrorIcon" model)
                |> TextField.onFocusBlur (OnFocus "filledErrorIcon") (OnLoseFocus "filledErrorIcon")
                |> TextField.withFocused (inputHasFocus "filledErrorIcon" model)
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
            [ TextField.new "Outlined" (OnChange "outlined") (inputText "outlined" model)
                |> TextField.onFocusBlur (OnFocus "outlined") (OnLoseFocus "outlined")
                |> TextField.withFocused (inputHasFocus "outlined" model)
                |> TextField.withType TextField.Outlined
                |> TextField.withSupportingText "A outlined text field"
                |> render
                |> Element.map Explorer.bookMsg
            , TextField.new "Outlined" (OnChange "outlinedLeadIcon") (inputText "outlinedLeadIcon" model)
                |> TextField.onFocusBlur (OnFocus "outlinedLeadIcon") (OnLoseFocus "outlinedLeadIcon")
                |> TextField.withFocused (inputHasFocus "outlinedLeadIcon" model)
                |> TextField.withSupportingText "A outlined text field with leading icon"
                |> TextField.withLeadingIcon check
                |> TextField.withType TextField.Outlined
                |> render
                |> Element.map Explorer.bookMsg
            , TextField.new "Outlined" (OnChange "outlinedTrailIcon") (inputText "outlinedTrailIcon" model)
                |> TextField.onFocusBlur (OnFocus "outlinedTrailIcon") (OnLoseFocus "outlinedTrailIcon")
                |> TextField.withFocused (inputHasFocus "outlinedTrailIcon" model)
                |> TextField.withSupportingText "A outlined text field with trailing icon"
                |> TextField.withTrailingIcon clear
                |> TextField.withType TextField.Outlined
                |> render
                |> Element.map Explorer.bookMsg
            , TextField.new "Outlined"
                (OnChange "outlinedLeadTrailClickIcon"
                    >> Explorer.bookMsg
                )
                (inputText "outlinedLeadTrailClickIcon" model)
                |> TextField.onFocusBlur
                    (OnFocus "outlinedLeadTrailClickIcon" |> Explorer.bookMsg)
                    (OnLoseFocus "outlinedLeadTrailClickIcon" |> Explorer.bookMsg)
                |> TextField.withFocused (inputHasFocus "outlinedLeadTrailClickIcon" model)
                |> TextField.withSupportingText "A outlined text field with clickable trailing icon"
                |> TextField.withLeadingIcon check
                |> TextField.withClickableTrailingIcon (Explorer.logEvent "Clicked !") clear
                |> TextField.withType TextField.Outlined
                |> render
            , TextField.new "Outlined" (OnChange "outlinedError") (inputText "outlinedError" model)
                |> TextField.onFocusBlur (OnFocus "outlinedError") (OnLoseFocus "outlinedError")
                |> TextField.withFocused (inputHasFocus "outlinedError" model)
                |> TextField.withSupportingText "A outlined text field with error"
                |> TextField.withType TextField.Outlined
                |> TextField.withColor OUI.Error
                |> render
                |> Element.map Explorer.bookMsg
            , TextField.new "Outlined" (OnChange "outlinedErrorIcon") (inputText "outlinedErrorIcon" model)
                |> TextField.onFocusBlur (OnFocus "outlinedErrorIcon") (OnLoseFocus "outlinedErrorIcon")
                |> TextField.withFocused (inputHasFocus "outlinedErrorIcon" model)
                |> TextField.withSupportingText "A outlined text field with a error icon"
                |> TextField.withType TextField.Outlined
                |> TextField.withErrorIcon clear
                |> TextField.withColor OUI.Error
                |> render
                |> Element.map Explorer.bookMsg
            ]
        ]
