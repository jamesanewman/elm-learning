module Views.CardsField exposing (..)

import Html exposing (Html, div, text, h2, p)
import Html.Attributes exposing (style)
import Model exposing (..)

import Views.Card exposing (..)

cardsView: ViewConfig -> ActiveCards -> Html Msg
cardsView vconfig cards = 
    div 
        [

        ]
        ( List.map (cardView vconfig) cards )