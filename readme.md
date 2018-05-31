# Example mode

### Description:

This code allows you to copy an input and output from one console and paste & run it in an another console.

### Usage

`example-mode`- switch to a new mode  
`old-mode` - switch to previous mode  
`prin*`/`print*`/`probe*` - comments the output so you can copy it in an another console

```
  >>   example-mode
  ; func [src][if any [
      find src "prin*"
      find src "print*"...
      prin* "foo"
  ; foo
      prin* "foo" prin* "baz"
  ; foobaz
      prin* 'foo
  ; foo
      print* [2 3 4]
  ; 2 3 4
      old-mode
  == none
  >>   2 + 2
  == 4
  >>   name: "Baz"
  == "Baz"
  >>   print ["Your name is: " name]
  Your name is:  Baz
```
