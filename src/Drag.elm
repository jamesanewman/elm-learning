module Drag exposing (..) 

import Html.Events as Events
import Json.Decode as Decode


onDragStart msg =
    Events.on "dragstart" 
        <| Decode.succeed msg


onDragEnd msg =
    Events.on "dragend"
        <| Decode.succeed msg


onDragOver msg =
    Events.preventDefaultOn "dragover"
        <| Decode.succeed (msg, True)


onDrop msg =
    Events.preventDefaultOn "drop"
        <| Decode.succeed (msg, True)