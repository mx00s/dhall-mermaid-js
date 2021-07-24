let Statement = ./Statement.dhall

let Labeled = ./Labeled.dhall

let Actor = ./Actor.dhall

in  \(SequenceDiagram : Type) ->
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
        [ sequenceDiagram.par
            [ { label = "first"
              , body =
                  sequenceDiagram.statement
                    ( Statement.Note
                        { position = < RightOf | LeftOf | Over >.RightOf
                        , relativeTo =
                          { first = "Alice", second = None Actor }
                        , content = "This is a test"
                        }
                    )
              }
            , { label = "second"
              , body =
                  sequenceDiagram.statement
                    ( Statement.Note
                        { position = < RightOf | LeftOf | Over >.RightOf
                        , relativeTo =
                          { first = "Alice", second = Some "Bob" }
                        , content = "This is another test"
                        }
                    )
              }
            ]
        ]
