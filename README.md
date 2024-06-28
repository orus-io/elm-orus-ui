# Elm Orus UI


Elm Orus UI is a UI toolkit for elm, modeled after the [Material Design
system](https://m3.material.io/).

It renders to
[Elm-UI](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/)
elements but could probably be extended to generate HTML ones.

[See it live on the showcase](https://elm.orus.io/elm-orus-ui/showcase/)!

## Example

This small piece of code show how to create a simple 'OK' button

```elm
import Element exposing (Element)
import OUI.Button as Button
import OUI.Material as Material
import OUI.Material.Color
import OUI.Material.Theme

theme =
    OUI.Material.Theme.defaultTheme
    |> OUI.Material.Theme.withColorscheme OUI.Material.Color.defaultDarkTheme

view : Element msg
view =
    Button.new "OK"
        |> Button.onClick OnBtnClick
        |> Material.button theme [ {- any Element.Attribute -} ]

```

## Customize colors

A fully custom color scheme is possible, but the simplest is to build schemes
based a a few key colors.

```elm
import OUI.Material.Color as Color

darkScheme : Color.Scheme
darkScheme =
    Color.darkFromKeyColors
        { primary = Color.rgb255 0x67 0x50 0xA4
        , secondary = Color.rgb255 0x62 0x5B 0x71
        , tertiary = Color.rgb255 0x7D 0x52 0x60
        , error = Color.rgb255 0xB3 0x26 0x1E
        , neutral = Color.rgb255 0x40 0x40 0x40
        , neutralVariant = Color.rgb255 0x40 0x40 0x40
        }
```

## Customize theme

Each component has a restricted set of possible customization.

For example, here is how to make buttons higher and more square:

```elm
import OUI.Material.Theme as Theme

customTheme =
    let
        buttonTheme =
            Theme.button Theme.defaultTheme
    in
    Theme.defaultTheme
        |> Theme.withButton 
            { buttonTheme
                | common =
                    { containerHeight = 50
                    , containerRadius = 4
                    , iconSize = buttonTheme.common.iconSize
                    , leftRightPadding = buttonTheme.common.leftRightPadding
                    , leftPaddingWithIcon = buttonTheme.common.leftPaddingWithIcon
                    , rightPaddingWithIcon = buttonTheme.common.rightPaddingWithIcon
                    , paddingBetweenElements = buttonTheme.common.paddingBetweenElements
                    , textSize = buttonTheme.common.textSize
                    , textType = buttonTheme.common.textType
                    }
                , icon =
                    { iconSize = buttonTheme.icon.iconSize
                    , containerSize = buttonTheme.icon.containerSize
                    }
            }
```

