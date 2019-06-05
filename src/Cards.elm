module Cards exposing (..)

import Modifiers exposing(..)

type alias Card = 
    {
        id: Int,
        name: String,
        health: Int,
        damage: Damage,
        attackModifiers: Modifiers,
        defenseModifiers: Modifiers,
        canAttack: Bool
    }

type alias CardList = List Card 
type alias ActiveCards = CardList
type alias Hand = CardList 
type alias Deck = CardList 
type alias Graveyard = CardList 

canAttackTo: Bool -> Card -> Card 
canAttackTo setTo card =
    { card | canAttack = setTo }

setCanAttackToTrue = canAttackTo True
setCanAttackToFalse = canAttackTo False 

createDamage: Card -> Damage
createDamage card =
    applyModifiers card.attackModifiers card.damage

totalDamage: Damage -> Int
totalDamage damage = 
    damage.normal + damage.magic

decrementHealth: Card -> Int -> Card 
decrementHealth card damage = 
    { card | health = card.health - damage }

applyDamage: Card -> Damage -> Card
applyDamage defender damage = 
    totalDamage damage 
    |> decrementHealth defender



takeDamage: Card -> Damage -> Card
takeDamage defender damage =
    applyModifiers defender.defenseModifiers damage
    |> applyDamage defender

attack: Card -> Card -> Card 
attack attacker defender = 
    createDamage attacker 
    |> takeDamage defender 

isAlive: Card -> Bool
isAlive card =
    card.health > 0

card1 = 
    {
        id = 1,
        name = "Card 1",
        health = 100,
        damage = { normal = 10, magic = 0},
        attackModifiers = [addNormal 5, doubleNormal],
        defenseModifiers = [subtractNormal 10, halveNormal],
        canAttack = True            
    }


card2 = 
    {
        id = 2,
        name = "Card 2",
        health = 100,
        damage = { normal = 10, magic = 0},
        attackModifiers = [doubleNormal, addNormal 5],
        defenseModifiers = [halveNormal, subtractNormal 10],
        canAttack= True     
    }


card3 = 
    {
        id = 3,
        name = "Card 3",
        health = 100,
        damage = { normal = 10, magic = 0},
        attackModifiers = [addNormal 5],
        defenseModifiers = [halveNormal, subtractNormal 10],
        canAttack= True             
    }
showCardInfo: Card -> String 
showCardInfo card = 
    (
        ("Name = " ++ card.name) ++
        (", Health = " ++ (Debug.toString card.health))
    )

showAttackInfo: Int -> Card -> Card -> Bool
showAttackInfo round attacker defender = 
    let 
        title = Debug.log "Round " (Debug.toString round)
        attackReport = Debug.log "Attacker " (showCardInfo attacker)
        defendReport = Debug.log "Defender " (showCardInfo defender)
        separator = Debug.log "--------------------" ""
    in
        True


gameOverReport: Card -> Card -> String
gameOverReport defeatedCard victor = 
    (++) "Game Over, " <|
    (++) "Loser: " <|
    (++) ("Name = " ++ defeatedCard.name) <|
    (++) ", Winner: " <|
    (++) ("Name = " ++ victor.name) <|
    (++) (", Health = " ++ (Debug.toString victor.health)) <|
    "."     


test =
    runAttack 1 card1 card2

runAttack: Int -> Card -> Card -> String
runAttack round attacker defender =
    let
        report = showAttackInfo round attacker defender
        defenderAfter = attack attacker defender
    in
        case isAlive defenderAfter of
            True ->
                runAttack (round + 1) defenderAfter attacker

            False ->
                gameOverReport defenderAfter attacker


type alias AttackScenario = 
    {
        defender: Card,
        attackers: List Card
    }