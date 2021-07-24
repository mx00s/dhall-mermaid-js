let Prelude = ../Prelude

let Text/concatMapSep = Prelude.Text.concatMapSep

let List/concat = Prelude.List.concat

let List/replicate = Prelude.List.replicate

let List/zip = Prelude.List.zip

let SequenceDiagram = ./Type

let Statement = ./Statement.dhall

let Message = ./Message.dhall

let Arrow = ./Arrow.dhall

let Note = ./Note.dhall

let Actor = ./Actor.dhall

let renderMessage =
      \(message : Message) ->
        let renderArrow =
              \(arrow : Arrow) ->
                let renderLine =
                      \(line : < Solid | Dotted >) ->
                        merge { Solid = "-", Dotted = "--" } line

                let renderArrowhead =
                      \(arrowhead : < None | Filled | Unfilled | Cross >) ->
                        merge
                          { None = ">"
                          , Filled = ">>"
                          , Unfilled = ")"
                          , Cross = "x"
                          }
                          arrowhead

                in  "${renderLine arrow.line}${renderArrowhead arrow.arrowhead}"

        in  "${message.from}${renderArrow
                                message.arrow}${message.to}: ${message.memo}"

let renderActivation =
      \(activation : ./Activation.dhall) ->
        let command =
              merge
                { Activate = "activate", Deactivate = "deactivate" }
                activation.status

        in  "${command} ${activation.for}"

let renderNote =
      \(note : Note) ->
        let renderPosition =
              \(position : < RightOf | LeftOf | Over >) ->
                merge
                  { RightOf = "right of", LeftOf = "left of", Over = "over" }
                  position

        let renderRelativeTo =
              \(relativeTo : { first : Actor, second : Optional Actor }) ->
                let second =
                      merge
                        { Some = \(actor : Actor) -> ",${actor}", None = "" }
                        relativeTo.second

                in  "${relativeTo.first}${second}"

        in  "Note ${renderPosition
                      note.position} ${renderRelativeTo
                                         note.relativeTo}: ${note.content}"

let renderStatement =
      \(statement : Statement) ->
        merge
          { Message = renderMessage
          , Activation = renderActivation
          , Note = renderNote
          }
          statement

let render
    : SequenceDiagram -> Text
    = \(diagram : SequenceDiagram) ->
        let body =
              diagram
                Text
                { statement = \(x : Statement) -> renderStatement x
                , loop =
                    \(x : { body : Text, label : Text }) ->
                      ''
                      loop ${x.label}
                        ${x.body}
                      end''
                , alt =
                    \(first : { body : Text, label : Text }) ->
                    \(second : { body : Text, label : Text }) ->
                      ''
                      alt ${first.label}
                        ${first.body}
                      else ${second.label}
                        ${second.body}
                      end''
                , opt =
                    \(x : { body : Text, label : Text }) ->
                      ''
                      opt ${x.label}
                        ${x.body}
                      end''
                , par =
                    \(xs : List { body : Text, label : Text }) ->
                      let cmds =
                            List/concat
                              Text
                              [ [ "par" ]
                              , List/replicate
                                  (List/length { body : Text, label : Text } xs)
                                  Text
                                  "and"
                              ]

                      let entries =
                            List/zip Text cmds { body : Text, label : Text } xs

                      let renderEntry =
                            \ ( entry
                              : { _1 : Text
                                , _2 : { body : Text, label : Text }
                                }
                              ) ->
                              ''
                              ${entry._1} ${entry._2.label}
                                ${entry._2.body}''

                      in      Text/concatMapSep
                                "\n"
                                { _1 : Text
                                , _2 : { body : Text, label : Text }
                                }
                                renderEntry
                                entries
                          ++  ''

                              end''
                , sequence =
                    \(xs : List Text) ->
                      Text/concatMapSep "\n" Text (\(x : Text) -> x) xs
                }

        in  ''
            sequenceDiagram
            ${body}''

in  render
