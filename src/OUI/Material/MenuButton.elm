module OUI.Material.MenuButton exposing (render)

import Element exposing (Attribute, Element)
import Html.Attributes
import OUI.Button
import OUI.Material.Button as Button
import OUI.Material.Color exposing (Scheme)
import OUI.Material.Menu as Menu
import OUI.Material.Typography exposing (Typescale)
import OUI.Menu
import OUI.MenuButton exposing (MenuButton)


render :
    Typescale
    -> Scheme
    -> Button.Theme
    -> Menu.Theme
    -> OUI.MenuButton.State
    -> List (Attribute msg)
    -> MenuButton btnC item msg
    -> Element msg
render typescale colorscheme buttonTheme menuTheme state attrs menuBtn =
    let
        props :
            { button : OUI.Button.Button { btnC | hasAction : () } msg
            , menu : OUI.Menu.Menu item msg
            , menuAlign : OUI.MenuButton.Align
            }
        props =
            OUI.MenuButton.properties menuBtn
    in
    Button.render typescale
        colorscheme
        buttonTheme
        (Element.htmlAttribute (Html.Attributes.id state.id)
            :: attrs
            ++ (if state.opened then
                    [ Element.below
                        (Menu.render typescale
                            colorscheme
                            menuTheme
                            [ Element.moveDown 1
                            , case props.menuAlign of
                                OUI.MenuButton.AlignLeft ->
                                    Element.alignLeft

                                OUI.MenuButton.AlignRight ->
                                    Element.alignRight
                            ]
                            props.menu
                        )
                    ]

                else
                    []
               )
        )
        props.button
