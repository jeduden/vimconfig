" Vim filetype plugin
" Language:	Cucumber
" Maintainer:	Tim Pope <vimNOSPAM@tpope.org>
" Last Change:	2013 Jun 01

" Only do this when not done yet for this buffer
if (exists("b:did_ftplugin"))
  finish
endif
let b:did_ftplugin = 1

let s:keepcpo= &cpo
set cpo&vim


let &cpo = s:keepcpo
unlet s:keepcpo

" vim:set sts=2 sw=2:
