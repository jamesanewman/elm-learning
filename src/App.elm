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

  }

startModel: Model
startModel = 
  {

  }

main =
  Browser.sandbox 
    { 
      init = startModel, 
      update = update, 
      view = view viewConfig
    }

