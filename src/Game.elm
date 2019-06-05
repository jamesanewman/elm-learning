module Game exposing (..)

import Modifiers exposing(..)
import Cards exposing(..)


type alias Player = 
    {
        name: String,
        deck: Deck,
        hand: Hand,
        activeCards: ActiveCards,
        graveyard: Graveyard
    }


type GameState = 
    PLAYER1TURN |
    PLAYER2TURN |
    GAMEOVER

type CurrentPlayer = PLAYER1 | PLAYER2
type Attacker = 
    CARD Card
    | NONE

type alias Model = 
    {
        player1: Player,
        player2: Player,

        turn: Int,
        currentPlayer: CurrentPlayer,
        state: GameState,

        attacker: Attacker

    }



incrementTurn: Model -> Model 
incrementTurn model = 
    { model | turn = (model.turn + 1)}

swapCurrentPlayer: Model -> Model 
swapCurrentPlayer model = 
    case model.currentPlayer of 
        PLAYER1 -> 
            { model | currentPlayer = PLAYER2 }
        PLAYER2 -> 
            { model | currentPlayer = PLAYER1 }

endTurn: Model -> Model
endTurn model = 
    incrementTurn model 
    |> swapCurrentPlayer 

