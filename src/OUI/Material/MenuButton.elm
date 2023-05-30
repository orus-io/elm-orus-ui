module OUI.Material.MenuButton exposing (render)

import Element exposing (Attribute, Element)
import Html.Attributes
import OUI.Material.Button as Button
import OUI.Material.Color exposing (Scheme)
import OUI.Material.Menu as Menu
import OUI.Material.Typography exposing (Typescale)
import OUI.MenuButton exposing (MenuButton)


render :
    Typescale
    -> Scheme
    -> Button.Theme
    -> Menu.Theme
    -> List (Attribute msg)
    -> MenuButton btnC item msg
    -> Element msg
render typescale colorscheme buttonTheme menuTheme attrs menuBtn =
    let
        props =
            OUI.MenuButton.properties menuBtn
    in
    Button.render typescale
        colorscheme
        buttonTheme
        (Element.htmlAttribute (Html.Attributes.id props.id)
            :: attrs
            ++ (if props.state then
                    [ Element.below
                        (Menu.render typescale
                            colorscheme
                            menuTheme
                            [ Element.moveDown 1
                            ]
                            props.menu
                        )
                    ]

                else
                    []
               )
        )
        props.button
