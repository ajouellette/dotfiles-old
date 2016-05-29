" Vim syntax file
" Language:      nand2tetris Hardware Description Language
" Maintainers:   Christopher Noussis,
"                aouelete
" Last Change:   07 October 2015

if exists("b:current_syntax")
    finish
endif

" Comments.
syn match hdlComment "\/\/.*$"
syn region hdlComment start='\/\*' end='\*\/'
syn region hdlComment start='\/\*\*' end='\*\/'

" The all-caps basic language keywords.
syn keyword hdlBasicKeywords CHIP PARTS IN OUT BUILTIN CLOCKED

" Built-in chips.
syn keyword hdlBuiltIn Nand Not And Or Xor Mux DMux
syn keyword hdlBuiltIn Not16 And16 Or16 Mux16
syn keyword hdlBuiltIn Or8Way Mux4Way16 Mux8Way16 DMux4Way DMux8Way
syn keyword hdlBuiltIn HalfAdder FullAdder Add16 ALU Inc16
syn keyword hdlBuiltIn DFF Bit Register ARegister DRegister
syn keyword hdlBuiltIn RAM8 RAM64 RAM512 RAM4K RAM16K
syn keyword hdlBuiltIn PC ROM32K Screen Keyboard

" External
syn keyword hdlExtPin in out nextgroup=busNumber
syn match   hdlBusNumber '\[\d*\]' "TODO: Make it so the braces are not matched.
syn region  hdlInterface start='{' end='}' fold transparent

" Internal
syn region hdlImplementation start=':' end='}' fold transparent
syn region hdlPartInterface start='(' end=')' contains=connection, extPin
"syn match connection '\w\+(\[\d+\])\*=\w\+(\[\d+\])\*'
syn match  hdlConnection '\w\+=\@=' contained
syn match  hdlConnection '=\@<=\w\+' contained

" Syntax Highlighting
hi def link hdlComment         Comment
hi def link hdlBasicKeywords   Statement
hi def link hdlBuiltIn         Special
hi def link hdlExtPin          Type
hi def link hdlBusNumber       Constant
hi def link hdlConnection      Identifier

let b:current_syntax = 'hdl'
