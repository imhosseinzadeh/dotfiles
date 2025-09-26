" #######################################################
" ##                   General Settings                ##
" #######################################################

" Show line numbers
set number

" Enable mouse support
set mouse=a

" Enable syntax highlighting
syntax enable

" Enable file type detection and load corresponding plugins
filetype plugin on

" Indentation settings
set autoindent      " Copy indent from the previous line
set smartindent     " Make indenting smart (based on syntax)

" Disable default mode display, handled by plugins
set noshowmode

" Reduce delay for CursorHold events to improve plugin responsiveness
set updatetime=1000  " Default is 4000 ms (4s)

" Enhance command-line completion
set wildmenu

" #######################################################
" ##                   Tab Settings                    ##
" #######################################################

" Use 4 spaces for a tab
set expandtab       " Use spaces instead of tabs
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set softtabstop=4   " Number of spaces that a <Tab> counts for while editing
set tabstop=4       " Number of spaces that a <Tab> in the file counts for

" #######################################################
" ##                     Netrw                         ##
" #######################################################

" Configure Netrw plugin
let g:netrw_banner = 0           " Disable banner
let ghregex = '\(^\|\s\s\)\zs\.\S\+' " Regex to hide dotfiles
let g:netrw_list_hide = ghregex  " Hide dotfiles by default
let g:netrw_liststyle = 3        " Use tree-style listing

" #######################################################
" ##                  Plugin Management                 ##
" #######################################################

call plug#begin('~/.vim/plugged')

" Status line and theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Commenting
Plug 'tpope/vim-commentary' " Comment Stuff out

" Buffers
Plug 'tpope/vim-unimpaired' " Pairs of handy bracket mappings 

" Git integration
Plug 'airblade/vim-gitgutter'    " Show git changes in gutter
Plug 'tpope/vim-fugitive'        " In-editor Git commands

call plug#end()

" #######################################################
" ##                Plugin Settings                     ##
" #######################################################

" gitgutter
highlight GitGutterAdd    guifg=#009900 ctermfg=Green   " Additions
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow  " Modifications
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red     " Deletions
let g:gitgutter_map_keys = 0                            " Disable default key mappings

" vim-airline
let g:airline_powerline_fonts = 1   " Use Powerline fonts if available
let g:airline_theme='minimalist'    " Set the Airline theme
