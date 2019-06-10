module Views.Footer exposing (..)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import Model exposing (..)


footer: ViewConfig -> Model -> Html Msg
footer vconfig model =
    div 
        [
            style "position" "absolute",
            style "background-color" "rgba(100,100,200,0.2)",
            style "height" "100px",
            style "width" "100%",
            style "bottom" "0px",
            style "text-align" "center"
        ] 
        [
            nextTurnButton
        ]


nextTurnButton: Html Msg 
nextTurnButton = 
    button [ onClick NextTurn ] [ text "Next Turn" ]