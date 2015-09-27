" ======================================================
" = PLUGINS LOADING
" ======================================================

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
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers = ['jshint']
set noeb vb t_vb= 
set background=dark

" indentation and plugins

filetype indent plugin on

" Groovy/gradle setting

au filetype groovy setl et ts=2 sts=2 shiftwidth=2
au filetype javascript setl et ts=2 sts=2 shiftwidth=2
au BufNewFile,BufRead *.gradle setf groovy

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


"Next / Prev tag match key bindings
nnoremap <silent> <special> <c-left> :silent tp<CR>
nnoremap <silent> <special> <c-right> :silent tn<CR>

"Cycle tabs;
nmap <silent> <tab> :tabn<cr>
nmap <silent> <s-tab> :tabp<cr>

" Unite
let g:unite_source_history_yank_enable = 1

" Match by filename
"call unite#custom#source(
	\ 'buffer,file_rec/async,file_rec', 'matchers',
	\ ['converter_tail', 'matcher_default'])
"call unite#custom#source(
        \ 'file_rec/async,file_rec', 'converters',
        \ ['converter_file_directory'])

call unite#custom#source('file_rec/async', 'matchers',
  \ ['matcher_project_ignore_files', 'matcher_default'])

" sort by match length
call unite#filters#sorter_default#use(['sorter_rank'])
" enable fuzzy matching 
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Default actions for kinds
call unite#custom#default_action('file', 'tabswitch')
call unite#custom#default_action('buffer', 'tabswitch')
call unite#custom#default_action('grep', 'right')

" Overpower sorting by buffer type with sort rank
call unite#custom#profile('mixed-files', 'sorters', 'sorter_rank')
call unite#custom#profile('tags', 'sorters', 'sorter_rank')
call unite#custom#profile('buffer', 'sorters', 'sorter_rank')
call unite#custom#profile('mixed-docs', 'sorters', 'sorter_rank')

" Start unite with <space> 
nnoremap [unite] <Nop>
nmap <space> [unite]

nnoremap [unite]<space> :<C-u>Unite -buffer-name=mixed-files -start-insert file_rec/async:! file_mru buffer<cr>
nnoremap [unite]b :<C-u>Unite -buffer-name=buffer -start-insert buffer<cr>
nnoremap [unite]o :<C-u>Unite -buffer-name=mixed-docs -start-insert function outline<cr>
nnoremap [unite]t :<C-u>Unite -buffer-name=tags -start-insert -auto-preview tag tag/file<cr>
nnoremap [unite]y :<C-u>Unite -buffer-name=yank history/yank<cr>
nnoremap [unite]g :<C-u>Unite -buffer-name=grep -default-action=tabsplit -auto-preview grep<cr>
nnoremap [unite]f :<C-u>Unite -buffer-name=line -start-insert line<cr>
" Go back to last unite buffer. 
nnoremap [unite]<backspace> :UniteResume<cr> 

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  
  call unite#mappings#define_default_mappings()
  " Play nice with supertab
  let b:SuperTabDisabled=1

  "Control backslash to get action menu
  imap <silent><buffer> <C-\> <Plug>(unite_choose_action)
  nmap <silent><buffer> <C-\> <Plug>(unite_choose_action)
endfunction

" ======================================================
" =   AUTO COMPLETE
" ======================================================

" Enable eclim completion via omnifunc
let g:EclimCompletionMethod = 'omnifunc'
