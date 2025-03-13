local plugins = {
{
  "arnaupv/nvim-devcontainer-cli",
  opts = {
    -- By default, if no extra config is added, following nvim_dotfiles are
    -- installed: "https://github.com/LazyVim/starter"
    -- This is an example for configuring other nvim_dotfiles inside the docker container
    nvim_dotfiles_repo = "https://github.com/thomasyang18/dotfiles.git",
    nvim_dotfiles_install_command = "cd ~/nvim_dotfiles/ && ./install.sh",
	nvim_dotfiles_branch = "master", -- they didnt even provide a proper install...
	-- In case you want to change the way the devenvironment is setup, you can also provide your own setup
    setup_environment_repo = "https://github.com/arnaupv/setup-environment",
    setup_environment_install_command = "./install.sh -p 'nvim stow zsh'",
  },
  keys = {
    -- stylua: ignore
    {
      "<leader>cdu",
      ":DevcontainerUp<cr>",
      desc = "Up the DevContainer",
    },
    {
      "<leader>cdc",
      ":DevcontainerConnect<cr>",
      desc = "Connect to DevContainer",
    },
  }
},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		opts = {
			workspaces = {
				{
					name = "gaming_binder",
					path = "~/Documents/obsidian_notes/gamingbinder/",
				}, 
				{
					name = "reading_binder",
					path = "~/Documents/obsidian_notes/reading-notes/"
				}
			},

			-- see below for full list of options 👇
		},
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
	{
		"neovim/nvim-lspconfig",
		config = function()
			require "plugins.configs.lspconfig"
			require "custom.configs.lspconfig"
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"clangd",
				"clang-format",
				"codelldb",
			}
		}
	}
}
return plugins
