local options = {
  ensure_installed = { "lua", "vim", "vimdoc",
	-- make my pretty markdown work pretty pls :3 
	"markdown", "markdown_inline", "html", "latex", "query",
	},

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

return options
