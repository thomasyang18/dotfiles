local options = {
  ensure_installed = { "lua", "vim", "vimdoc",
	-- make my pretty markdown work pretty pls :3 
	"markdown", "markdown_inline", "html", "query",
	-- "latex", -- this shit is total ass dont use it, doesnt format nicely at all atm 
	},

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

return options
