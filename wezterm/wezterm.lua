-- :::
-- :::: sample.lua ::::
-- ::::::::::::::::::::::
-- 
-- Author:      @espadonne (mfw)
-- Description: just my wezterm config.
--              but it's decorated for use with
--              my lil PyQt6 widget, wezztershier.
--              That tool looks at a WezTerm config with decorations
--              of my pleasing, and allows live editing of the terminal
--              emulator's visual effects via PyQT6 gui.
-- 


-- :::
-- :::: BOILERPLATE ::::
-- :::::::::::::::::::::::
-- 
local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end


-- :::
-- :::: TUNER FOR WEZZTERSHIER ::::
-- ::::: :::::::::::::::::::::: :::::

-- <<TUNER-START>>
-- @ui: slider(min=10, max=42, step=1) type=int
config.font_size = 18

-- @ui: select(options="Birds of Paradise,Gotham (terminal.sexy),Grape,Grass,Hardcore (base16),hardhacker,Harmonic16 Dark (base16),Harper (Gogh),HaX0R_BLUE,Heetch Dark (base16),Hemisu Dark (Gogh),Highway,Highway (Gogh),Hivacruz,Hopscotch,Hybrid (Gogh),Ibm 3270 (High Contrast) (Gogh),Ic Orange Ppl (Gogh),IC_Orange_PPL,Ivory Dark (terminal.sexy),Jackie Brown,Japanesque,JetBrains Darcula,jmbi (terminal.sexy)") type=string
config.color_scheme = "jmbi (terminal.sexy)"

-- @ui: select(options="JetBrains Mono, Fira Code, Cascadia Code, Source Code Pro, Hack, Consolas, Monaco, Menlo, DejaVu Sans Mono, Ubuntu Mono, Roboto Mono, IBM Plex Mono, Inconsolata") type=string
config.font = wezterm.font("JetBrains Mono")

-- @ui: numerical(min=0.5, max=5.5, step=0.01) type=float
config.line_height = 1.29

-- @ui: numerical(min=0.5, max=2.0, step=0.1) type=float
config.cell_width = 1.0

-- @ui: slider(min=0.05, max=1.0, step=0.01) type=float
config.window_background_opacity = 1.0

-- @ui: slider(min=1, max=100, step=1) type=int
config.macos_window_background_blur = 100

-- @ui: color_picker(format="hex", alpha=false) type=color
config.colors = config.colors or {}
config.colors.background = "#333333"

-- @ui: color_picker(format="hex", alpha=false) type=color
config.colors = config.colors or {}
config.colors.tab_bar = config.colors.tab_bar or {}
config.colors.tab_bar.background = "#333333"

-- @ui: color_picker(format="hex", alpha=false) type=color
config.colors = config.colors or {}
config.colors.tab_bar = config.colors.tab_bar or {}
config.colors.tab_bar.active_tab = config.colors.tab_bar.active_tab or {}
config.colors.tab_bar.active_tab.bg_color = "#444444"

-- @ui: color_picker(format="hex", alpha=false) type=color
config.colors = config.colors or {}
config.colors.tab_bar = config.colors.tab_bar or {}
config.colors.tab_bar.active_tab = config.colors.tab_bar.active_tab or {}
config.colors.tab_bar.active_tab.fg_color = "#ffffff"

-- @ui: color_picker(format="hex", alpha=false) type=color
config.colors = config.colors or {}
config.colors.tab_bar = config.colors.tab_bar or {}
config.colors.tab_bar.inactive_tab = config.colors.tab_bar.inactive_tab or {}
config.colors.tab_bar.inactive_tab.bg_color = "#333333"

-- @ui: color_picker(format="hex", alpha=false) type=color
config.colors = config.colors or {}
config.colors.tab_bar = config.colors.tab_bar or {}
config.colors.tab_bar.inactive_tab = config.colors.tab_bar.inactive_tab or {}
config.colors.tab_bar.inactive_tab.fg_color = "#888888"

