call plug#begin('~/.config/nvim/plugged')
" Git stuff (2)
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" FZF (fuzzy searching)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" For awesome snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories = ['/users/bhalsted/.config/nvim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"
" defaults to c-j and c-k
" let g:UltiSnipsJumpForwardTrigger="<c-n>"
" let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsEditSplit="vertical"
" Common language snippets
Plug 'honza/vim-snippets'

" Language Server
"Plug 'dense-analysis/ale'
"let g:ale_elixir_elixir_ls_release = $HOME . '/.language_servers/.elixir'

" from https://github.com/w0rp/ale/issues/2261
"let g:ale_linters = {
"\  'elixir': ['credo', 'dialyxir', 'elixir-ls'],
"\}

"let g:ale_fixers = {
"\  '*': ['remove_trailing_lines', 'trim_whitespace'],
"\  'elixir': ['mix_format'],
"\}

" The status bar
Plug 'itchyny/lightline.vim'
let g:lightline = { 
      \  'colorscheme': 'challenger_deep',
      \  'active': {
      \    'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
      \  },
      \  'inactive': {
      \    'left': [['relativepath']],
      \  }
      \}

" Cool color theme
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

" Neomake
Plug 'neomake/neomake'
let g:neomake_rust_cargo_command = ['test', '--no-run']
" to auto open the location list
"let g:neomake_open_list = 2

" Rust
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

" Elixir (next 3)
"Plug 'elixir-lang/vim-elixir'
"Plug 'thinca/vim-ref'
"Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }

" CTags
" Plug 'ludovicchabant/vim-gutentags'

call plug#end()

set encoding=utf-8
set termencoding=utf-8
set termguicolors

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" For line numbers in the gutter (easy 15j 13k jumping)
set relativenumber
set number
set number relativenumber

" So that gutter markers appear quicker
set updatetime=100

set ignorecase
set cursorline

syntax on

colorscheme challenger_deep

inoremap c. <ESC>:w<CR>
nnoremap c. <ESC>:w<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,f :Files<CR>
nnoremap ,s :BLines<CR>
nnoremap ,l :Lines<CR>
nnoremap ,m :Marks<CR>
nnoremap ,a :Ag<CR>
nnoremap ,r :Rg<CR>
nnoremap ,qo :copen<CR>
nnoremap ,qn :cnext<CR>
nnoremap ,qp :cprev<CR>
nnoremap ,qq :cclose<CR>
nnoremap ,lo :lopen<CR>
nnoremap ,ln :lnext<CR>
nnoremap ,lp :lprev<CR>
nnoremap ,lq :lclose<CR>

" delete the current buffer, but not the split
nmap ,d :b#<bar>bd#<CR>

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" strip whitespace at the end of a line
"autocmd BufWritePre *.js %s/\s\+$//e
"autocmd BufWritePre *.rs %s/\s\+$//e

" Remap C-x C-o to C-Space (for triggering autocomplete)
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

"autocmd BufReadPost *.rs setlocal filetype=rust

" Use ALE and also some plugin 'foobar' as completion sources for all code.
"let g:deoplete#sources = {'elixir': ['ale']}

" https://github.com/neomake/neomake
function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  endif
  return 0
endfunction

if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nw', 1000)
endif
