module Components.Screen exposing (..)

import Models.Model exposing (..) 
import Html exposing (..)
import Html.Attributes as Attributes

{--
Basic UI Layout for the overall application
--}

mainDisplayCss: List (Attribute msg)
mainDisplayCss = 
    [
        Attributes.style "border" "1px solid black"
    ]


mainDisplay: Model -> Html Msg
mainDisplay model =
    div 
        mainDisplayCss 
        [
            h1 [] [ text model.ui.title ],
            p [] [ text "Hello James" ]
        ]

