local M = {
    "ellisonleao/gruvbox.nvim",
	name = 'gruvbox',
    lazy = false,
    priority = 1000,
	config = function()
		vim.o.background = "light"
		vim.cmd([[colorscheme gruvbox]])
	end
}

return M
