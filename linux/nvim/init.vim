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

" Toml
Plug 'cespare/vim-toml'
Plug 'mhinz/vim-crates'

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
set background=dark
colorscheme NeoSolarized

" Remaps
map <F3> :NERDTreeToggle<CR>
nnoremap <Leader>n :set relativenumber!<CR>
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Command line fuzzy search
set rtp+=/usr/local/opt/fzf

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
inoremap <expr> <cr> ((pumvisible())?("\<C-y>"):("\<cr>"))

autocmd BufRead Cargo.toml call crates#toggle()

set relativenumber
set number
set pastetoggle=<F2>

let g:clipboard = {
      \   'name': 'clipboard',
      \   'copy': {
      \      '+': 'xclip -sel clip', 
      \      '*': 'xclip -sel clip',
      \   },
      \   'paste': {
      \      '+': 'xclip -sel clip -out',
      \      '*': 'xclip -sel clip -out',
      \   },
      \   'cache_enabled': 1,
      \ }

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

for key in ['<Up>', '<Down>', '<Left>', '<Right>']
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
  exec 'cnoremap' key '<Nop>'
endfor

" Spaces & Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line
" }}} Spaces & Tabs

" Clipboard {{{
set clipboard+=unnamedplus
" }}} Clipboard

