module Views.Player exposing (..)

import Html exposing (Html, div, text, h2)
import Html.Attributes exposing (style)
import Model exposing (..)

playerView: ViewConfig -> Bool -> Player -> Html Msg 
playerView vconfig isActive player =
    let 
        borderColor = 
            case isActive of
                True ->
                    "red"
                False ->
                    "green"
    in
        div [
                style "border" ("1px solid " ++ borderColor)
            ] 
            [
                h2 [] [ text player.info.name ]
                
            ]
