let List/map = (../Prelude).List.map

let Statement = ./Statement.dhall

let Labeled = ./Labeled.dhall

let SequenceDiagram/alt
    : forall (x : Labeled ./Type) -> forall (y : Labeled ./Type) -> ./Type
    = \(x : Labeled ./Type) ->
      \(y : Labeled ./Type) ->
      \(SequenceDiagram : Type) ->
      \ ( sequenceDiagram
        : { statement : Statement -> SequenceDiagram
          , loop : Labeled SequenceDiagram -> SequenceDiagram
          , alt :
              Labeled SequenceDiagram ->
              Labeled SequenceDiagram ->
                SequenceDiagram
          , opt : Labeled SequenceDiagram -> SequenceDiagram
          , par : List (Labeled SequenceDiagram) -> SequenceDiagram
          , sequence : List SequenceDiagram -> SequenceDiagram
          }
        ) ->
        sequenceDiagram.alt
            { label = x.label
            , body = x.body SequenceDiagram sequenceDiagram
            }
            { label = y.label
            , body = y.body SequenceDiagram sequenceDiagram
            }

in  SequenceDiagram/alt
