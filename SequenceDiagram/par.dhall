let List/map = (../Prelude).List.map

let Statement = ./Statement.dhall

let Labeled = ./Labeled.dhall

let SequenceDiagram/par
    : forall (xs : List { label : Text, body : ./Type }) -> ./Type
    = \(xs : List { label : Text, body : ./Type }) ->
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
        sequenceDiagram.par
          ( List/map
              { label : Text, body : ./Type }
              { label : Text, body : SequenceDiagram }
              ( \(x : { label : Text, body : ./Type }) ->
                  { label = x.label
                  , body = x.body SequenceDiagram sequenceDiagram
                  }
              )
              xs
          )

in  SequenceDiagram/par
