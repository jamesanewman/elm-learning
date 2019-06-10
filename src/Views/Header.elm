module Views.Header exposing (..)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Model exposing (..)

header: ViewConfig -> Model -> Html Msg
header vconfig model =
    div 
        [
            style "background-color" "rgba(100,100,100,0.2)",
            style "height" "100px"
        ] 
        [
            div
                [
                    style "text-align" "center"
                ]
                [
                    text vconfig.title
                ]
        ]