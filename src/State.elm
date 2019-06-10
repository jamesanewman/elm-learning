module State exposing (..)

import Model exposing (..)
import Models.Game exposing (..)
import Models.State exposing (..)
import Game exposing (..)


update: Msg -> Model -> Model
update msg model =
    case msg of 
        -- Player ends his turn set up next turn
        NextTurn ->
            incrementTurn model

        _ -> 
            model 



