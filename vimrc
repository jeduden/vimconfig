" keep a big history
set history=1000
set incsearch
set paste
execute pathogen#infect()

" syntax highligting
syntax on

let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
set noeb vb t_vb= 
" indentation and plugins

filetype indent plugin on

au filetype groovy setl et ts=2 sts=2

let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_PromptRegex = '^\w\+@[0-9A-Za-z_.-]\+:[0-9A-Za-z_./\~,:-]\+\$'

" NERD tree config
"Toggle the file browser
map <F2> <Esc>:NERDTreeToggle<CR> 
"Find the current file in the file browser
map <A-F2> <Esc>:NERDTreeFind<CR> 

" TagList config
map <F3> <Esc>:TlistToggle<CR>

set tags=./tags,./TAGS,tags;~,TAGS;~

au BufNewFile,BufRead *.gradle setf groovy
let g:tagbar_type_groovy = {
    \ 'ctagstype' : 'groovy',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'c:class',
        \ 'i:interface',
        \ 'f:function',
        \ 'v:variable',
        \ 'u:public',
        \ 'x:call',
    \ ]
\ }

let s:tlist_def_groovy_settings = 'groovy;p:package;c:class;i:interface;f:function;v:variables;x:call'


let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Enable_Fold_Column = 0
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1

if v:version > 702
    " Remember undo history when switching between files
    set undofile
endif

"Next / Prev tag match key bindings
nnoremap <silent> <special> <c-left> :silent tp<CR>
nnoremap <silent> <special> <c-right> :silent tn<CR>
nnoremap <c-o> :MRU<CR>
