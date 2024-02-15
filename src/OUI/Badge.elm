module OUI.Badge exposing (Badge(..), label, number, small)


type Badge
    = Small
    | Label String
    | Number Int


small : Badge
small =
    Small


label : String -> Badge
label =
    Label


number : Int -> Badge
number =
    Number
