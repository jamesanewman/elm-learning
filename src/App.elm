import Browser
import Model exposing (..)
import Game exposing (..)
import View exposing (..)
import State exposing (..)

{--

App <- 
  Update <- model, game
  View <- model
  Game <- model

  Utils + possibly a couple of utility funcs to help at each level.
--}

viewConfig: ViewConfig
viewConfig = 
  {
    title = "Elm Tests",
    width = "600px",
    height = "800px"
  }

player1: PlayerInfo
player1 = 
  {
    name = "Player 1",
    deck = 
      [ 

      ]
  }

player2: PlayerInfo
player2 = 
  {
    name = "Player 2",
    deck = [ 
      ]
  }



startModel: Model
startModel = 
  {
    metadata = 
      {
        turn = 1
      },
      attacker = FirstPlayer,
      players = 
        (
          {
            info = player1,
            health = 100,
            hand = [],
            active = 
              [
                { id= 1, name = "Card 1", health = 100, attack = 110}
                ,{ id= 2, name = "Card 2", health = 100, attack = 110}
              ],
              graveyard = []
          }, 
          {
            info = player2,
            health = 100,
            hand = [],
            active = 
              [
                { id= 1, name = "Card 3", health = 90, attack = 150}
                ,{ id= 2, name = "Card 4", health = 80, attack = 150}
              ],
              graveyard = []
          }
        )
  }

main =
  Browser.sandbox 
    { 
      init = startModel, 
      update = update, 
      view = view viewConfig
    }

