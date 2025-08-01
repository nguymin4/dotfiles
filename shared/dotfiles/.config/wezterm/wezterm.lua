local wezterm = require('wezterm')

local dark_theme = {
  ansi = {
    "#2f343f",
    "#e06c75",
    "#98c379",
    "#e5c07b",
    "#729fcf",
    "#a872cf",
    "#729fcf",
    "#5c6370",
  },
  brights = {
    "#5d696d",
    "#e06c75",
    "#98c379",
    "#e5c07b",
    "#729fcf",
    "#a872cf",
    "#729fcf",
    "#eeeeec",
  },
  background = "#2f343f",
  foreground = "#eeeeec",
  cursor_bg = "#ffffff",
  cursor_border = "#ffffff",
  cursor_fg = "#2f343f",
  selection_bg = "#474e5d",
  selection_fg = "#dcdfe4",
}

local light_theme = {
  ansi = {
    "#5a606d",
    "#d05858",
    "#608e32",
    "#dba94a",
    "#5079be",
    "#b05ccc",
    "#3a8b84",
    "#dde2e7",
  },
  brights = {
    "#4b505b",
    "#d05858",
    "#608e32",
    "#dba94a",
    "#5079be",
    "#b05ccc",
    "#3a8b84",
    "#bac3cb",
  },
  background = "#fafafa",
  foreground = "#4b505b",
  cursor_bg = "#5a606d",
  cursor_border = "#5a606d",
  cursor_fg = "#fafafa",
  selection_bg = "#d6d6d6",
  selection_fg = "#4d4d4c",
}

local current_theme = dark_theme
local is_darwin = wezterm.target_triple:find('darwin') ~= nil

return {
  automatically_reload_config = true,
  colors = current_theme,
  bold_brightens_ansi_colors = 'BrightAndBold',

  -- Font settings
  font = wezterm.font('UbuntuMono Nerd Font Mono'),
  font_rules = {
    {
      intensity = 'Bold',
      italic = false,
      font = wezterm.font({
        family = 'UbuntuMono Nerd Font Mono',
        weight = 'Bold'
      }),
    },
    {
      intensity = 'Bold',
      italic = true,
      font = wezterm.font({
        family = 'UbuntuMono Nerd Font Mono',
        weight = 'Bold',
        italic = true
      }),
    },
  },
  font_size = is_darwin and 16 or 12,
  freetype_load_flags = 'NO_HINTING',
  freetype_load_target = 'Normal',

  -- Window settings
  enable_tab_bar = false,
  enable_scroll_bar = false,
  window_close_confirmation = 'NeverPrompt',
  window_decorations = is_darwin and 'RESIZE|MACOS_FORCE_DISABLE_SHADOW' or 'RESIZE',
  window_background_opacity = current_theme == dark_theme and 0.9 or 1.0,
  macos_window_background_blur = 20,
  window_padding = {
    left = 2,
    right = 2,
    top = 6,
    bottom = 6,
  },

  -- Keybindings
  keys = {
    {
      key = 'Space',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.ActivateCopyMode,
    },
  }
}
