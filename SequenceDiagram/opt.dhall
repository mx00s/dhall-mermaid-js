let Statement = ./Statement.dhall

let Labeled = ./Labeled.dhall

let SequenceDiagram/opt
    : forall (x : Labeled ./Type) -> ./Type
    = \(x : Labeled ./Type) ->
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
        sequenceDiagram.opt
          { label = x.label, body = x.body SequenceDiagram sequenceDiagram }

in  SequenceDiagram/opt
