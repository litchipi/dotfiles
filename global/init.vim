call plug#begin()
" Tags
Plug 'majutsushi/tagbar'

" Coloscheme
Plug 'ghifarit53/tokyonight-vim'

" Highlight current line in current window
Plug 'miyakogi/conoline.vim'

" Bottom bar
Plug 'reedes/vim-colors-pencil'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" File nav
Plug 'scrooloose/nerdtree'

" Bulk commenter
Plug 'preservim/nerdcommenter'

" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Code linter
Plug 'sbdchd/neoformat'

" Workspace search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'

" Zoom a particular window pane
Plug 'markstory/vim-zoomwin'

" Git signs on left bar
Plug 'airblade/vim-gitgutter'

" LaTeX writing
Plug 'lervag/vimtex'

" Delete Buffer without messing up the layout
Plug 'moll/vim-bbye'

" Display a bar for each indentation step
Plug 'Yggdroot/indentLine'

" Vim pluggin for Haskell syntax highlighting
Plug 'neovimhaskell/haskell-vim'

" Load vim sessions at startup
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'

Plug 'cespare/vim-toml'
Plug 'nickel-lang/vim-nickel'
Plug 'LnL7/vim-nix'

Plug 'tpope/vim-fugitive'
call plug#end()

filetype plugin indent on

" GENERAL OPTIONS
set completeopt=noinsert,menuone,noselect
set undofile
set shortmess+=c

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_map_keys = 0

highlight SignColumn guibg=None
set noswapfile

if &encoding != 'utf-8'
    set encoding=utf-8              "Necessary to show Unicode glyphs
endif

set mouse=a
"set autoindent
"set smartindent
set shiftwidth=4
"set tabstop=4
"set softtabstop=4
set scrolloff=10
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

"Command executed when saving
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

set sessionoptions-=help
set sessionoptions-=options
set sessionoptions-=blank

let g:session_verbose_messages = 0
let g:session_default_name = fnamemodify(getenv('PWD'), ':p')

if argc() == 0 
	au BufWritePost * exe ":SaveSession! ".fnamemodify(getenv('PWD'), ':p')
	au VimEnter * exe ":OpenSession! ".fnamemodify(getenv('PWD'), ':p')
	au VimLeave * exe ":SaveSession! ".fnamemodify(getenv('PWD'), ':p')
end

" INTERFACE
set termguicolors     " enable true colors support
syntax on

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1

colorscheme tokyonight
let g:airline_theme = "tokyonight"

set number                  " add line numbers
let g:indentLine_setColors = 1
let g:indentLine_color_term = 1
let g:indentLine_char = '┊'
set cc=100

set wildmode=longest,list   " get bash-like tab completions

highlight ColorColumn guibg=None
highlight Comment guifg=#367e6f

highlight LineNr guifg=#149477
highlight CursorLineNR gui=bold guifg=#0bd4a7
highlight Pmenu ctermbg=8 guibg=#606060
highlight PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6
highlight VertSplit gui=NONE guifg=NONE guibg=NONE

highlight Search guibg=NONE guifg=#ffc453 gui=underline,bold
highlight QuickFixLine gui=NONE guibg=NONE guifg=#ffc453
highlight TODO guibg=NONE guifg=#dd5dc4 gui=underline,bold

let g:syntastic_enable_signs = 1
let g:syntastic_quiet_messages = {
    \ "type":    "style"}

" KEYBOARD
function! SetKeybindings()
let g:mapleader = '$'

noremap <leader><Space> :nohlsearch<CR>

noremap <leader>z :enew<CR>
noremap <leader>s :Bwipeout<CR>

" Overwrite ?
noremap <leader>d :bnext<CR>
noremap <leader>q :bprevious<CR>

noremap <leader>m :TagbarToggle<CR>
noremap <leader>p :NERDTreeToggle<CR>
noremap <leader>o :call nerdcommenter#Comment("x", "toggle")<CR>
noremap <Tab> <C-w>w

noremap <leader>& :GFiles<CR>
noremap <leader>1 :Files<CR>
noremap <leader>é :Rg<CR>
noremap <leader>f :Buffers<CR>
noremap <leader>c :BCommits<CR>

noremap <A-q> h
noremap <A-s> j
noremap <A-d> l
noremap <A-z> k

noremap <A-a> :bprevious<CR>
noremap <A-e> :bnext<CR>
noremap <A-&> :lnext<CR>
noremap <A-"> :lprevious<CR>

noremap <A-S-z> 5k
noremap <A-S-q> b
noremap <A-S-d> w
noremap <A-S-s> 5j

noremap <A-r> :wincmd c<CR>
noremap <leader>r :vsplit<CR>
noremap <leader>t :split<CR>
noremap <A-f> :ZoomToggle<CR>

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> eg <Plug>(coc-diagnostic-prev)
nmap <silent> ag <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>i <Plug>(coc-rename)

nnoremap <leader>a :<C-u>CocFzfList diagnostics<CR>
nnoremap <leader>g  :<C-u>CocFzfList commands<CR>
nnoremap <leader>e  :<C-u>CocFzfList outline<CR>
nnoremap <leader>²  :<C-u>CocFzfList symbols<CR>

noremap <leader>" :set number!<CR>
endfunction

" Autocommands
autocmd VimEnter * :call SetKeybindings()
autocmd InsertLeave * write
autocmd BufWinEnter * filetype detect
autocmd VimEnter * filetype detect
autocmd BufWritePost * GitGutter

"COC 
highlight CocHintSign guifg=#006532 gui=italic
autocmd User CocOpenFloat call nvim_win_set_config(g:coc_last_float_win, {'relative': 'editor', 'row': 1, 'col': 130})

"set clipboard
set clipboard+=unnamedplus

" LSP
let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support

" AIRLINE (STATUS BAR & THEME)
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#syntastic#enabled = 1

" NEOFORMAT (FORMATTING)
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

" NERD Commenter
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {'c': { 'left': '//' }, 'haskell': {'left':'--'}}

" OcaMl
if executable('opam')
  let g:opamshare=substitute(system('opam config var share'),'\n$','','''')
  if isdirectory(g:opamshare."/merlin/vim")
    execute "set rtp+=" . g:opamshare."/merlin/vim"
  endif
endif
