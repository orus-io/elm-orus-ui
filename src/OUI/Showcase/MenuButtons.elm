module OUI.Showcase.MenuButtons exposing (Model, Msg, book)

import Dict exposing (Dict)
import Effect exposing (Effect)
import Element
import OUI.Button as Button exposing (Button)
import OUI.Explorer as Explorer exposing (Explorer)
import OUI.Helpers
import OUI.Icon
import OUI.Material
import OUI.Menu as Menu
import OUI.MenuButton as MenuButton


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Menu Buttons"
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
        |> Explorer.withChapter chapter


chapter shared model =
    let
        menu1State =
            Dict.get "menu1" model.menuState |> Maybe.withDefault MenuButton.initialState
    in
    MenuButton.new "menu1"
        (Button.new
            "click me"
            |> Button.outlinedButton
            |> Button.onClick (OnMenuOpened "menu1" (not menu1State))
        )
        (Menu.new identity
            |> Menu.withItems [ "One", "Two", "Three" ]
            |> Menu.withIcon
                (\i ->
                    if i /= "Two" then
                        Just OUI.Icon.check

                    else
                        Nothing
                )
        )
        |> MenuButton.withState menu1State
        |> OUI.Material.menuButton shared.theme []
        |> Element.map Explorer.bookMsg


type alias Model =
    { menuState : Dict String MenuButton.State
    }


type Msg
    = OnMenuOpened String Bool
    | OnSelect String (Maybe String)


init : Explorer.Shared themeExt -> ( Model, Effect Explorer.SharedMsg Msg )
init _ =
    ( { menuState = Dict.empty }, Effect.none )


subscriptions : Explorer.Shared themeExt -> Model -> Sub Msg
subscriptions _ _ =
    OUI.Helpers.onOutsideClick "menu1" (OnMenuOpened "menu1" False)


update : Explorer.Shared themeExt -> Msg -> Model -> ( Model, Effect Explorer.SharedMsg Msg )
update _ msg model =
    case msg of
        OnMenuOpened id value ->
            { model
                | menuState =
                    Dict.insert id value model.menuState
            }
                |> Effect.withNone

        OnSelect id _ ->
            { model
                | menuState =
                    Dict.insert id False model.menuState
            }
                |> Effect.withNone
