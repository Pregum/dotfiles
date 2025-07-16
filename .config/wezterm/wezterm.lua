local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("status")
require("format")

-- 基本設定
config.color_scheme = "Catppuccin Mocha"
config.window_background_opacity = 0.95
config.font = wezterm.font("HackGen Console NF")
config.font_size = 14.0
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
config.tab_and_split_indices_are_zero_based = false
config.tab_max_width = 1000

-- キーバインド設定
config.keys = {
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitPane({ direction = "Down" }) },
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{
		key = "[",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Prev"),
	},
	{
		key = "]",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Next"),
	},
	{
		key = "{",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "}",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(1),
	},
}

config.enable_tab_bar = true

-- テーマ切り替え機能を直接update-statusに追加
_G.theme_override_themes = {
	enhance = "Tokyo Night",
	review = "Solarized (light) (terminal.sexy)",
	["develop-lite"] = "GruvboxDark",
	sandbox = "Dracula",
}

return config