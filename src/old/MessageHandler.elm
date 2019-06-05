module MessageHandler exposing (..)

-- Models.Models - Looks in subdirectory
-- This should be relative to the /src directory, not this file
import Models.Models exposing (..)
{--

This is the dispatch table that handles messages from the UI and routes 
them to the game.

Interesting, makes sense but I missed it.  Msg = XX | YY.  If I expose Msg I don't get XX or YY.
This makes sense because they are different things but was unexpected.
--}

dispatchTable: Msg -> Model -> Model
dispatchTable msg model =
    let
        x = 1
    in
        case msg of 

            DO_SOMETHING ->
                model

            _ -> 
                model