call plug#begin('~/AppData/Local/nvim/plugged')
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Powerline without python dependency
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'overcache/NeoSolarized'
" Auto pairs will match parenthesis brackets braces and quotes
Plug 'jiangmiao/auto-pairs'

" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

call plug#end()

" Source .vimrc again after changes
autocmd! bufwritepost .vimrc source %

" Airline configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'default'
syntax enable
" Solarized light colors
set termguicolors
set background=light
colorscheme NeoSolarized

" Remaps
map <F3> :NERDTreeToggle<CR>
map <Leader>\ <ESC>
map <Leader>n :set relativenumber!<CR>

" Command line fuzzy search
set rtp+=/usr/local/opt/fzf
