module OUI.Element exposing (Modal, singleModal, multiModal, mapModal)

{-| Utilities for Elm-UI


# Modals

This modal API is taken from
[Orasund/elm-ui-widgets](https://package.elm-lang.org/packages/Orasund/elm-ui-widgets/latest/)

@docs Modal, singleModal, multiModal, mapModal

-}

import Element exposing (Attribute, Element)
import Element.Background as Background
import Element.Events as Events


{-| -}
type alias Modal msg =
    { onDismiss : Maybe msg
    , content : Element msg
    }


{-| map a Modal
-}
mapModal : (a -> b) -> Modal a -> Modal b
mapModal f modal =
    { onDismiss = Maybe.map f modal.onDismiss
    , content = Element.map f modal.content
    }


modalBackground : Maybe msg -> List (Attribute msg)
modalBackground onDismiss =
    [ Element.none
        |> Element.el
            ([ Element.width <| Element.fill
             , Element.height <| Element.fill
             , Background.color <| Element.rgba255 0 0 0 0.5
             ]
                ++ (onDismiss
                        |> Maybe.map (Events.onClick >> List.singleton)
                        |> Maybe.withDefault []
                   )
            )
        |> Element.inFront
    , Element.clip
    ]


{-| A modal showing a single element.

Material design only allows one element at a time to be viewed as a modal.
To make things easier, this widget only views the first element of the list.
This way you can see the list as a queue of modals.

    import Element

    type Msg
        = Close

    Element.layout
        (singleModal
            [ { onDismiss = Just Close
              , content =
                  Element.text "Click outside this window to close it."
              }
            ]
        )
        |> always "Ignore this line" --> "Ignore this line"

Technical Remark:

  - To stop the screen from scrolling, set the height of the layout to the height of the screen.

-}
singleModal : List (Modal msg) -> List (Attribute msg)
singleModal =
    List.head
        >> Maybe.map
            (\{ onDismiss, content } ->
                modalBackground onDismiss ++ [ content |> Element.inFront ]
            )
        >> Maybe.withDefault []


{-| Same implementation as `singleModal` but also displays the "queued" modals.

    import Element

    type Msg
        = Close

    Element.layout
        (multiModal
            [ { onDismiss = Just Close
              , content =
                  Element.text "Click outside this window to close it."
              }
            ]
        )
        |> always "Ignore this line" --> "Ignore this line"

-}
multiModal : List (Modal msg) -> List (Attribute msg)
multiModal list =
    case list of
        head :: tail ->
            (tail
                |> List.reverse
                |> List.map (\{ content } -> content |> Element.inFront)
            )
                ++ modalBackground head.onDismiss
                ++ [ head.content |> Element.inFront ]

        _ ->
            []
