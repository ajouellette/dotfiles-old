" Vim syntax file
" Language: TECS virtual machine code
" Maintainer: Aaron

if exists("b:current_syntax")
    finish
endif

syn keyword vmTodo contained TODO FIXME NOTE
syn keyword vmMathLogicOp add sub neg and or not eq gt lt
syn keyword vmMemoryOp push pop
syn keyword vmMemSegments argument local static constant this that pointer temp
syn keyword vmPrgmFlow label goto if-goto
syn keyword vmFunctionCall function call return

syn match vmNumber /\d\+/ display

syn region vmComment start=/\/\// end=/$/ contains=vmTodo display oneline

hi def link vmComment       Comment
hi def link vmTodo          Todo
hi def link vmNumber        Number
hi def link vmMathLogicOp   Operator
hi def link vmMemoryOp      Statement
hi def link vmMemSegments   Identifier
hi def link vmPrgmFlow      Conditional
hi def link vmFunctionCall  Function

let b:current_syntax = "vm"
