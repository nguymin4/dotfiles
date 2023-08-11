local wezterm = require 'wezterm'
local os = require 'os'

local color_scheme = "OneHalfDark"
local scheme = wezterm.get_builtin_color_schemes()[color_scheme]
local solid_right_arrow = utf8.char(0xe0b0)

function tab_title(tab)
  local title = tab.tab_title
  -- If the tab title is explicitly set, take that
  if title and #title > 0 then
    return tab.tab_index .. ':' .. tab.tab_title
  end
  return tab.tab_index .. ':'
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Background = { Color = scheme.ansi[5] } },
        { Foreground = { Color = scheme.background } },
        { Text = solid_right_arrow },
        { Background = { Color = scheme.ansi[5] } },
        { Foreground = { Color = scheme.ansi[8] } },
        { Text = ' ' .. title .. ' ' },
        { Background = { Color = scheme.background } },
        { Foreground = { Color = scheme.ansi[5] } },
        { Text = solid_right_arrow },
      }
    end
    return {
      { Background = { Color = scheme.background } },
      { Foreground = { Color = scheme.ansi[8] } },
      { Text = '  ' .. title .. ' ' },
      { Foreground = { Color = scheme.background } },
      { Text = solid_right_arrow },
    }
  end
)

local act = wezterm.action

local function is_vi_process(pane)
  -- On Windows this is the only way to check
  local info = pane:get_foreground_process_info()

  local parent = wezterm.procinfo.get_info_for_pid(info.ppid)
  if parent.name:find('n?vim') ~= nil then
    return true
  end

  -- Traverse the ps tree
  local next_pid = info.pid
  while next_pid ~= nil do
    local children = wezterm.procinfo.get_info_for_pid(next_pid).children
    local child_pid, child = next(children)
    next_pid = child_pid
    if child ~= nil and child.name:find('n?vim') ~= nil then
      return true
    end
  end
  return false
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
  if is_vi_process(pane) then
    window:perform_action(
      -- This should match the keybinds you set in Neovim.
      act.SendKey({ key = vim_direction, mods = 'CTRL' }),
      pane
    )
  else
    window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
  conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
  conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
  conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
  conditionalActivatePane(window, pane, 'Down', 'j')
end)

return {
  default_prog = { 'pwsh' },
  color_scheme = color_scheme,
  font = wezterm.font("UbuntuMono Nerd Font Mono"),
  font_size = 12,
  bold_brightens_ansi_colors = "BrightOnly",
  window_decorations = "RESIZE",
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  window_padding = {
    left = 5, right = 5,
    top = 5, bottom = 5,
  },
  leader = { key="b", mods="CTRL" },
  keys = {
    { key = "b", mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
    { key = "%", mods = "LEADER|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key = "\"", mods = "LEADER|SHIFT",action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "s", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "v", mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key = "o", mods = "LEADER",       action="TogglePaneZoomState" },
    { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
    { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    -- { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
    -- { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
    -- { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
    -- { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = 'h', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-left') },
    { key = 'j', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-down') },
    { key = 'k', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-up') },
    { key = 'l', mods = 'CTRL', action = act.EmitEvent('ActivatePaneDirection-right') },
    { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
    { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
    { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
    { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
    { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
    { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
    { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
    { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
    { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
    { key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
    { key = "n", mods = "LEADER",       action=wezterm.action{ActivateTabRelative=1}},
    { key = "p", mods = "LEADER",       action=wezterm.action{ActivateTabRelative=-1}},
    { key = "&", mods = "LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
    { key = "d", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
    { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
  },
}
