local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 32

config.default_prog = { 'powershell.exe' }
config.launch_menu = {
	{
		label = 'Powershell',
		args = { 'powershell.exe', '-NoLogo'},
	},
	{
		label = 'Ubuntu',
		args = { 'ubuntu2004.exe' }
	}
}

config.audible_bell = 'Disabled'
config.disable_default_key_bindings = true

-- Key bindings
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
	{
		key = 'a',
		mods = 'LEADER|CTRL',
		action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
	},
	{
		key = 's',
		mods = 'LEADER|CTRL',
		action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
	},
	{
		key = 'v',
		mods = 'LEADER|CTRL',
		action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
	},
	{
		key = 'z',
		mods = 'LEADER',
		action = wezterm.action.TogglePaneZoomState
	},
	{
		key = 'c',
		mods = 'LEADER',
		action = wezterm.action.SpawnTab 'CurrentPaneDomain',
	},
	{
		key = '&',
		mods = 'LEADER',
		action = wezterm.action.CloseCurrentTab { confirm = true},
	},
	{
		key = 'x',
		mods = 'LEADER',
		action = wezterm.action.CloseCurrentPane { confirm = true},
	},
	{
		key = 'h',
		mods = 'LEADER|CTRL',
		action = wezterm.action.ActivatePaneDirection 'Left',
	},
	{
		key = 'l',
		mods = 'LEADER|CTRL',
		action = wezterm.action.ActivatePaneDirection 'Right',
	},
	{
		key = 'k',
		mods = 'LEADER|CTRL',
		action = wezterm.action.ActivatePaneDirection 'Up',
	},
	{
		key = 'j',
		mods = 'LEADER|CTRL',
		action = wezterm.action.ActivatePaneDirection 'Down',
	},
	{
		key = 'h',
		mods = 'LEADER',
		action = wezterm.action.AdjustPaneSize { 'Left', 5 },
	},
	{
		key = 'l',
		mods = 'LEADER',
		action = wezterm.action.AdjustPaneSize { 'Right', 5 },
	},
	{
		key = 'k',
		mods = 'LEADER',
		action = wezterm.action.AdjustPaneSize { 'Up', 5 },
	},
	{
		key = 'j',
		mods = 'LEADER',
		action = wezterm.action.AdjustPaneSize { 'Down', 5 },
	},
	{
		key = '-',
		mods = 'LEADER|CTRL',
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = '=',
		mods = 'LEADER|CTRL',
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = '0',
		mods = 'LEADER|CTRL',
		action = wezterm.action.ResetFontSize,
	},
	{
		key = 'c',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.CopyTo 'Clipboard',
	},
	{
		key = 'v',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.PasteFrom 'Clipboard',
	},
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = 'LEADER',
		action = wezterm.action.ActivateTab(i - 1),
	})
end

for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = 'LEADER|CTRL',
		action = wezterm.action.MoveTab(i - 1),
	})
end


-- Appereance
config.color_scheme = 'Nocturnal Winter'
config.font = wezterm.font 'Terminus (TTF) for Windows'
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

return config
