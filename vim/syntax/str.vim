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

syn match   strIndentError /^\(  \)* [^ ]/ display
syn match   strTab          /[\t›]/ 
syn match   strEndColNoNL   "-|"
syn match   strBar          "|"
syn match   strKey          /^ *[^ *-:][^:]*\ze:/  
syn match   strArrayItem    "- "
syn match   strArrayPair    "\* "
syn match   strArray        "--"
syn match   strString       "''"
"syn region strKey start=/^ *[^ *-:]/ skip=/\\:/ end=/\ze:/
syn match   strKeySeparator   "[^:]\zs:"
syn match   strDictionaryStart   "\(^ *\|:\)\zs:"

hi link strTab              Delimiter
hi link strEndColNoNL       Delimiter
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
hi link strBar              Delimiter
hi def link strIndentError      Error 

set list listchars=tab:›-


let b:current_syntax = "str"

let &cpo = s:cpo_save
unlet s:cpo_save
