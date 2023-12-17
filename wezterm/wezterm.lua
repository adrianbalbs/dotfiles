-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night Moon"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("FantasqueSansM Nerd Font")

config.font_size = 18
config.default_cursor_style = "SteadyUnderline"
config.window_background_opacity = 1.0
config.macos_window_background_blur = 15
config.enable_wayland = true
config.prefer_egl = false
config.initial_cols = 120
config.initial_rows = 40
-- and finally, return the configuration to wezterm
return config
