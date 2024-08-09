-- Pull in the wezterm API
local wezterm = require("wezterm")

-- これはコンフィギュレーションを保持する
local config = {}

-- より新しいバージョンの wezterm では、config_builder を使用することで、より明確なエラーメッセージを提供できます
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- ここで、設定した内容を実際に適用する
config.color_scheme = "Catppuccin Macchiato" -- 配色を変える
config.window_background_opacity = 0.75 -- Window の背景を調節
config.font_size = 14 -- font size
config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {
	{ key = "t", mods = "CMD", action = act.SpawnTab("DefaultDomain") }, -- create new tab
	{ key = "x", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) }, -- close tab
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "[", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "]", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
}

-- 時間のフォーマットを設定
wezterm.time.now():format("%Y-%m-%d %H:%M:%S")

-- そして最後に、設定をweztermに返す
return config
