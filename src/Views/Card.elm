module Views.Card exposing (..)

import Html exposing (Html, div, text, h2, p)
import Html.Attributes exposing (style)
import Model exposing (..)

cardView: ViewConfig -> Card -> Html Msg
cardView vconfig card = 
    div 
        [
            style "display" "inline-block",
            style "margin" "5px",
            style "outline" "1px solid blue"
        ]
        [
            div 
                []
                [
                    text card.name
                ],

            div 
                []
                [
                    p [] [ displayField ("Health", card.health) ],
                    p [] [ displayField ("Attack", card.attack) ]
                ]
        ]


displayField (prefix, value) =
    text (prefix ++ ": " ++ (String.fromInt value))