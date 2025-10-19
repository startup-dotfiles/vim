" Base Configuration
" Leader Key
let g:mapleader=' '
" Encoding
set encoding=utf-8
" Tab :https://vim.fandom.com/wiki/Indenting_source_code
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
" Line Number
set number
set relativenumber
" Status Line
set laststatus=2
" Using the mouse
set mouse=a
" Syntax highlighting
syntax on
filetype plugin indent on
" Highlighting search results
" set incsearch   " only first word
set hlsearch  " all words

" Use system clipboard automatically (if available)
" :echo has("clipboard") (0: not suppport, 1: suppport)
" vim --version | grep clipboard (-clipboard: not suppport, +clipboard: suppport)
" set clipboard=unnamedplus
" About more: https://github.com/vim/vim/discussions/17343
set clipboard=unnamed,unnamedplus

" Visual wrapping
autocmd FileType python set breakindentopt=shift:4

" Make File-Open track directory of current file
" https://vim.fandom.com/wiki/Make_File-Open_track_directory_of_current_file
set browsedir=buffer

" Performance
set lazyredraw
set ttyfast
" show color line and column (redraw the screen)
set colorcolumn=80,100
" set cursorcolumn
" set cursorline

set nocompatible    " disable compatilbe with vi
" set nofoldenable    " disable fold text block
" set noswapfile      " disable generate swap file
" set nowrap          " disable automatic line wrapping
set ttimeout
set ttimeoutlen=100

" Fixes
" https://jorenar.com/blog/vim-xdg
set viminfofile=$XDG_STATE_HOME/viminfo

" Misc
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m
    nnoremap <leader>gg :silent! grep <C-R><C-W> .<CR>:copen<CR>:redraw!<CR>
endif

" -------------------------------------------------------------------------------------------------------------------

" Base mappings
" move
noremap <C-J> gj
noremap <C-K> gk
noremap <Down> gj
noremap <Up> gk
" Plugin mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap gd :LspGotoDefinition<CR>
nnoremap gD :LspGotoDeclaration<CR>
nnoremap gi :LspGotoImpl<CR>
nnoremap gt :LspGotoTypeDef<CR>
nnoremap gr :LspShowReferences<CR>
nnoremap gs :LspDocumentSymbol<CR>
nnoremap gS :LspSymbolSearch<CR>
nnoremap K :LspHover<CR>
nnoremap <leader>rn :LspRename<CR>

" -------------------------------------------------------------------------------------------------------------------

" Plugin Management
" auto download plug.vim
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.config/vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/vim/plugged')
    " List your plugins here
    Plug 'tpope/vim-sensible'
    Plug 'godlygeek/tabular'    " text filtering and alignment
    Plug 'preservim/nerdtree'   " file tree explorer
    Plug 'junegunn/fzf'         " fzf integrated with vim
    Plug 'axvr/org.vim'         " Org mode syntax highlighting and folding for Vim

    Plug 'fedorenchik/fasm.vim' " Flat Assembler support for vim
    Plug 'llvm/llvm.vim'        " Vim filetype support for LLVM
    Plug 'yegappan/lsp'         " LSP for vim9
    "Plug 'dense-analysis/ale'  " providing linting (syntax  checking and semantic errors)
    Plug 'skywind3000/asyncrun.vim'  " Run Async Shell Commands in Vim
    Plug 'bfrg/vim-c-cpp-modern'     " Extended Vim syntax highlighting for C and C++(C++11/14/17/20/23)
    Plug 'tpope/vim-commentary' " comment stuff out

    Plug 'vim-airline/vim-airline' " status/tabline for vim
    Plug 'vim-airline/vim-airline-themes' " airline theme

    Plug 'NLKNguyen/papercolor-theme' " Light & Dark Vim color schemes inspired by Google's Material Design
    Plug 'sainnhe/everforest'  " Everforest Theme
call plug#end()

" -------------------------------------------------------------------------------------------------------------------

" Installed plugin configuration
" [papercolor-theme]
" set t_Co=256   " This is may or may not needed.
" set background=dark
" colorscheme PaperColor
" [everforest]
set background=dark
colorscheme everforest

" [fasm.vim]
autocmd BufReadPre *.asm let g:asmsyntax = "fasm"

" [commentary]
" allow comment content that file type isn't supported!
autocmd FileType apache setlocal commentstring=#\ %s

" [nerdtree]
" show lines of files
let g:NERDTreeFileLines = 1
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" [ale]
" Enable completion where available.
" This setting must be set before ALE is loaded.

" You should not turn this setting on if you wish to use ALE as a completion
" source for other completion plugins, like Deoplete.
" let g:ale_completion_enabled = 1
" set omnifunc=ale#completion#OmniFunc " triggering completion manually with <C-x><C-o>

" [lsp]
" Clangd language server
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)
let lspServers = [#{
	\   name: 'clang',
	\   filetype: ['c', 'cpp'],
	\   path: '/usr/bin/clangd',
	\   args: ['--background-index', '--header-insertion=iwyu']
	\ }]
autocmd User LspSetup call LspAddServer(lspServers)

" [vim-c-cpp-modern]
" Disable function highlighting (affects both C and C++ files)
let g:cpp_function_highlight = 0

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Disable highlighting of type names in class, struct, union, enum, using, and
" concept declarations (affects both C and C++ files)
let g:cpp_type_name_highlight = 0

" Highlight operators (affects both C and C++ files)
let g:cpp_operator_highlight = 1

" Put all standard C and C++ keywords under Vim's highlight group 'Statement'
" (affects both C and C++ files)
let g:cpp_simple_highlight = 1

" [fzf]
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - Popup window (center of the screen)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" - Popup window (center of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

" - Popup window (anchored to the bottom of the current window)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }

" - down / up / left / right
" let g:fzf_layout = { 'down': '40%' }

" - Window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'query':   ['fg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
