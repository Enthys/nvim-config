require('telescope').setup{ 
	defaults = { 
		file_ignore_patterns = { "node%_modules/.*", "package%-lock%.json", "vendor", "dist", ".git" }
	}
}
require('telescope').load_extension("file_browser")

vim.api.nvim_set_keymap(
	"n",
	"<leader>e",
	"<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", 
	{ noremap = true }
)
