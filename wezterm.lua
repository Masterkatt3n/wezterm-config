-- "~/.config/wezterm/wezterm.lua"

local wezterm = require("wezterm")
local act = wezterm.action

----------------------------------------------------------
-- Path resolution
----------------------------------------------------------
local home = wezterm.home_dir
local wezdir = home .. "/.config/wezterm"

-- Extend Lua module search path for `require("color_schemes")`, etc.
package.path = package.path .. (";%s/?.lua;%s/?/init.lua"):format(wezdir, wezdir)

----------------------------------------------------------
-- Load color scheme list
----------------------------------------------------------
local ok, color_schemes = pcall(require, "color_schemes")
if not ok then
	wezterm.log_error("Failed to load color_schemes.lua: " .. tostring(color_schemes))
	color_schemes = { "Builtin Dark" }
end

----------------------------------------------------------
-- Theme persistence
----------------------------------------------------------
local scheme_file = wezdir .. "/.wezterm-current-scheme"
local scheme_index = 1

local function read_saved()
	local f = io.open(scheme_file, "r")
	if not f then
		return nil
	end
	local line = f:read("*l")
	f:close()
	return line
end

local function write_saved(name)
	local f = io.open(scheme_file, "w")
	if f then
		f:write(name .. "\n")
		f:close()
	end
end

-- Restore last saved scheme
local saved = read_saved()
if saved then
	for i, name in ipairs(color_schemes) do
		if name == saved then
			scheme_index = i
			break
		end
	end
end

----------------------------------------------------------
-- Events
----------------------------------------------------------
wezterm.on("toggle-color-scheme", function(window, _)
	scheme_index = scheme_index + 1
	if scheme_index > #color_schemes then
		scheme_index = 1
	end

	local scheme = color_schemes[scheme_index]
	write_saved(scheme)

	window:set_config_overrides({
		color_scheme = scheme,
	})

	window:toast_notification("WezTerm Theme", scheme, nil, 2500)
end)

-- Display PowerShell version + ADMIN marker in status area
wezterm.on("update-right-status", function(window, pane)
	local is_admin = wezterm.is_process_elevated and wezterm.is_process_elevated()
	local admin_flag = (is_admin and wezterm.target_triple:find("windows")) and " [ADMIN]" or ""

	local ps_version = pane:get_user_vars().PSVersion or ""
	window:set_right_status(" " .. ps_version .. admin_flag)
end)

----------------------------------------------------------
-- MAIN CONFIG
----------------------------------------------------------
return {
	dpi = 288, -- your preferred DPI

	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

	--------------------------------------------------------
	-- Fonts
	--------------------------------------------------------
	font = wezterm.font_with_fallback({
		"JetBrainsMono Nerd Font Mono",
		"FiraCode Nerd Font Mono",
		"MesloLGS Nerd Font Mono",
	}),
	font_size = 10.0,

	--------------------------------------------------------
	-- Appearance
	--------------------------------------------------------
	window_background_opacity = 0.92,
	window_decorations = "RESIZE",
	color_scheme = saved or color_schemes[scheme_index],

	window_background_image = wezdir .. "/background/background.png",
	colors = {
		background = "#11121d", --Optional, override to constantly dim brighter colorschemes
	},

	--------------------------------------------------------
	-- Shell (auto-cross-platform)
	--------------------------------------------------------
	default_prog = wezterm.target_triple:find("windows") and { "pwsh", "-NoLogo" } or { "/usr/bin/env", "bash" },

	--------------------------------------------------------
	-- Keybindings
	--------------------------------------------------------
	keys = {
		{ key = "T", mods = "CTRL|SHIFT", action = act.EmitEvent("toggle-color-scheme") },
		{ key = "I", mods = "CTRL|SHIFT", action = act.EmitEvent("show-config-info") },
		{ key = "R", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
	},

	--------------------------------------------------------
	-- Mouse
	--------------------------------------------------------
	mouse_bindings = {
		{
			event = { Down = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = act.PasteFrom("Clipboard"), --Highlight <text>, paste it by clicking once
		},
	},

	---------------------------------------------------------
	-- SSH
	---------------------------------------------------------
	-- ssh_domains = {
	-- 	{
	-- 		name = "",
	-- 		remote_address = "",
	-- 		username = "",
	-- 		ssh_option = {
	-- 			port = "22",
	-- 			identity_file = "",  -- Example: "C:\\Users\\<you>\\.ssh\\id_ed25519",
	-- 		},
	-- 	},
	-- },

	--------------------------------------------------------
	-- Environment
	--------------------------------------------------------
	set_environment_variables = {
		DOTNET_CLI_TELEMETRY_OPTOUT = "1",
	},

	window_frame = {
		font_size = 10.0,
	},
}
