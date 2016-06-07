" --- Basic options --- {{{

if has('vim_starting')
  " Use Vim settings, rather then Vi settings (much better!).
  " This must be first, because it changes other options as a side effect.
  set nocompatible

  set encoding=utf-8
  set langmenu=en_GB.UTF-8
  let $LANG = 'en_GB.UTF-8'

  set fileformats=unix,dos

  " Allow backspacing over everything in insert mode
  set backspace=indent,eol,start

  set nobackup
  set history=50          " keep 50 lines of command line history
  set ruler               " show the cursor position all the time
  set showcmd             " display incomplete commands
  set incsearch           " do incremental searching
  set ignorecase          " ignore case while searching
  set smartcase           " unless one uses upper case letter

  set tabstop=8
  set softtabstop=2
  set shiftwidth=2
  set expandtab
  set autowrite
  set autoread
  set smarttab

  set cino+=(0,u0,W2s,C1,l1

  set textwidth=80

  set foldmethod=marker
  set foldminlines=10
  " set foldcolumn=2

  set listchars=tab:\|\ ,trail:·,precedes:<,extends:>,nbsp:¤
  set list

  set grepprg=grep\ -niH

  set runtimepath+=~/.vim/bundle/neobundle.vim/

  set laststatus=2
  let mapleader=","
  let maplocalleader="\\"
endif

" --- NeoBundle --- {{{1

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
 \ 'build' : {
 \     'windows' : 'make -f make_mingw32.mak',
 \     'cygwin' : 'make -f make_cygwin.mak',
 \     'mac' : 'make -f make_mac.mak',
 \     'unix' : 'make -f make_unix.mak',
 \    },
 \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neocomplete.vim'

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'ecomba/vim-ruby-refactoring'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'hewes/unite-gtags'
NeoBundle 'jnurmine/Zenburn'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'lukerandall/haskellmode-vim'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'rking/ag.vim'
NeoBundle 'osyo-manga/vim-monster'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/vim-space'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'vim-scripts/blockle.vim'
NeoBundle 'wlangstroth/vim-racket'

call neobundle#end()


set completeopt=menuone,menu,longest,preview

" --- Plugin options   --- {{{1
" --- Tag list options --- {{{2

let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Close_On_Select = 1
let Tlist_Sort_Type = "name"

" --- CtrlP options --- {{{2

let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = "find %s -type f -not -path '*.git*' -not -path '*.hg*'"
let g:ctrlp_lazy_update = 50

" --- Neocomplete --- {{{2

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" --- Airline configuration {{{2

" air-line
let g:airline_powerline_fonts = 0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" --- Ruby completion {{{2

" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"

" With neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}

" }}}

let python_highlight_all = 1

" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" --- Helper functions --- {{{1

" Toggles various listchars options between v1 and v2
function! ToggleLC(v1, v2)
  if &listchars =~ a:v1
    let &listchars = substitute(&listchars, a:v1, a:v2, "")
  elseif &listchars =~ a:v2
    let &listchars = substitute(&listchars, a:v2, a:v1, "")
  endif
endfunction

" --- Key bindings --- {{{1

" Toggle display of trailing spaces
noremap <silent> <Leader>ds :call ToggleLC("trail:·", "trail: ")<CR>
" Toggle display of tabs (all modes)
noremap <silent> <Leader>dt :call ToggleLC("tab:\| ", "tab:  ")<CR>

" Quickly clear highlighted searches
noremap <Leader>c :nohlsearch<CR>
" Reload file from disk
noremap <Leader>r :e %<CR>

" Toggle line wrap faster
noremap  <Leader>w :set wrap!<CR>

imap <C-a> <C-o>0
imap <C-e> <C-o>$


" Buffer explorer
noremap <silent> <F2> :Unite -start-insert buffer<CR>
inoremap <silent> <F2> <C-o><F2>

noremap <silent> <S-F2> :Unite -start-insert buffer_tab<CR>
inoremap <silent> <S-F2> <C-o><S-F2>

" Tag list
noremap <silent> <F3> :TlistToggle<CR>
imap <silent> <F3> <C-o><F3>

" File explorer
noremap <silent> <F4> :VimFilerExplorer<CR>
imap <silent> <F4> <C-o><F4>

" Choose different file from the same directory
noremap <silent> <Leader>f :Unite -start-insert file<CR>

" GNU Global
noremap <silent> <Leader>sc :Unite gtags/context<CR>
noremap <silent> <Leader>sr :Unite gtags/ref<CR>
noremap <silent> <Leader>sd :Unite gtags/def<CR>
noremap <silent> <Leader>sg :Unite gtags/grep<CR>
noremap <silent> <Leader>sl :Unite gtags/completion<CR>

" YCM
noremap <silent> <Leader>jd :YcmCompleter GoTo<CR>

" Preview tag under cursor
noremap <C-\>] <C-W>}
imap <C-\>] <C-o><C-\>]
noremap <C-\>} :pclose<CR>
imap <C-\>} <C-o><C-\>}

" Toggle input mode with M-Space
inoremap <M-Space> <Esc>
nnoremap <M-Space> i
" Easy file saving with C-s
inoremap <C-s> <C-o>:w<CR>
noremap <C-s> :w<CR>
" Don't use Ex mode, use Q for formatting
map Q gqap

" }}}

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  let g:load_doxygen_syntax = 1

  syntax on
  set hlsearch
endif

" --- Auto Command settings --- {{{1

" Fix detection of Objective-C++
function! s:FTmm()
  if match(getline(1, min([line("$"), 200])), '^\s*\(#\s*\(include\|import\)\>\|/\*\)') > -1
    set filetype=objcpp
  else
    set filetype=nroff
  endif
endfunction

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78 | set autoindent

  " Use 4 space indendation for python (inspired by PEP).
  autocmd FileType python setlocal softtabstop=4 shiftwidth=4

  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

  " Recognise .mm files as Objective-C
  autocmd BufRead,BufNewFile *.mm call s:FTmm()

  " Use ghc functionality for haskell files
  au BufEnter *.hs compiler ghc

  autocmd! GUIEnter * set vb t_vb=


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on

endif " has("autocmd") }}}

NeoBundleCheck


if has("gui_running")
  " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
  let &guioptions = substitute(&guioptions, "t", "", "g")
  set guioptions-=T

  let &columns = 100
  let &lines = 50

  set guifont=Consolas:h14
  :colorscheme solarized
  set background=light
endif

" Additional local configuration
let s:localvimrc = expand("~/.vim/localrc")
if filereadable(s:localvimrc)
  silent! execute 'source' s:localvimrc
endif
