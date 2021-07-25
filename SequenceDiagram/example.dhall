let SD = ./package.dhall

in  SD.fromList
      (   [ SD.par
              [ { label = "first"
                , body =
                    SD.statement
                      ( SD.Statement.Note
                          { position = < RightOf | LeftOf | Over >.RightOf
                          , relativeTo =
                            { first = "Alice", second = None SD.Actor }
                          , content = "This is a test"
                          }
                      )
                }
              , { label = "second"
                , body =
                    SD.statement
                      ( SD.Statement.Note
                          { position = < RightOf | LeftOf | Over >.RightOf
                          , relativeTo =
                            { first = "Alice", second = Some "Bob" }
                          , content = "This is another test"
                          }
                      )
                }
              ]
          ]
        : List SD.Type
      )
