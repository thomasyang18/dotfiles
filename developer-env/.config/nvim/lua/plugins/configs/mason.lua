local options = {
  ensure_installed = { "lua-language-server",-- not an option from mason.nvim
-- custom added, because in core/utils.lua, user preferences override stuff 
		-- which normally would be fine... but mason is a PACKAGE MAANGER not a fucking PREFERENCE jesus CHRIST OML WHATEVER FUCK THIS SHIT 
	"clangd",
		"clang-format",
		"codelldb"
	},
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

return options
