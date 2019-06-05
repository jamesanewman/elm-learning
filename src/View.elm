module View exposing (..)

import Html exposing (Html, button, div, text, h2, textarea, p , hr)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, attribute, draggable)

import Model exposing (..)

view: ViewConfig -> Model -> Html Msg 
view vconfig model =
    div [] [ text "HELLO" ]
