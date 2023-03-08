set statusline=%f\ %l\:%c
" set relativenumber
set number
set cursorline
set tabstop=4
set shiftwidth=4
set nowrap
set linebreak
" set whichwrap+=>,l " Move to next line if on end of line
" set whichwrap+=<,h " Move to previous line if at beggining of line
set scrolloff=10
set noswapfile
set smartindent
set colorcolumn=120
set nobackup
set nowritebackup
set mouse=

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
syntax on

call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'APZelos/blamer.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'nsf/gocode', { 'tag': 'v.20150302', 'rtp': 'vim' }
" Plug 'lukas-reineke/indent-blankline.nvim'
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
Plug 'natecraddock/workspaces.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'EdenEast/nightfox.nvim'
Plug 'navarasu/onedark.nvim'
Plug 'xiyaowong/nvim-transparent'
Plug 'windwp/nvim-autopairs'
call plug#end()

" ---------------------------------------------------------------
" ---------------------------------------------------------------
" ---------------------------------------------------------------
" ---------------------------------------------------------------
" ---------------------------------------------------------------
" ---------------------------------------------------------------
" ---------------------------------------------------------------
" ---------------------------------------------------------------
" ---------------------------------------------------------------
lua << EOF
require('nvim-autopairs').setup({})
require('nightfox').setup({
			\ options = {
			\ styles = {
			\ comments = "italic"
			\ }
			\ }
			\ })

require('onedark').load({})

require('material').setup({
			\ contrast = {
			\ terminal = true,
			\ sidebars = true,
			\ floating_windows = true,
			\ cursor_line = true,
			\ non_current_windows = true,
			\ }
			\ })

require('telescope').setup{ 
	defaults = { 
		file_ignore_patterns = { "node%_modules/.*", "package%-lock%.json", "vendor", "dist", ".git" }
	}
}
require('telescope').load_extension("file_browser")
EOF

let g:material_style = "deep ocean"

colorscheme onedark
hi CursorLine guibg=#333333

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ coc#pum#visible() ? coc#pum#next(1):
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :sp<CR><Plug>(coc-definition)<c-w>j
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [B :bp<CR>
nmap <silent> ]B :bn<CR>


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

autocmd FileType go autocmd BufWritePre <buffer> call CocAction('format')

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end



" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

command! -nargs=0 W :w

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

autocmd FileType markdown setlocal shiftwidth=2 expandtab

let g:vim_markdown_folding_disabled = 1

nmap <silent> <C-t>n :TestNearest<CR>
nmap <silent> <C-t>f :TestFile<CR>
nmap <silent> <C-t>a :TestSuite<CR>
nmap <silent> <C-t>l :TestLast<CR>
nmap <silent> <C-t>v :TestVisit<CR>

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


nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" nmap <leader>tt :NvimTreeToggle<cr>
let NERDTreeShowHidden=1
nmap <leader>tt :NERDTreeToggle<cr>
nmap gD :CocDiagnostics<cr>

lua vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", {noremap = true})

lua require('workspaces').setup({
			\ hooks = { open = { "NERDTree" } },
			\ global_cd = true 
			\ })

nmap <leader>gb :BlamerToggle<cr>
let g:blamer_delay = 100

" Golang theme configuration for colors
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_auto_type_info =1
let g:go_fmt_autosave = 1
let g:go_mod_fmt_autosave = 1
let g:go_gopls_enabled = 1
let g:go_doc_balloon = 1

highlight Comment guifg=#00ff00


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

" Use K to show documentation in preview window.
" nnoremap <silent> K :call ShowDocumentation()<CR>
" 
" function! ShowDocumentation()
"   if CocAction('hasProvider', 'hover')
"     call CocActionAsync('doHover')
"   else
"     call feedkeys('K', 'in')
"   endif
" endfunction
let g:go_doc_keywordprg_enabled = 0
nmap <silent> K :call CocActionAsync('doHover')<CR>
map <leader>dt :CocCommand docthis.documentThis<CR>
nmap <silent> <Leader>fc :call CocAction('format')<CR>

lua require("transparent").setup({ enable = true })

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" Snippet Configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

command! BufOnly execute '%bd|edit #|bd#'
