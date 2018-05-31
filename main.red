Red [
  author: "Nędza Darek"
  license: %license.md
  version: 0.0.1
  subversion: 'alpha
]
___old-console: copy/deep :system/console
___old-pre-load: :system/lexer/pre-load
example-mode: does [
  system/console/result: func [src][insert src "; " src]
  system/console/prompt: "  "
  system/lexer/pre-load: func [src][
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
    prin "; "
    print line
  ]
  clear ___to-print
  exit
]
