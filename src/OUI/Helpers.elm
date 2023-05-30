module OUI.Helpers exposing (onOutsideClick)

import Browser.Events exposing (onMouseDown)
import Json.Decode as Decode


isOutsideDropdown : String -> Decode.Decoder Bool
isOutsideDropdown elementId =
    Decode.oneOf
        [ Decode.field "id" Decode.string
            |> Decode.andThen
                (\id ->
                    if elementId == id then
                        Decode.succeed False

                    else
                        Decode.fail "continue"
                )
        , Decode.lazy (\_ -> isOutsideDropdown elementId |> Decode.field "parentNode")
        , Decode.succeed True
        ]


{-| Emits the internal event 'OnClickOutside' and closes the multi select dropdown, works well with subscriptions. Takes:

  - dropdownId: Id of the HTML element from which you want to be notified whenever it is clicked outside!

  - dropdownMsg: The message to wrap all the internal messages of the dropdown

```
subscriptions : Model -> Sub Msg
subscriptions model =
    onMouseDown (Dropdown.outsideTarget "my-dropdown" DropdownMsg)
```

-}
outsideTarget : String -> msg -> Decode.Decoder msg
outsideTarget dropdownId msg =
    Decode.field "target" (isOutsideDropdown dropdownId)
        |> Decode.andThen
            (\isOutside ->
                if isOutside then
                    Decode.succeed msg

                else
                    Decode.fail "inside dropdown"
            )


{-| Serves as a subscription to know when the user has clicked outside a certain dropdown

  - dropdownState: State of the dropdown we want to subscribe to

  - dropdownMsg: The message to wrap all the internal messages of the dropdown

```
subscriptions : Model -> Sub Msg
subscriptions model =
    Dropdown.onOutsideClick model.dropdownState DropdownMsg
```

-}
onOutsideClick : String -> msg -> Sub msg
onOutsideClick id dropdownMsg =
    onMouseDown (outsideTarget id dropdownMsg)
