Red [
  author: "Nędza Darek"
  license: %license.md
  version: 0.2.3
  subversion: 'alpha
]
___old-console: copy/deep :system/console
___old-pre-load: :system/lexer/pre-load
___line-numbers: [1]
___split-on-int: func [str n] [
    collect [
        while [not tail? str] [
            keep copy/part str n 
            str: skip str n
        ]
    ]
]
clean-console: does [
    gui-console-ctx/terminal/clean
    remove back tail gui-console-ctx/terminal/lines
    ()
]

example-mode: function [] [
  system/console/result: function [result] [
    insert result "; "
    result: skip result 2
    forall result [
        if result/1 = newline [
            insert (next result) "; "
            result: skip result 3
        ] 
    ]
    head result
  ]
  system/console/prompt: function [] [
        append ___line-numbers length? gui-console-ctx/terminal/lines
        last-line: last ___line-numbers
        before-last-line: first back back tail ___line-numbers
        repeat ind (last-line - before-last-line)  [
            current-line: gui-console-ctx/terminal/lines/(before-last-line + ind)
            if any [current-line/1 = #"["  current-line/1 = #"{" ] [
                remove current-line
            ]
            ; errors are not handled by system/console/result
            if "***" = copy/part current-line 3 [
                
                insert current-line "; "
            ]
        ]
        return "  "
    ]
  system/lexer/pre-load: function [src][
    if any [
      find src "prin*"
      find src "print*"
      find src "probe*"
    ][
      append src " "
      append src 'make-prints
    ]
  ]
]

old-mode: does[
  system/console/result: :___old-console/result
  system/console/prompt: :___old-console/prompt
  system/lexer/pre-load: :___old-pre-load
]

___to-print: copy ""
prin*: func [value [any-type!]][
  either word! = type? value [
    append ___to-print form value
  ][
    append ___to-print form reduce value
  ]
]
print*: func [value [any-type!]][
  prin* value
  append ___to-print newline
]
probe*: func [value [any-type!]][
  print* mold :value
  return :value
]
make-prints: has[
  lines
  last-character
] [
  if #"^/" = first last-character: back tail ___to-print [
    remove last-character
  ]
  lines: split ___to-print "^/"
  foreach line lines [
    either system/console/size/x  < length? line[
        foreach real-line (___split-on-int line system/console/size/x) [
            prin "; "
            print real-line
        ]
    ][
        prin "; "
        print line
    ]
  ]
  clear ___to-print
  exit
]
