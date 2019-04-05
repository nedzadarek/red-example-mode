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
#### Version 0.1.1

Adds multiline support.
`[` and `{` will be deleted:
```
  [
    aaa
    bbb
    cc
    ]{
    qqq
    www
    eee
    }
; {^/qqq^/www^/eee^/}
```
Longer output with `...`:
```
  [
    a
    b
    c
    d
    e
    f
    g
    h
    i
    j
    k
    l
    ]
; [
;     a 
;     b 
;     c 
;     d 
;     e 
;     f 
;     g 
;     h 
;     i 
;     j 
;     k...
```

#### Version 0.1.2

Fix not commenting errors:
```
  2 / 0
; *** Math Error: attempt to divide by zero
; *** Where: /
; *** Stack:
```