-- @ui: slider(min=0, max=2000, step=100) type=int
config.cursor_blink_rate = 500

-- @ui: select(options="true, false") type=string
config.hide_tab_bar_if_only_one_tab = true

-- @ui: select(options="NONE, RESIZE, TITLE, RESIZE|TITLE") type=string
config.window_decorations = "RESIZE|TITLE"

-- @ui: select(options="true, false") type=string
config.pane_focus_follows_mouse = false

-- @ui: select(options="true, false") type=string
config.native_macos_fullscreen_mode = true

-- @ui: numerical(min=100, max=10000, step=100) type=int
config.scrollback_lines = 3500

-- @ui: select(options="true, false") type=string
config.enable_scroll_bar = true

-- @ui: slider(min=1, max=60, step=1) type=int
config.animation_fps = 60

-- @ui: slider(min=1, max=120, step=1) type=int
config.max_fps = 60

-- @ui: select(options="true, false") type=string
config.tab_bar_at_bottom = false

-- @ui: numerical(min=50, max=500, step=10) type=int
config.tab_max_width = 200

-- @ui: select(options="SystemBeep, Disabled") type=string
config.audible_bell = "SystemBeep"

-- @ui: select(options="true, false") type=string
config.hide_mouse_cursor_when_typing = true

-- @ui: select(options="true, false") type=string
config.swallow_mouse_click_on_window_focus = false

-- @ui: select(options="true, false") type=string
config.debug_key_events = false

-- <<TUNER-END>>


-- :::
-- :::: DYNAMICS :: the spice of life ::::
-- ::::: ::::::::::::::::::::::::::::: :::::
-- 
-- NOTE:  just a clock for now lol, and I hide
--        it most of the time, too ..lol
wezterm.on("update-right-status", function(window, pane)
  local date = wezterm.strftime("  %Y-%m-%d %H:%M:%S    ")
  window:set_right_status(date)
end)


-- :::
-- :::: KEYBINDS :: my onetrue ::::
-- ::::: :::::::::::::::::::::: :::::
-- 

config.key_tables = {
  resize = {
    { key="Escape",     action = "PopKeyTable" },
    { key="UpArrow",    action = wezterm.action.AdjustPaneSize{"Up", 2} },
    { key="DownArrow",  action = wezterm.action.AdjustPaneSize{"Down",2} },
    { key="LeftArrow",  action = wezterm.action.AdjustPaneSize{"Left", 2} },
    { key="RightArrow", action = wezterm.action.AdjustPaneSize{"Right", 2} },
  },

  utility = {
    { key="c", action = wezterm.action.ActivateCopyMode },
    { key="Escape", action = wezterm.action.ReloadConfiguration },
    {
      key = "b",
      action = wezterm.action_callback(function(win)
        local o = win:get_config_overrides() or {}
        o.hide_tab_bar_if_only_one_tab = not o.hide_tab_bar_if_only_one_tab
        win:set_config_overrides(o)
      end),
    },
    {
      key = "l", mods = "CMD|SHIFT",
      action = wezterm.action_callback(function(win)
        local o = win:get_config_overrides() or {}
        o.enable_scroll_bar = not o.enable_scroll_bar
        win:set_config_overrides(o)
      end),
    },
  },

  tabular = {
    { key="n", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key="RightArrow", action = wezterm.action.ActivateTabRelative(1) },
    { key="LeftArrow", action = wezterm.action.ActivateTabRelative(-1) },
    { key="w", action = wezterm.action.CloseCurrentTab { confirm = false } },
  }
}


