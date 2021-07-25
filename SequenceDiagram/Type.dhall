let Statement = ./Statement.dhall

let Labeled = ./Labeled.dhall

let SequenceDiagram/Type
    : Type
    = forall (SequenceDiagram : Type) ->
      forall  ( sequenceDiagram
              : { statement : Statement -> SequenceDiagram
                , loop : Labeled SequenceDiagram -> SequenceDiagram
                , alt : List (Labeled SequenceDiagram) -> SequenceDiagram
                , opt : Labeled SequenceDiagram -> SequenceDiagram
                , par : List (Labeled SequenceDiagram) -> SequenceDiagram
                , sequence : List SequenceDiagram -> SequenceDiagram
                }
              ) ->
        SequenceDiagram

in  SequenceDiagram/Type
