let Statement = ./Statement.dhall

let Labeled = ./Labeled.dhall

let SequenceDiagram/statement
    : forall (x : Statement) -> ./Type
    = \(x : Statement) ->
      \(SequenceDiagram : Type) ->
      \ ( sequenceDiagram
        : { statement : Statement -> SequenceDiagram
          , loop : Labeled SequenceDiagram -> SequenceDiagram
          , alt : List (Labeled SequenceDiagram) -> SequenceDiagram
          , opt : Labeled SequenceDiagram -> SequenceDiagram
          , par : List (Labeled SequenceDiagram) -> SequenceDiagram
          , sequence : List SequenceDiagram -> SequenceDiagram
          }
        ) ->
        sequenceDiagram.statement x

in  SequenceDiagram/statement
