import Browser
import Html exposing (Html, button, div, text, h2, textarea, p , hr)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, attribute, draggable)
import Game exposing (..)
import Modifiers exposing(..)
import Cards exposing(..)
import Drag exposing (..)

cardNameTo: Card -> String -> Card 
cardNameTo card name = 
    { card | name = name }

player1 =
    {
        name = "Player 1",
        deck = [],
        hand = [],
        activeCards = [card1, card2],
        graveyard = []
    }
player2 =
    {
        name = "Player 2",
        deck = [],
        hand = [],
        activeCards = [card1],
        graveyard = []
    }

startModel: Model 
startModel = 
    {
        player1 = player1,
        player2 = player2,
        turn = 1,
        state = PLAYER1TURN,
        currentPlayer = PLAYER1,
        attacker = NONE
    }

main =
  Browser.sandbox { init = startModel, update = update, view = view }


type Msg = 
    EndTurn 
    | Attack Card Card
    | Drag Card 
    | DroppedOn Card 
    | DraggedOver Card
    | DragEnd


ignoreSecondParam: a -> b -> a 
ignoreSecondParam x _ = x

logAndIgnore: a -> String -> b -> a 
logAndIgnore x str o =
    Debug.log str o
    |> ignoreSecondParam x 

setAttacker: Attacker -> Model -> Model
setAttacker attacker model =
    {model | attacker = attacker}

replaceIfTheSame: Card -> Card -> Card
replaceIfTheSame new original = 
    case original.id == new.id of 
        True ->
            new 
        False ->
            original

replaceCard: List Card -> Card -> List Card 
replaceCard cards card =
    let
        replaceMatchingCard = replaceIfTheSame card
    in
        List.map replaceMatchingCard cards
    
updateDefenderCard: Player -> Card -> Player
updateDefenderCard defender updatedCard =
    let
        updatedCards = replaceCard defender.activeCards updatedCard 
    in
        {defender | activeCards = updatedCards}


getAttacker: Model -> Player
getAttacker model = 
    case model.currentPlayer of 

        PLAYER1 ->
            model.player1

        PLAYER2 -> 
            model.player2

getDefender: Model -> Player
getDefender model = 
    case model.currentPlayer of 

        PLAYER1 ->
            model.player2

        PLAYER2 -> 
            model.player1

updateDefender: Model -> Player -> Model
updateDefender model defender = 
    -- Active player is the attacker
    case model.currentPlayer of

        PLAYER1 ->
            { model | player2 = defender }

        PLAYER2 ->
            { model | player1 = defender }

performAttack: Model -> Card  -> Model
performAttack model defendingCard = 
    let
        defender = getDefender model
    in
        -- THIS WOULD WORK BETTER IF RATHER THAN PLAYER1, PLAYER2 WE CALLED THEM ATTACKER/DEFENDER AND THEN COULD
        -- JUST BE EXPLICT
        case model.attacker of 
            CARD attackingCard ->
                -- calc change
                attack attackingCard defendingCard
                -- update the defender 
                |> updateDefenderCard defender
                |> updateDefender model
            _ ->
                model 

update: Msg -> Model -> Model 
update msg model =
  case msg of
    EndTurn ->
        endTurn model

    Drag card ->
        logAndIgnore model "Drag message " card
        |> setAttacker (CARD card) 

    DraggedOver card ->
        logAndIgnore model "Dragged over message " card

    DragEnd ->
        logAndIgnore model "Drag End" {}
        |> setAttacker NONE         

    DroppedOn card ->
        if model.attacker == NONE then 
            model
        else 
           performAttack model card 

    Attack attacker defender ->
        model

{--
    _ ->
        -- Debug and return input model
        logAndIgnore model "Unknown message " msg
--}


view: Model -> Html Msg 
view model =
  screen model


mainScreenProperties = 
    [

    ]
screen: Model -> Html Msg 
screen model = 
    div [] 
        [
            div 
                [
                    style "width" "800px",
                    style "height" "600px",
                    style "border" "1px solid black"
                    --, style "display" "inline-block"
                ]
                [
                    board model
                ],
            div 
                [
                    -- style "display" "inline-block"
                ] 
                [
                    debugPanel model
                ]
        ]

board: Model -> Html Msg 
board model = 
    div []
        [
            infoPanel model,
            playerPanel (model.currentPlayer == PLAYER1) model.player1,
            playerPanel (model.currentPlayer == PLAYER2) model.player2,
            controlPanel 
        ]

infoPanel: Model -> Html Msg
infoPanel model = 
    div 
        [
            style "background-color" "grey",
            style "align" "center"
        ]
        [
            p [] [ text ("Turn: " ++ String.fromInt model.turn) ]
        ]


controlPanel: Html Msg
controlPanel =
    div []
        [
            button [ onClick EndTurn ] [ text "End Turn" ]
        ]


playerPanel: Bool -> Player -> Html Msg 
playerPanel isActive player =
    let 
        borderColor = 
            case isActive of
                True ->
                    "red"
                False ->
                    "green"
    in
        div [
                style "border" ("1px solid " ++ borderColor)
            ] 
            (
                h2 [] [ text player.name ]
                :: cardListPanel player.activeCards isActive
            )

cardListPanel: CardList -> Bool -> List (Html Msg)
cardListPanel cards isActive =
    List.map (displayCard isActive) cards



displayCard: Bool -> Card -> Html Msg 
displayCard isActive card = 
    let
        draggableProperties = 
            case isActive of 
                False ->
                    [
                        onDrop <| DroppedOn card,
                        onDragOver <| DraggedOver card
                    ]
                True ->
                    [
                        draggable "true"
                        , onDragStart <| Drag card
                        , onDragEnd DragEnd 
                    ]
    in
        
        div 
            (
                List.append 
                    [
                        style "width" "100px",
                        style "outline" "1px solid green",
                        style "display" "inline-block"
                    ]
                    draggableProperties
            )
            [
                p [] [ text card.name ],
                p [] [ text ("Health: " ++ (String.fromInt card.health))],
                p [] [ text ("Normal: " ++ (String.fromInt card.damage.normal))],
                p [] [ text ("Magic: " ++ (String.fromInt card.damage.magic))]
            ]



debugProperties = 
    [
        style "width" "200px"
    ]
debugPanel: Model -> Html Msg 
debugPanel model = 
    div [] 
        [
            h2 [] [ text "Debug Log" ],
            textarea [
                attribute "cols" "100",
                attribute "rows" "20"
                ] 
                [ 
                    text (Debug.toString model) 
                ]
        ]