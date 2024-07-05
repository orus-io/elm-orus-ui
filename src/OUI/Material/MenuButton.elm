module OUI.Material.MenuButton exposing (render)

import Element exposing (Attribute, Element, alignBottom)
import Element.Events
import Html.Attributes
import Html.Events
import Json.Decode as Decode
import OUI.Button
import OUI.Icon exposing (Icon)
import OUI.Material.Button as Button
import OUI.Material.Color exposing (Scheme)
import OUI.Material.Divider as Divider
import OUI.Material.Menu as Menu
import OUI.Material.Typography exposing (Typescale)
import OUI.Menu
import OUI.MenuButton exposing (MenuButton)


render :
    Typescale
    -> Scheme
    -> Button.Theme
    -> Divider.Theme
    -> Menu.Theme
    -> OUI.MenuButton.State
    -> List (Attribute msg)
    -> MenuButton btnC item msg
    -> Element msg
render typescale colorscheme buttonTheme dividerTheme menuTheme state attrs menuBtn =
    let
        props :
            { button : OUI.Button.Button { btnC | hasAction : () } msg
            , menu : OUI.Menu.Menu item msg
            , menuAlign : OUI.MenuButton.Align
            , onKeyDown : OUI.MenuButton.Key -> msg
            , onLoseFocus : msg
            , openCloseIcons : Maybe ( Icon, Icon )
            }
        props =
            { button = OUI.MenuButton.getButton menuBtn
            , menu = OUI.MenuButton.getMenu menuBtn
            , menuAlign = OUI.MenuButton.getMenuAlign menuBtn
            , onKeyDown = OUI.MenuButton.getOnKeyDown menuBtn
            , onLoseFocus = OUI.MenuButton.getOnLoseFocus menuBtn
            , openCloseIcons = OUI.MenuButton.getOpenCloseIcons menuBtn
            }

        ( alignBottom, alignRight ) =
            case props.menuAlign of
                OUI.MenuButton.AlignTopLeft ->
                    ( False, False )

                OUI.MenuButton.AlignTopRight ->
                    ( False, True )

                OUI.MenuButton.AlignBottomLeft ->
                    ( True, False )

                OUI.MenuButton.AlignBottomRight ->
                    ( True, True )
    in
    Button.render typescale
        colorscheme
        buttonTheme
        (props.openCloseIcons
            |> Maybe.map
                (\( open, close ) ->
                    if state.opened then
                        close

                    else
                        open
                )
        )
        (Element.htmlAttribute (Html.Attributes.id state.id)
            :: Element.Events.onLoseFocus props.onLoseFocus
            :: attrs
            ++ (if state.opened then
                    [ (if alignBottom then
                        Element.below

                       else
                        Element.above
                      )
                        (Menu.render typescale
                            colorscheme
                            dividerTheme
                            menuTheme
                            state.highlighted
                            [ Element.moveDown 1
                            , if alignRight then
                                Element.alignRight

                              else
                                Element.alignLeft
                            ]
                            props.menu
                        )
                    , onKeyDown props.onKeyDown
                    ]

                else
                    []
               )
        )
        props.button


onKeyDown : (OUI.MenuButton.Key -> msg) -> Attribute msg
onKeyDown msg =
    let
        stringToKey : String -> Decode.Decoder OUI.MenuButton.Key
        stringToKey str =
            case str of
                "ArrowDown" ->
                    Decode.succeed OUI.MenuButton.ArrowDown

                "ArrowUp" ->
                    Decode.succeed OUI.MenuButton.ArrowUp

                "Enter" ->
                    Decode.succeed OUI.MenuButton.Enter

                "Escape" ->
                    Decode.succeed OUI.MenuButton.Esc

                _ ->
                    Decode.fail "not used key"

        keyDecoder : Decode.Decoder OUI.MenuButton.Key
        keyDecoder =
            Decode.field "key" Decode.string
                |> Decode.andThen stringToKey
    in
    Html.Events.on "keydown" (Decode.map msg keyDecoder)
        |> Element.htmlAttribute
