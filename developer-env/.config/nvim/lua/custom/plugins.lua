local plugins = {
	-- https://github.com/arnaupv/nvim-devcontainer-cli might be an interesting plugin, but lets learn how to spin up our own docker first....
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons, well I only "prefer" this since nvchad has these by default
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = function()
-- lol			local log_file = io.open("/tmp/logfile.txt", "a")
--			log_file:write("Debug output im going insane fuck \n")
--			log_file:close()
			return require "custom.configs.render-markdown"
		end,
		config = function(_, opts)
			require("render-markdown").setup(opts)
		end,
		lazy=false
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"nvim-neotest/nvim-nio",
		event = "VeryLazy"
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {}
		},
	},
	{
		"mfussenegger/nvim-dap",
		config = function(_, _)
			require("core.utils").load_mappings("dap")
		end
	},
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		opts = function()
			return require "custom.configs.null-ls" -- so like I'm not sure if this should behave like this lol. The docs do say its drop in, and backwards compatibility wont be fucked.... so hopefuly this is fine.
		end,
	},

}
return plugins
