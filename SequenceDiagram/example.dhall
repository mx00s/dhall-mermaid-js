let Actor = Text

let Arrow
    : Type
    = { line : < Solid | Dotted >
      , arrowhead : < None | Filled | Unfilled | Cross >
      }

let Message
    : Type
    = { from : Actor, arrow : Arrow, to : Actor, memo : Text }

let Activation
    : Type
    = { for : Actor, status : < Activate | Deactivate > }

let Note
    : Type
    = { position : < RightOf | LeftOf | Over >
      , relativeTo : { first : Actor, second : Optional Actor }
      , content : Text
      }

let Statement
    : Type
    = < Message : Message | Activation : Activation | Note : Note >

let Labeled
    : Type -> Type
    = \(type : Type) -> { label : Text, body : type }

in

\(SequenceDiagram : Type) ->
\  ( sequenceDiagram
        : { statements : List Statement -> SequenceDiagram
        , loop : Labeled SequenceDiagram -> SequenceDiagram
        , alt :
            Labeled SequenceDiagram ->
            Labeled SequenceDiagram ->
                SequenceDiagram
        , opt : Labeled SequenceDiagram -> SequenceDiagram
        , par : List (Labeled SequenceDiagram) -> SequenceDiagram
        }
        ) ->
sequenceDiagram.statements ([] : List Statement)
