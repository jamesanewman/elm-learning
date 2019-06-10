module Models.Game exposing (..)

import Model exposing (..)
import Models.State exposing (..)
{--
    Add some low level model helpers.
--}

{--
This could be improved with a bit more info stored in the
state but lets see
--}   

incrementTurn: Model -> Model 
incrementTurn model = 
    let
        metadata = getMetadata model
        nextTurn = (+) (getTurn model) 1
    in
        { metadata | turn = nextTurn }
        |> updateMetadata model 
        |> switchAttacker


switchAttacker: Model -> Model
switchAttacker model =
    case model.attacker of 
        FirstPlayer ->
            { model | attacker = SecondPlayer }
        
        SecondPlayer ->
            { model | attacker = FirstPlayer }

getAttacker: Model -> Player
getAttacker model =
    case model.attacker of 
        FirstPlayer ->
            Tuple.first model.players

        SecondPlayer ->
            Tuple.second model.players



getDefender: Model -> Player
getDefender model =
    case model.attacker of 
        FirstPlayer ->
            Tuple.second model.players

        SecondPlayer ->
            Tuple.first model.players


isAttacker: Model -> Player -> Bool
isAttacker model player =
    getAttacker model
        |> (==) player