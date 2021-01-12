call plug#begin('~/AppData/Local/nvim/plugged')
" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Powerline without python dependency
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'overcache/NeoSolarized'
" Auto pairs will match parenthesis brackets braces and quotes
Plug 'jiangmiao/auto-pairs'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'tjdevries/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

" Autosave
Plug '907th/vim-auto-save'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

call plug#end()

" Autosave configuration
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

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

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
inoremap <expr> <cr> ((pumvisible())?("\<C-y>"):("\<cr>"))
