Elm Orus UI
===========


Elm Orus UI is a UI toolkit for elm, modeled after the [Material Design
system](https://m3.material.io/).

It renders to
[Elm-UI](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/) views
but could probably be extended to generate HTML ones.

Examples of all the widgets can be found in the 
[Showcase](https://elm.orus.io/elm-orus-ui/showcase/). This showcase is based
on Elm Orus UI Explorer, and can be personalised and extended to browse your
own components.



Add a component
---------------

This is a list of all the files that need to be added/changed when creating a
new component:

- Create a component module in OUI/MyComponent.elm
- Add a Material renderer in OUI/Material/MyComponent.elm
- Add the theme to OUI/Material/Theme.elm
- Add render function in OUI/Material.elm
- Add a showcase book in OUI/Showcase/MyComponent.elm
- Add the book to the default showcase in OUI/Showcase.elm
