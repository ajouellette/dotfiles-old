" Vim syntax file
" Language: Hack assembly
" Maintainer: Aaron

if exists("b:current_syntax")
    finish
endif

syn keyword hackTodo contained TODO FIXME NOTE
syn keyword hackRegisters D A M
syn keyword hackJump JGT JEQ JGE JLT JNE JLE JMP
syn keyword hackVirtRegs R0 R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15
syn keyword hackPntrs SP LCL ARG THIS THAT SCREEN KBD

syn match hackNumber /\d\+/ display
syn match hackAinstr /@/ display

syn region hackComment start=/\/\// end=/$/ contains=hackTodo display oneline
syn region hackLabel   start=/(/    end=/)/ display oneline

hi def link hackComment     Comment
hi def link hackTodo        Todo
hi def link hackNumber      Number
hi def link hackLabel       Label
hi def link hackRegisters   Constant
hi def link hackVirtRegs    Constant
hi def link hackPntrs       Constant
hi def link hackAinstr      Statement
hi def link hackJump        Keyword

let b:current_syntax = "hasm"
