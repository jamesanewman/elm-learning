module Modifiers exposing (..)
{--
Modifiers are things that are applied to damage in an attack or defense
scenario
--}

type alias Modifiers = List Modifier
{-- 
A modifer consists of the raw function to apply to the damage value (Int).
and a description of that modifer
--}
type alias Modifier = 
    {
        -- what type of damage does this modifier modify
        target: DamageType,
        -- Modify the damage in some way
        apply: ModifierFunction,
        -- Description of what this modifier will do
        description: String

    }

{--
Types of damage available
--}
type DamageType = NORMAL | MAGIC

{--
    Damage contains all the different types of damage that will be applied
--}
type alias Damage =
    {
        normal: Int,
        magic: Int
    }

type alias ModifierFunction = (Damage -> Damage)

doubleDamage: DamageType -> Damage -> Damage
doubleDamage damageType damage =
    case damageType of 
        NORMAL ->
            { damage | normal = damage.normal * 2 }
        
        MAGIC ->
            { damage | magic = damage.magic * 2 }

halveDamage: DamageType -> Damage -> Damage
halveDamage damageType damage =
    case damageType of 
        NORMAL ->
            { damage | normal = damage.normal // 2 }
        
        MAGIC ->
            { damage | magic = damage.magic // 2 }

addDamage: DamageType -> Int -> Damage -> Damage
addDamage damageType addAmount damage =
    case damageType of 
        NORMAL ->
            { damage | normal = damage.normal + addAmount }
        
        MAGIC ->
            { damage | magic = damage.magic + addAmount }

subtractDamage: DamageType -> Int -> Damage -> Damage
subtractDamage damageType subtractAmount damage =
    case damageType of 
        NORMAL ->
            { damage | normal = damage.normal + subtractAmount }
        
        MAGIC ->
            { damage | magic = damage.magic + subtractAmount }


doubleNormal: Modifier 
doubleNormal = 
    {
        target = NORMAL,
        apply = doubleDamage NORMAL,
        description = "Double normal damage"
    }

doubleMagic: Modifier 
doubleMagic = 
    {
        target = MAGIC,
        apply = doubleDamage MAGIC,
        description = "Double magic damage"
    }

halveNormal: Modifier 
halveNormal = 
    {
        target = NORMAL,
        apply = halveDamage NORMAL,
        description = "Halve normal damage"
    }

subtractNormal: Int -> Modifier 
subtractNormal amount =
    {
        target = NORMAL,
        apply = subtractDamage NORMAL amount,
        description = "Halve normal damage"
    } 

addNormal: Int -> Modifier 
addNormal amount =
    {
        target = NORMAL,
        apply = addDamage NORMAL amount,
        description = "Halve normal damage"
    } 
describeModifier: String -> Modifier -> String 
describeModifier separator modifier = 
    modifier.description ++ separator

describeModifiers: Modifiers -> String 
describeModifiers modifiers = 
    let 
        getDescription = describeModifier " -> "
    in
        List.map (getDescription) modifiers  
            |> List.foldl (++) "" 

applyModifier: Modifier -> Damage -> Damage
applyModifier modifier damage =
    modifier.apply damage

applyModifiers: Modifiers -> Damage -> Damage
applyModifiers modifiers damage =
    List.foldl applyModifier damage modifiers

test = 
    let
        modifiers = testModifiers
        damage = initialDamage
        log = Debug.log "Modifiers to test" (describeModifiers modifiers)
    in
        Debug.log "Start Damage " initialDamage
            |> applyModifiers modifiers
            |> Debug.log "Final Damage "


initialDamage: Damage
initialDamage = { normal = 1, magic = 1}
      
testModifiers: Modifiers
testModifiers = [ doubleMagic, doubleNormal ]
