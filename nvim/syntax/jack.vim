" Vim syntax file
" Language:     Jack
" Maintainer:   aouelete
" Last Change:  27 May 2016

if exists("b:current_syntax")
    finish
endif

syn keyword jackDeclaration var static field class
syn keyword jackStatement let if else while do return
syn keyword jackVarType int char boolean void
syn keyword jackFuncType constructor function method
syn keyword jackConstant true false null this

syn match jackOp "[-+*/&|<>=~]"
syn match jackString '"[^"\n]*"'
syn match jackNumber "\d\+"
syn match jackDelimiter "[.,;]"
syn match jackSurroundingElement "[{}()\[\]]"
syn match jackCommentInline "\/\/.*"

syn region jackCommentBlock start="/\*" end="*/"

hi link jackOp Operator
hi link jackSurroundingElement Delimiter
hi link jackVarType Type
hi link jackFuncType Function
hi link jackDeclaration Statement
hi link jackStatement Statement
hi link jackConstant Constant
hi link jackNumber Number
hi link jackCommentInline Comment
hi link jackCommentBlock Comment
hi link jackDelimiter Comment

let b:current_syntax = "jack"
