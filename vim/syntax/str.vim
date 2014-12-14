" Vim syntax file
" Language:  Structured Strings 
" Author:    Jan-Eric Duden 
" Version:   1.0
"

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
syntax clear

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

"syn match   strKey          /^ *[^ *-:][^:]*\ze:/  
syn match   strIndentError /^\(  \)* [^ ]/ display
syn match   strArrayItem    "- "
syn match   strArrayPair    "\* "
syn match   strArray        "--"
syn match   strString       "''"
syn region strKey start=/^ *[^ *-:]/ skip=/\\:/ end=/\ze:/
syn match   strKeySeparator   "[^:]\zs:"
syn match   strDictionaryStart   "\(^ *\|:\)\zs:"


hi link strKey              Identifier
hi link strKeyEscape        Special
hi link strKeyEnd           SpecialChar
hi link strArrayItem        Label
hi link strArrayPair        Label
hi link strKeySeparator     Label
hi link strKeySeparator2    Label
hi link strDictionaryStart  Delimiter 
hi link strArray            Delimiter
hi link strString           Delimiter
hi def link strIndentError      Error 

let b:current_syntax = "str"

let &cpo = s:cpo_save
unlet s:cpo_save
