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

" Unite
let g:unite_source_history_yank_enable = 1

" Match by filename
"call unite#custom#source(
	\ 'buffer,file_rec/async,file_rec', 'matchers',
	\ ['converter_tail', 'matcher_default'])
"call unite#custom#source(
        \ 'file_rec/async,file_rec', 'converters',
        \ ['converter_file_directory'])

" sort by match length
call unite#filters#sorter_default#use(['sorter_rank'])
" enable fuzzy matching 
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Overpower sorting by buffer type with sort rank
call unite#custom#profile('mixed-files', 'sorters', 'sorter_rank')
call unite#custom#profile('tags', 'sorters', 'sorter_rank')
call unite#custom#profile('buffer', 'sorters', 'sorter_rank')
call unite#custom#profile('mixed-docs', 'sorters', 'sorter_rank')

nnoremap [unite] <Nop>
nmap <space> [unite]

nnoremap [unite]<space> :<C-u>Unite -buffer-name=mixed-files -start-insert file_rec/async:! file_mru buffer<cr>
nnoremap [unite]b :<C-u>Unite -buffer-name=buffer -start-insert buffer<cr>
nnoremap [unite]j :<C-u>Unite -buffer-name=mixed-docs -start-insert function outline<cr>
nnoremap [unite]t :<C-u>Unite -buffer-name=tags -start-insert tag tag/file<cr>
nnoremap [unite]y :<C-u>Unite -buffer-name=yank history/yank<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  mapclear <buffer>
  imap <buffer> <C-l> <plug>(unite_select_next_line)
  nmap <buffer> <C-l> <Plug>(unite_select_next_line)
  inoremap <silent><buffer><expr> <C-k>   <Plug>(unite_select_previous_line)
  nnoremap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-b> <Plug>(unite_insert_leave);unite#do_action('split')
  nmap <silent><buffer><expr> <C-b> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> <Plug>(unite_insert_leave);unite#do_action('vsplit')
  nmap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <cr> <Plug>(unite_insert_leave);unite#do_action('tabopen')
  nmap <silent><buffer><expr> <cr> unite#do_action('tabopen')
  nmap <buffer> Q <plug>(unite_exit)
  " Remap choose action to Ctrl+a from default Tab 
  nmap <buffer> <c-a> <Plug>(unite_choose_action)
endfunction