config.keys = {

  -- :::
  -- :::: MODALLY WE ROLL ALONG ::::
  -- ::::: ::::::::::::::::::::: :::::
  -- 

  -- utility
  {
    key = "U",
    mods = "CMD|SHIFT",
    action = wezterm.action.ActivateKeyTable{
      name = "utility",
      one_shot = true
    },
  },

  -- resize
  {
    key = "R",
    mods = "CMD|SHIFT",
    action = wezterm.action.ActivateKeyTable{
      name = "resize",
      one_shot = false
    },
  },

  -- tabs (mostly fallbacks)
  {
    key = "T",
    mods = "CMD|SHIFT",
    action = wezterm.action.ActivateKeyTable{
      name = "tabular",
      one_shot = false
    },
  },

  -- this bind causes erratic behavior with multiple panes open
  {
      key = 'Z',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.DisableDefaultAssignment,
  },


  
  -- :::
  -- :::: TABBY-THINGS ::::
  -- ::::: :::::::::::: :::::
  -- 

  {
    key = "W",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },
  {
    key = "T",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  {
    key = "RightArrow",
    mods = "CMD|ALT",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = "LeftArrow",
    mods = "CMD|ALT",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "Tab",
    mods = "SHIFT|CTRL",
    action = wezterm.action.ActivateTabRelative(-1),
  },

  -- :::
  -- :::: PANEY-THINGS ::::
  -- ::::: :::::::::::: :::::
  -- 

  -- better resize, keep mode though
  {
    key="UpArrow",
    mods = "CMD|CTRL",
    action = wezterm.action.AdjustPaneSize{"Up", 2} 
  },

  {
    key="LeftArrow",
    mods = "CMD|CTRL",
    action = wezterm.action.AdjustPaneSize{"Left", 2} 
  },

  {
    key="RightArrow",
    mods = "CMD|CTRL",
    action = wezterm.action.AdjustPaneSize{"Right", 2} 
  },

  {
    key="DownArrow",
    mods = "CMD|CTRL",
    action = wezterm.action.AdjustPaneSize{"Down", 2} 
  },

  -- creation/deltion
  {
    key = "X",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = "\\",
    mods = "CMD",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "\\",
    mods = "CMD|SHIFT",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },

  -- navigation..
  -- these are just keybinds
  -- I've always liked for nav 
  -- within application 'panes' != tabs!
  {
    key = "LeftArrow",
    mods = "CMD|CTRL|ALT",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "RightArrow",
    mods = "CMD|CTRL|ALT",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
  {
    key = "UpArrow",
    mods = "CMD|CTRL|ALT",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "DownArrow",
    mods = "CMD|CTRL|ALT",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },

  -- maximize/minimize pane
  -- requires overriding the macOS default
  {
    key = 'm',
    mods = 'CMD',
    action = wezterm.action.DisableDefaultAssignment,
  },

  {
    key = "m",
    mods = "CMD",
    action = wezterm.action.TogglePaneZoomState,
  },

  -- :::
  -- getting my nice cmd readlines back
  {
    key = "LeftArrow",
    mods = "CMD",
    action = wezterm.action.SendString("\x1b[1;9D"),
  },
  {
    key = "RightArrow",
    mods = "CMD",
    action = wezterm.action.SendString("\x1b[1;9C"),
  },

  -- :::
  -- :::: VISUAL ::::
  -- ::::: :::::: :::::
  --  

  -- hi/lo opacity toggle
  -- note this does not writeback
  -- to the wezztershier tuning section
  {
    key = "o",
    mods = "CMD",
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      local opa = overrides.window_background_opacity
      if opa == nil or opa == 1.0 then
        overrides.window_background_opacity = 0.05
      else
        overrides.window_background_opacity = 1.0
      end
      window:set_config_overrides(overrides)
    end),
  },
}


-- :::
-- :::: TAB BAR HOVER STATES ::::
-- ::::: ::::::::::::::::::::: :::::
--
-- NOTE: These can't be easily tuned via GUI
--       since they're computed from other values
config.colors.tab_bar.inactive_tab_hover = {
  bg_color = "#444444",
  fg_color = "#DDDDDD",
}

config.colors.tab_bar.new_tab = {
  bg_color = "#333333",
  fg_color = "#FFFFFF",
}

config.colors.tab_bar.new_tab_hover = {
  bg_color = "#444444",
  fg_color = "#FFFFFF",
}

return config