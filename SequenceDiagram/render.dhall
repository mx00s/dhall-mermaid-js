let SequenceDiagram = ./Type

let render
    : SequenceDiagram -> Text
    = \(diagram : SequenceDiagram) ->
        "sequenceDiagram\n" ++
        diagram
          Text
          { alt =
              \(first : { body : Text, label : Text }) ->
              \(second : { body : Text, label : Text }) ->
                ''
                  alt ${first.label}
                    ${first.body}
                  else ${second.label}
                    ${second.body}
                  end
                ''
          , loop = \(x : { body : Text, label : Text }) ->
                ''
                  loop ${x.label}
                    ${x.body}
                  end
                ''
          , opt = \(x : { body : Text, label : Text }) ->
                ''
                  opt ${x.label}
                    ${x.body}
                  end
                ''
          , par = \(xs : List { body : Text, label : Text }) ->
                ''
                  TODO: par
                ''
          , statements =
              \ ( xs
                : List
                    < Activation :
                        { for : Text, status : < Activate | Deactivate > }
                    | Message :
                        { arrow :
                            { arrowhead : < Cross | Filled | None | Unfilled >
                            , line : < Dotted | Solid >
                            }
                        , from : Text
                        , memo : Text
                        , to : Text
                        }
                    | Note :
                        { content : Text
                        , position : < LeftOf | Over | RightOf >
                        , relativeTo : { first : Text, second : Optional Text }
                        }
                    >
                ) ->
                ''
                  TODO: statements
                ''
          }

in  render
