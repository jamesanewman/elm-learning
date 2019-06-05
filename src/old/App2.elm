import Browser
import Models.Model exposing (..)
import Components.Screen exposing (..)
import State.Update exposing (..)

{-- 

Bring it all together.

I think the split should be more

- game
  - model.elm 
  - update.elm
  - view.elm 

lets see how it goes and move around later

--}


update: Msg -> Model -> Model 
update msg model = 
    case msg of 
        _ ->
            model 
            
main =
  Browser.sandbox 
    { 
        init = startModel
        , update = update
        , view = mainDisplay 
    }
