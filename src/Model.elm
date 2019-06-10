module Model exposing (..)

type Msg = NextTurn | BOB

type alias Model = 
    {
        metadata: Metadata,
        players: (Player, Player),
        attacker: CurrentAttacker

    }

type alias ViewConfig = 
    {
        title: String,
        width: String,
        height: String
    }

{--

Player

--}

-- The actual player info
type alias PlayerInfo = 
    {
        name: String,
        deck: Deck
    }
-- This is a game player
type alias Player =
    {
        info: PlayerInfo,
        health: Int,
        hand: Hand,        
        active: ActiveCards,
        graveyard: Graveyard
    }

{--
Card
--}
type alias Deck = List Card
type alias Hand = List Card
type alias Graveyard = List Card
type alias ActiveCards = List Card

type alias Card = 
    {
        -- Added by game ?  Makes it easier to find, 
        -- Perhaps we need a better way to think about certain actions then
        id: Int,
        name: String,
        health: Int,
        attack: Int
    }

{-- 
Metadata: 
--}
type CurrentAttacker = FirstPlayer | SecondPlayer
type alias Metadata = 
    {
        turn: Int
    }

getMetadata: Model -> Metadata
getMetadata model = 
    model.metadata 

updateMetadata: Model -> Metadata -> Model 
updateMetadata model metadata =
    { model | metadata = metadata }

