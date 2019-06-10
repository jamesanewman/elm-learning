module Models.State exposing (..)

import Model exposing (..)


{--
    Add some low level model helpers.
--}


getTurn: Model -> Int 
getTurn model = 
    let
        metadata = getMetadata model
    in
        metadata.turn

