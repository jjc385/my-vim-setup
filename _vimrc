" swap roles of \ and ;
let mapleader=";"
let maplocalleader=";"
noremap \ ;
noremap \| ,




set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction


"Personal Settings.
execute pathogen#infect()
filetype plugin indent on
syntax on

"Set the status line options. Make it show more information.
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\[POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"Set Color Scheme and Font Options
colorscheme kolor
" colorscheme solarized
set guifont=Consolas:h15
"set line no, buffer, search, highlight, autoindent and more.
set nu
set rnu
"set hidden
set ignorecase
set incsearch
set smartcase
set showmatch
set autoindent
set ruler
set visualbell
set viminfo+=n$VIM/_viminfo
set noerrorbells
set showcmd
set mouse=a
set history=1000
set undolevels=1000

" Tab options

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
"set expandtab


"From previous Ubuntu .vimrc's

"" Hard word wrapping 
"{{{

"hard word wrap at 79 characters
let mytextwidth = 79	"DO NOT CHAGE this variable to turn word wrapping off;  see below

let hardWordWrapDefaultQ = 1	"Change this line to update hard word wrap default (1 for on; 0 for off)
" note:  1 is truthy

let hardWrapQ = hardWordWrapDefaultQ	"DO NOT CHAGE this variable to turn word wrapping off;  see above

"" Word wrap functions "{{{
function! UpdateHardWrap()
"	Toggle textwidth (hard wrap width)
	if g:hardWrapQ
		let &tw = g:mytextwidth 
	else 
		let &tw = 0
	endif
endfunction

function! SetHardWrap(newVal)
	if a:newVal 
		let g:hardWrapQ = 1
	else
		let g:hardWrapQ = 0
	endif

	call UpdateHardWrap()
endfunction

function! ToggleHardWrap()
	call SetHardWrap( !g:hardWrapQ )
endfunction
"}}}

call UpdateHardWordWrap()  " Implement default

" Mapping to toggle hard word wrapping
nnoremap <leader><leader>w :call ToggleHardWrap()<cr>:set tw?<cr>

"}}}


"" Mark text boundary
"{{{

let &tw= mytextwidth
"set tw=79
set formatoptions+=t
" color 80th column
"set colorcolumn=80
let &colorcolumn=mytextwidth+1
"see linebreak option to change line wrapping

"}}}



" Fold text based on foldmarker
set foldmethod=marker

" Create backup file while writing, but delete afterward
set nobackup
set writebackup

" insert placeholder
noremap <C-k> i<++><esc>3h
noremap! <C-k> <++>

" go to matched brace in insertion mode
noremap! <C-%> <esc>%i

" clear highlighting normal mode
nnoremap <leader>o :noh<CR>

" reload syntax highlighting
nnoremap <leader>i :syntax sync fromstart<CR>

" remap jk to exit insert, visual, and op-pending mode
inoremap jk <esc>
vnoremap jk <esc>
onoremap jk <esc>

"" " remap kj to exit insert, visual, and op-pending mode
"" inoremap kj <esc>
"" vnoremap kj <esc>
"" onoremap kj <esc>




" remove functionality of <esc> and arrow keys in insert mode
"inoremap <esc> <nop>
"inoremap <Left> <nop>
"inoremap <Right> <nop>
"inoremap <Up> <nop>
"inoremap <Down> <nop>

" edit vimrc file
:nnoremap <leader><leader>sv :source $MYVIMRC<cr>
:nnoremap <leader><leader>ev :split $MYVIMRC<cr>
":nnoremap <leader>sv :source $MYVIMRC<cr>
":nnoremap <leader>ev :split $MYVIMRC<cr>

" map H and L to move to beginning and end of lines
:noremap H 0
:noremap L $

" map J and K to pageup and pagedown
:noremap J <c-d>
:noremap K <c-u>

" insert comments specific to filetypes
:augroup ftype_comments
    autocmd!
"    autocmd FileType tex nnoremap <buffer> <localleader>c I%<esc>
    autocmd FileType tex nnoremap <buffer> <localleader>c 0i%<esc>j
    autocmd FileType python nnoremap <buffer> <localleader>c 0i#<esc>j
    autocmd FileType conf nnoremap <buffer> <localleader>c 0i#<esc>j
    autocmd FileType autohotkey nnoremap <buffer> <localleader>c 0i;<esc>j
    autocmd FileType vim nnoremap <buffer> <localleader>c 0i"<esc>j
    autocmd FileType sh nnoremap <buffer> <localleader>c 0i#<esc>j
    autocmd FileType markdown nnoremap <buffer> <localleader>c 0i[comment]: # ( <esc>A )<esc>j
    autocmd Filetype dosbatch nnoremap <buffer> <localleader>c 0i::<esc>j
    autocmd Filetype mma nnoremap <buffer> <localleader>c <esc>
    autocmd Filetype mma nnoremap <buffer> <localleader><localleader>x 0i(* <esc>$a *)<esc>j
    autocmd Filetype mma nnoremap <buffer> <localleader><localleader>c O<esc>0i(* <esc>j
    autocmd Filetype mma nnoremap <buffer> <localleader><localleader>v o<esc>0i*) <esc>j
:augroup END
"todo:  extend ftype_comments to 
" (1) have a default
" (2) be configurable
" (3) interact with fold markers
" (4) distinguish between languages with full-line comments, inline comments,
"  		or both
"
"
"

"" Define save commands with slightly different actions for different filetypes

" First define generic save command
"nnoremap ;; :w<cr>
nnoremap <leader>e :w <cr>
nnoremap <leader>r :w <cr>
" Now define enhancements based on filetype
:augroup ftype_save
    autocmd!
    " autocmd FileType tex nnoremap <buffer> ;; :call SaveAndRunTex()<CR>
"    autocmd FileType tex nnoremap <buffer> ;; :w <cr> :silent ! pdflatex % <cr>
"    autocmd Filetype tex nnoremap <buffer> <leader>e :w <cr> :! pdflatex % <cr>
"    autocmd Filetype tex nnoremap <buffer> <leader>r :w <cr> :silent ! start "" pdflatex % <cr>
"" Include full path of file
    autocmd Filetype tex nnoremap <buffer> <leader>e :w <cr> :! pdflatex -output-directory %:p:h %:p <cr>
    autocmd Filetype tex nnoremap <buffer> <leader>r :w <cr> :silent ! start "" pdflatex -output-directory %:p:h %:p <cr>
"    autocmd FileType tex nnoremap <buffer> <leader>v :exec 'silent ! start "" evince ' . expand('%:r') . '.pdf' <cr>
"    autocmd FileType tex nnoremap <buffer> <leader>v :exec 'silent ! start "" sumatrapdf ' . expand('%:r') . '.pdf' <cr>
    autocmd FileType tex nnoremap <buffer> <leader>v :exec 'silent ! start "" sumatrapdf ' . expand('%:p:r') . '.pdf' <cr>
"    autocmd FileType autohotkey nnoremap <buffer> ;; :w <cr> :silent ! autohotkey.exe % <cr>
    " move this later
    autocmd Filetype autohotkey nnoremap <buffer> <leader>e :w <cr> :! autohotkey.exe % <cr>
    autocmd Filetype autohotkey nnoremap <buffer> <leader>r :w <cr> :silent ! start "" autohotkey.exe % <cr>
    autocmd Filetype python nnoremap <buffer> <leader>e :w <cr> :! python % <cr>
"" 	attempt to pipe output into a new buffer
"    autocmd Filetype python nnoremap <buffer> <leader>e :w <cr> :tabnew | r ! python % <cr>
    autocmd Filetype python nnoremap <buffer> <leader>r :w <cr> :silent ! python % <cr>
" Hack -- use python2 instead of default
"    autocmd Filetype python nnoremap <buffer> <leader>e :w <cr> :! "C:\Program Files (x86)\Python2\python" % <cr>
"    autocmd Filetype python nnoremap <buffer> <leader>r :w <cr> :silent ! "C:\Program Files (x86)\Python2\python" % <cr>
    autocmd Filetype dosbatch nnoremap <buffer> <leader>e :w <cr> :silent ! start "" % <cr>
    autocmd Filetype markdown nnoremap <buffer> <leader>v :w <cr> :silent ! start "" C:\Users\Jared\programs\McViewer.exe % <cr>
	autocmd Filetype mma setlocal iskeyword -=_
"	autocmd Filetype mma setlocal iskeyword -=@
:augroup END


"" Override default word wrapping for certain filetypes
:augroup ftype_hardWrap
    autocmd!
	autocmd Filetype python SetHardWrap(0) <cr>
	autocmd Filetype mma 	SetHardWrap(0) <cr>
:augroup END


" Python specific setup
"
:augroup ftype_python_setup
    autocmd!
    autocmd Filetype python setlocal expandtab
    autocmd Filetype python setlocal softtabstop=4


"    autocmd Filetype python setlocal foldmethod=indent
"    autocmd Filetype python setlocal foldnestmax=2
    autocmd Filetype python setlocal foldmethod=marker
:augroup END

""""" vim-wordmotion configuration
"" don't override default word definitions; rather, insert at least one <leader>
let g:wordmotion_mappings = {
\ 'w' : '<leader>w',
\ 'b' : '<leader>b',
\ 'e' : '<leader><leader>e',
\ 'ge' : 'g<leader>e',
\ 'aw' : 'a<leader>w',
\ 'iw' : 'i<leader>w'
"\ '<C-R><C-W>' : '<C-R><M-w>'
\ }


" Open pdf reader
" :nnoremap <leader>v :! sumatra 

" Leave at least N+1 lines under curser
set scrolloff=3


