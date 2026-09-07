local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Dark+ (Gogh)"
config.font = wezterm.font_with_fallback({ "MesloLGS NF", "Fira Code" })
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }

return config
