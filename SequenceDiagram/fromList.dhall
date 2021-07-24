let List/map = (../Prelude).List.map

let Statement = ./Statement.dhall

let Labeled = ./Labeled.dhall

let SequenceDiagram/fromList
    : forall (xs : List ./Type) -> ./Type
    = \(xs : List ./Type) ->
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
        sequenceDiagram.sequence
          ( List/map
              ./Type
              SequenceDiagram
              (\(x : ./Type) -> x SequenceDiagram sequenceDiagram)
              xs
          )

in  SequenceDiagram/fromList
