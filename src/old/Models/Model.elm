module Models.Model exposing (..)

{--

The various types that I will create for the system.

Any the getters and setters that go with them, no functional code outside of updating 
various model fields and understanding how to navigate the model.  So if something
doesn't work the changes go in here.  

So currently I understand the models to be:-
- The data structures
- setters and getters to go with the structure


This makes it nice to have a file for each high level Model field. To reduce
complexity and size in the file.

--}

import Models.UI exposing (..)
import Models.Game exposing (..)



startModel: Model
startModel = 
    {
        game = 
            {

            },
        ui = 
            {
                title = "Elm Test"
            }
    }


type alias Model = 
    {
        game: GameState,
        ui: UIState
    }


type Msg = DO_SOMETHING | XXX

{--
    Update the top level model fields
--}
updateGameModel: GameState -> Model -> Model 
updateGameModel game model =
    { model | game = game }
    
updateUIModel: UIState -> Model -> Model 
updateUIModel ui model =
    { model | ui = ui }
