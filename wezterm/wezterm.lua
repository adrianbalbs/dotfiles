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
config.color_scheme = "kanagawabones"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

config.font = wezterm.font("FiraCode Nerd Font")

config.font_size = 16
config.default_cursor_style = "SteadyUnderline"
config.window_background_opacity = 1.0
config.macos_window_background_blur = 15
config.enable_wayland = true
config.prefer_egl = false
config.initial_cols = 120
config.initial_rows = 40

config.keys = {
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

for i = 1, 8 do
	-- CTRL+ALT + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

-- and finally, return the configuration to wezterm
return config
