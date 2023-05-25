module OUI.Showcase.TextFields exposing (..)

import Dict exposing (Dict)
import Effect exposing (Effect)
import Element exposing (Element)
import OUI
import OUI.Explorer as Explorer
import OUI.Icon exposing (check, clear)
import OUI.Material as Material
import OUI.Material.Button exposing (outlinedAttrs)
import OUI.TextField as TextField exposing (TextField)


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
    Element.column [ Element.spacing 20 ]
        [ TextField.new "Filled" (OnChange "filled") (inputText "filled" model)
            |> TextField.onFocusBlur (OnFocus "filled") (OnLoseFocus "filled")
            |> TextField.withFocused (inputHasFocus "filled" model)
            |> TextField.withSupportingText "A filled text field"
            |> TextField.withType TextField.Filled
            |> Material.renderTextField theme [ Element.centerX, Element.centerY ]
        , TextField.new "Filled" (OnChange "filledLeadIcon") (inputText "filledLeadIcon" model)
            |> TextField.onFocusBlur (OnFocus "filledLeadIcon") (OnLoseFocus "filledLeadIcon")
            |> TextField.withFocused (inputHasFocus "filledLeadIcon" model)
            |> TextField.withSupportingText "A filled text field with leading icon"
            |> TextField.withLeadingIcon check
            |> TextField.withType TextField.Filled
            |> Material.renderTextField theme [ Element.centerX, Element.centerY ]
        , TextField.new "Filled" (OnChange "filledTrailIcon") (inputText "filledTrailIcon" model)
            |> TextField.onFocusBlur (OnFocus "filledTrailIcon") (OnLoseFocus "filledTrailIcon")
            |> TextField.withFocused (inputHasFocus "filledTrailIcon" model)
            |> TextField.withSupportingText "A filled text field with trailing icon"
            |> TextField.withTrailingIcon clear
            |> TextField.withType TextField.Filled
            |> Material.renderTextField theme [ Element.centerX, Element.centerY ]
        , TextField.new "Filled" (OnChange "filledError") (inputText "filledError" model)
            |> TextField.onFocusBlur (OnFocus "filledError") (OnLoseFocus "filledError")
            |> TextField.withFocused (inputHasFocus "filledError" model)
            |> TextField.withSupportingText "A filled text field with error"
            |> TextField.withType TextField.Filled
            |> TextField.withColor OUI.Error
            |> Material.renderTextField theme [ Element.centerX, Element.centerY ]
        , TextField.new "Outlined" (OnChange "outlined") (inputText "outlined" model)
            |> TextField.onFocusBlur (OnFocus "outlined") (OnLoseFocus "outlined")
            |> TextField.withFocused (inputHasFocus "outlined" model)
            |> TextField.withType TextField.Outlined
            |> TextField.withSupportingText "A outlined text field"
            |> Material.renderTextField theme [ Element.centerX, Element.centerY ]
        , TextField.new "Outlined" (OnChange "outlinedLeadIcon") (inputText "outlinedLeadIcon" model)
            |> TextField.onFocusBlur (OnFocus "outlinedLeadIcon") (OnLoseFocus "outlinedLeadIcon")
            |> TextField.withFocused (inputHasFocus "outlinedLeadIcon" model)
            |> TextField.withSupportingText "A outlined text field with leading icon"
            |> TextField.withLeadingIcon check
            |> TextField.withType TextField.Outlined
            |> Material.renderTextField theme [ Element.centerX, Element.centerY ]
        , TextField.new "Outlined" (OnChange "outlinedTrailIcon") (inputText "outlinedTrailIcon" model)
            |> TextField.onFocusBlur (OnFocus "outlinedTrailIcon") (OnLoseFocus "outlinedTrailIcon")
            |> TextField.withFocused (inputHasFocus "outlinedTrailIcon" model)
            |> TextField.withSupportingText "A outlined text field with trailing icon"
            |> TextField.withTrailingIcon clear
            |> TextField.withType TextField.Outlined
            |> Material.renderTextField theme [ Element.centerX, Element.centerY ]
        , TextField.new "Outlined" (OnChange "outlinedError") (inputText "outlinedError" model)
            |> TextField.onFocusBlur (OnFocus "outlinedError") (OnLoseFocus "outlinedError")
            |> TextField.withFocused (inputHasFocus "outlinedError" model)
            |> TextField.withSupportingText "A outlined text field with error"
            |> TextField.withType TextField.Outlined
            |> TextField.withColor OUI.Error
            |> Material.renderTextField theme [ Element.centerX, Element.centerY ]
        ]
        |> Element.map Explorer.bookMsg
