module OUI.Showcase.TimePickers exposing (..)

import Effect exposing (Effect)
import Element exposing (Element)
import OUI.Explorer as Explorer
import OUI.Material
import OUI.TimePicker


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Time pickers"
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
        |> Explorer.withChapter input
        |> Explorer.withChapter dial


type alias Model =
    { inputState : OUI.TimePicker.State
    , dialState : OUI.TimePicker.State
    }


type Msg
    = InputMsg OUI.TimePicker.Msg
    | UpdateDialState OUI.TimePicker.Msg


init : Explorer.Shared themeExt -> ( Model, Effect Explorer.SharedMsg Msg )
init shared =
    { inputState = OUI.TimePicker.initState
    , dialState = OUI.TimePicker.initState
    }
        |> Effect.withNone


update : Explorer.Shared themeExt -> Msg -> Model -> ( Model, Effect Explorer.SharedMsg Msg )
update _ msg model =
    model
        |> Effect.withNone


subscriptions : Explorer.Shared themeExt -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


input : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
input shared model =
    OUI.TimePicker.new
        |> OUI.Material.timepicker shared.theme model.inputState []


dial : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
dial shared model =
    OUI.TimePicker.new
        |> OUI.Material.timepicker shared.theme model.dialState []
