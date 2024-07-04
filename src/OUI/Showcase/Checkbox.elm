module OUI.Showcase.Checkbox exposing (Model, Msg, book)

import Effect exposing (Effect)
import Element exposing (Element)
import OUI
import OUI.Checkbox as Checkbox
import OUI.Divider as Divider
import OUI.Explorer as Explorer
import OUI.Icon exposing (clear)
import OUI.Material as Material
import OUI.Text as Text


type alias Model =
    { basicCheck : Bool
    , basicUncheck : Bool
    , customIconCheck : Bool
    , customIconUncheck : Bool
    , errorCheck : Bool
    , errorUncheck : Bool
    }


type Msg
    = OnClickBasicCheck
    | OnClickBasicUncheck
    | OnClickCustomIconCheck
    | OnClickCustomIconUncheck
    | OnClickErrorCheck
    | OnClickErrorUncheck


init : Model
init =
    { basicCheck = True
    , basicUncheck = False
    , customIconCheck = True
    , customIconUncheck = False
    , errorCheck = True
    , errorUncheck = False
    }


update : Explorer.Shared themeExt -> Msg -> Model -> ( Model, Effect shared msg )
update _ msg model =
    case msg of
        OnClickBasicCheck ->
            { model | basicCheck = not model.basicCheck }
                |> Effect.withNone

        OnClickBasicUncheck ->
            { model | basicUncheck = not model.basicUncheck }
                |> Effect.withNone

        OnClickCustomIconCheck ->
            { model | customIconCheck = not model.customIconCheck }
                |> Effect.withNone

        OnClickCustomIconUncheck ->
            { model | customIconUncheck = not model.customIconUncheck }
                |> Effect.withNone

        OnClickErrorCheck ->
            { model | errorCheck = not model.errorCheck }
                |> Effect.withNone

        OnClickErrorUncheck ->
            { model | errorUncheck = not model.errorUncheck }
                |> Effect.withNone


book : Explorer.Book themeExt Model Msg
book =
    Explorer.statefulBook "Checkbox"
        { init = \_ -> init |> Effect.withNone
        , update = update
        , subscriptions = \_ _ -> Sub.none
        }
        |> Explorer.withChapter checkbox


checkbox : Explorer.Shared themeExt -> Model -> Element (Explorer.BookMsg Msg)
checkbox { theme } model =
    let
        divider : Element msg
        divider =
            Divider.new |> Material.divider theme []
    in
    Element.column [ Element.spacing 30 ]
        [ divider
        , Element.row [ Element.spacing 30, Element.padding 30 ]
            [ Element.column [ Element.spacing 55, Element.padding 30 ]
                [ Element.none |> Element.el []
                , Text.titleSmall "Basic" |> Material.text theme
                , Text.titleSmall "Disabled" |> Material.text theme
                , Text.titleSmall "Custom Icon" |> Material.text theme
                , Text.titleSmall "Error" |> Material.text theme
                ]
            , Element.column [ Element.spacing 30 ]
                [ Text.titleSmall "Unchecked" |> Material.text theme
                , Checkbox.new
                    |> Checkbox.onChange (\_ -> OnClickBasicUncheck)
                    |> Checkbox.withChecked model.basicUncheck
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.disabled
                    |> Checkbox.withChecked False
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.onChange (\_ -> OnClickCustomIconUncheck)
                    |> Checkbox.withChecked model.customIconUncheck
                    |> Checkbox.withIcon clear
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.onChange (\_ -> OnClickErrorUncheck)
                    |> Checkbox.withChecked model.errorUncheck
                    |> Checkbox.withColor OUI.Error
                    |> Material.checkbox theme []
                ]
            , Element.column [ Element.spacing 30 ]
                [ Text.titleSmall "Checked" |> Material.text theme
                , Checkbox.new
                    |> Checkbox.onChange (\_ -> OnClickBasicCheck)
                    |> Checkbox.withChecked model.basicCheck
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.disabled
                    |> Checkbox.withChecked True
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.onChange (\_ -> OnClickCustomIconCheck)
                    |> Checkbox.withChecked model.customIconCheck
                    |> Checkbox.withIcon clear
                    |> Material.checkbox theme []
                , Checkbox.new
                    |> Checkbox.onChange (\_ -> OnClickErrorCheck)
                    |> Checkbox.withChecked model.errorCheck
                    |> Checkbox.withColor OUI.Error
                    |> Material.checkbox theme []
                ]
            ]
        ]
        |> Element.map Explorer.bookMsg
