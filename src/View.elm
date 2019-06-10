module View exposing (..)

import Html exposing (Html, button, div, text, h2, textarea, p , hr)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, attribute, draggable)

import Views.Header exposing (header)
import Views.Footer exposing (footer)
import Views.Player exposing (playerView)
import Views.CardsField exposing (cardsView)

import Model exposing (..)
import Models.Game exposing (..)
import Models.State exposing (..)
{--

TODO: This needs to get cleaned up and separated

--}


view: ViewConfig -> Model -> Html Msg 
view vconfig model =
    div 
        [
            style "position" "relative",
            style "border" "1px solid black",
            style "width" vconfig.height,
            style "height" vconfig.height
        ] 
        [ 
            div 
                [
                    style "display" "inline-block",
                    style "outline" "1px solid black",
                    style "width" "70%",
                    style "height" "100%"
                ] 
                [ 
                    header vconfig model,
                    mainPanel vconfig model,
                    footer vconfig model
                ],
            div 
                [
                    -- style "display" "inline-block",
                    style "float" "right",
                    style "outline" "1px solid black",
                    style "width" "30%",
                    style "height" "100%"
                ] 
                [ 
                    p 
                        []
                        [
                            text ("Turn: " ++ (String.fromInt (getTurn model)))
                        ]
                ]
        ]

mainPanel: ViewConfig -> Model -> Html Msg
mainPanel vconfig model =
    let 
        player1 = Tuple.first model.players
        player2 = Tuple.second model.players
        playerDisplay = playerView vconfig
    in
        div 
            [
                style "background-color" "rgba(200,100,100,0.2)"
                -- style "position" "relative",
                -- style "top" headerSize
            ]
            [

                playerDisplay (isAttacker model player1) player1,
                cardsView vconfig player1.active,

                hr [] [],

                cardsView vconfig player2.active,
                playerDisplay (isAttacker model player2) player2
            ]

