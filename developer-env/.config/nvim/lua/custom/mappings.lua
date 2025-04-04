local M = {}

M.general = {
	n = {
    ["<A-j>"] = { "<C-d>", "page down" },
    ["<A-k>"] = { "<C-u>", "page up" },
		["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
		["<leader>tt"] = {
			function()
				require("base46").toggle_theme()
			end,
			"Toggle theme"
		},
	["<leader>to"] = {
		function()
			local opacity = vim.fn.input("opacity[0-100]:")
			os.execute('alacritty msg config window.opacity=' .. opacity/100)
		end,
		"Set opacity to [0-100]%"
	}
	},
}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = {
			"<cmd> DapToggleBreakpoint <CR>",
			"Add breakpoint at line",
		},
		["<leader>dr"] = {
			"<cmd> DapContinue <CR>",
			"Start or continue the debugger",
		}
	}
}


return M
