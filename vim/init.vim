" ======================================================
" = PLUGINS LOADING
" ======================================================
"

execute pathogen#infect()

" ======================================================
" = EDITTING 
" ======================================================

"backspace will actually show the deleted char
"
set backspace=2


" enable paste when pasting in insert mode ( works also for TMUX mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" syntax highligting
syntax on
colorscheme default
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers = ['eslint']
set noeb vb t_vb= 
set background=dark

" indentation and plugins

filetype indent plugin on

" Groovy/gradle setting

au filetype groovy setl et ts=2 sts=2 shiftwidth=2
au filetype javascript setl et ts=2 sts=2 shiftwidth=2
au filetype gherkin setl et ts=2 sts=2 shiftwidth=2
au filetype cucumber setl et ts=2 sts=2 shiftwidth=2
au filetype cpp setl et ts=4 sts=4 shiftwidth=4
au BufNewFile,BufRead *.gradle setf groovy
au BufNewFile,BufRead *.vue setf javascript
au BufNewFile,BufRead *.mjs setf javascript

" python 
au filetype python setl et ts=4 sts=4 shiftwidth=4

" lua
au filetype lua setl et ts=4 sts=4 shiftwidth=4

let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_PromptRegex = '^\w\+@[0-9A-Za-z_.-]\+:[0-9A-Za-z_./\~,:-]\+\$'

if v:version > 702
    " Remember undo history when switching between files
    set undofile
endif

" ======================================================
" =  NAVIGATION 
" ======================================================

" keep a big history
set history=1000
set incsearch

" NERD tree config
"Toggle the file browser
map <F2> <Esc>:NERDTreeToggle<CR> 
"Find the current file in the file browser
map <A-F2> <Esc>:NERDTreeFind<CR> 

" TagList config
map <F3> <Esc>:TlistToggle<CR>

set tags=./tags,./TAGS,tags;~,TAGS;~

let s:tlist_def_groovy_settings = 'groovy;p:package;c:class;i:interface;f:function;v:variables;x:call'

let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Enable_Fold_Column = 0
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}


"Next / Prev tag match key bindings
nnoremap <silent> <special> <c-left> :silent tp<CR>
nnoremap <silent> <special> <c-right> :silent tn<CR>

"Cycle tabs;
nmap <silent> <tab> :tabn<cr>
nmap <silent> <s-tab> :tabp<cr>
