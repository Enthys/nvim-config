call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'APZelos/blamer.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-tree-docs'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-signify'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'tpope/vim-fugitive'
Plug 'navarasu/onedark.nvim'
Plug 'xiyaowong/nvim-transparent'
Plug 'windwp/nvim-autopairs'
call plug#end()

colorscheme onedark
hi CursorLine guibg=#333333
hi Comment guifg=#00ff00

command! -nargs=0 W :w

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

autocmd FileType markdown setlocal shiftwidth=2 expandtab

let g:vim_markdown_folding_disabled = 1
let g:airline#extensions#tabline#enabled = 1

if (empty($TMUX))
	if (has("nvim"))
		"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
		let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
	"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
	" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
	if (has("termguicolors"))
		set termguicolors
	endif
endif

let NERDTreeShowHidden=1
nmap <leader>tt :NERDTreeToggle<cr>
nmap <leader>gb :BlamerToggle<cr>
let g:blamer_delay = 100

" Golang theme configuration for colors

command! -bang -nargs=? -complete=dir HFiles
			\ call fzf#vim#files(<q-args>, {'source': 'find . \( -not -path "./.git/*" ' .
			\   '-and \( -path "./.*" -or -path "./.*/**" \) ' .
			\   '-and \( -type f -or -type l \) ' .
			\ '\) -print | sed "s:^..::"'}, <bang>0)

map <leader>zh :HFiles<CR>

let @c = '0i// j'
let @x = '0xxx'

" NERDTree Configuration
" autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

command! -bang -nargs=? -complete=dir HFiles
			\ call fzf#vim#files(<q-args>, {'source': 'find . \( -not -path "./.git/*" ' .
			\   '-and \( -path "./.*" -or -path "./.*/**" \) ' .
			\   '-and \( -type f -or -type l \) ' .
			\ '\) -print | sed "s:^..::"'}, <bang>0)

map <leader>zh :HFiles<CR>

nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

" Snippet Configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

command! BufOnly execute '%bd|edit #|bd#'
