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
  if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
  endif

  set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

  " Used by a number of completion plugins
  set hidden

  set laststatus=2
  let mapleader="\<Space>"
  let maplocalleader="\\"
endif

" Finds an executable. Tries to use PATH first, then some builtin
" absolute paths, and then tries the remaining supplied paths.
function! s:PickExecutable(prog, ...)
  let l:candidates = [a:prog, '/usr/local/bin' . a:prog, '/usr/bin' . a:prog]
  for e in l:candidates + a:000
    if executable(e)
      return e
    endif
  endfor
  echomsg "No suitable executable found for " . a:0
  return ""
endfunction

let g:python_host_prog = s:PickExecutable('python')
let g:python3_host_prog = s:PickExecutable('python3')
if !has("nvim")
  if len(g:python3_host_prog)
    set pyxversion=3
  else
    set pyxversion=2
  endif
endif

" --- dein --- {{{1

if dein#load_state('~/.vim/bundles')
  call dein#begin('~/.vim/bundles')

  call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if has('nvim')
  else
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#add('Shougo/neco-vim')
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('copy/deoplete-ocaml')
  call dein#add('deoplete-plugins/deoplete-jedi')
  call dein#add('deoplete-plugins/deoplete-zsh')

  call dein#add('autozimu/LanguageClient-neovim', {
        \ 'rev' : 'next', 'build' : 'bash install.sh'})

  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('chrisbra/NrrwRgn')
  call dein#add('ciaranm/securemodelines')
  call dein#add('ecomba/vim-ruby-refactoring')
  call dein#add('ekalinin/Dockerfile.vim')
  call dein#add('elixir-lang/vim-elixir')
  call dein#add('eugen0329/vim-esearch')
  call dein#add('google/vim-codefmt', { 'merged': 0 })
  call dein#add('google/vim-glaive', { 'merged': 0 })
  call dein#add('google/vim-maktaba', { 'merged': 0 })
  call dein#add('guns/vim-sexp')
  call dein#add('inkarkat/vim-ingo-library')
  call dein#add('inkarkat/vim-visualrepeat')
  call dein#add('inkarkat/vim-SyntaxRange')
  call dein#add('jceb/vim-orgmode')
  call dein#add('jnurmine/Zenburn')
  call dein#add('juanchanco/vim-jbuilder')
  call dein#add('junegunn/fzf', {'path' : '~/.fzf', 'build' : './install --all'})
  call dein#add('junegunn/fzf.vim')
  call dein#add('junegunn/goyo.vim')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('kana/vim-textobj-user')
  call dein#add('lukerandall/haskellmode-vim')
  call dein#add('majutsushi/tagbar')
  call dein#add('mattn/calendar-vim')
  call dein#add('nelstrom/vim-textobj-rubyblock')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('rking/ag.vim')
  call dein#add('ocaml/vim-ocaml')
  call dein#add('osyo-manga/vim-monster')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('scrooloose/vim-space')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-speeddating')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-sexp-mappings-for-regular-people')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('vim-scripts/blockle.vim')
  call dein#add('vim-scripts/CountJump')
  call dein#add('vim-scripts/ConflictMotions')
  call dein#add('vim-scripts/utl.vim')
  call dein#add('wlangstroth/vim-racket')
  call dein#add('regedarek/ZoomWin')
  call dein#add('vim-syntastic/syntastic')
  call dein#add('rust-lang/rust.vim')
  call dein#add('fsharp/vim-fsharp', {
  \ 'build' : 'make fsautocomplete',
  \ 'lazy' : 1,
  \ 'on_ft' : 'fsharp',
  \ })
  call dein#end()
  call dein#save_state()
endif

call glaive#Install()

set completeopt=menuone,menu,longest,preview

" --- Plugin options   --- {{{1

Glaive codefmt plugin[mappings]

let g:esearch = { 'adapter': 'rg' }

let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" --- deoplete --- {{{2
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
      \ 'camel_case': v:true,
      \ 'auto_complete': v:false,
      \ })

" Plugin key-mappings.
inoremap <expr><C-@> deoplete#manual_complete()
inoremap <expr><C-Space> deoplete#manual_complete()
inoremap <expr><C-g>     deoplete#undo_completion()
inoremap <expr><C-l>     deoplete#complete_common_string()

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" --- Language servers --- {{{2
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references({
      \ 'includeDeclaration': v:false})<cr>

let g:LanguageClient_serverCommands = {
    \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
    \ 'ocaml': ['ocamllsp'],
    \ }

" --- Airline configuration {{{2

" air-line
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" }}}

let python_highlight_all = 1

" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

" Enable sexp editing in dune files
let g:sexp_filetypes = 'scheme,lisp,clojure,jbuilder'

" --- Helper functions --- {{{1

" Toggles various listchars options between v1 and v2
function! ToggleLC(v1, v2)
  if &listchars =~ a:v1
    let &listchars = substitute(&listchars, a:v1, a:v2, "")
  elseif &listchars =~ a:v2
    let &listchars = substitute(&listchars, a:v2, a:v1, "")
  endif
endfunction

function! ToggleZenburnContrast()
  let g:zenburn_high_Contrast = g:zenburn_high_Contrast ? 0 : 1
  :colorscheme zenburn
endfunction

command! ZT call ToggleZenburnContrast()

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
noremap  <Leader>dq :set wrap!<CR>

" Zenburn contrast toggle, as I can't ever decide on one.
noremap <Leader>dz :ZT<CR>

" I'm so used to this after using it with VSCode.
noremap <Leader>w :w<CR>

imap <C-a> <C-o>^
imap <C-e> <C-o>$


" Buffer explorer
noremap <silent> <F2> :Buffers<CR>
inoremap <silent> <F2> <C-o><F2>

" Tag list
noremap <silent> <F3> :TagbarToggle<CR>
imap <silent> <F3> <C-o><F3>

" File explorer
noremap <silent> <F4> :VimFilerExplorer<CR>
imap <silent> <F4> <C-o><F4>

" Fuzzy finding
noremap <silent> <Leader>e :Files<CR>
noremap <silent> <C-p> :History<CR>

" Preview tag under cursor
noremap <Leader>k :pclose<CR>

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

  " Recognise .mm files as Objective-C
  autocmd BufRead,BufNewFile *.mm call s:FTmm()

  au FileType c,cpp,cuda,objc setl formatexpr=LanguageClient#textDocument_rangeFormatting()

  " Use ghc functionality for haskell files
  au BufEnter *.hs compiler ghc

  if executable('opam')
    let s:opam = substitute(system('opam config var share'), '\n$', '', '''')
    if executable('ocamlmerlin') && has('python')
      let s:ocamlmerlin = s:opam . "/merlin"
      execute "set rtp+=".s:ocamlmerlin."/vim"
      execute "set rtp+=".s:ocamlmerlin."/vimbufsync"
    endif
    autocmd FileType ocaml execute "set rtp+=" . s:opam . "/ocp-indent/vim/indent/ocaml.vim"
  endif

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


if has("gui_running")
  " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
  let &guioptions = substitute(&guioptions, "t", "", "g")
  set guioptions-=T

  if &diff
    let &columns = 240
    let &lines = 60
  else
    let &columns = 100
    let &lines = 50
  endif
endif

if !has("gui_vimr")
  set guifont=FiraCode-Retina:h14
endif

set background=dark
let g:zenburn_high_Contrast=1
:colorscheme zenburn

" Additional local configuration
let s:localvimrc = expand("~/.vim/localrc")
if filereadable(s:localvimrc)
  silent! execute 'source' s:localvimrc
endif
