---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "penumbra_dark",  -- Set the default theme to penumbra dark
  theme_toggle = { "penumbra_light", "penumbra_dark" },  -- Toggle between the light and dark themes
  transparency = true,  -- Enable transparency for both themes
}

M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

return M
