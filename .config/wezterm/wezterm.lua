local wezterm = require 'wezterm'

require 'wezterm'
require 'status'
require 'format'


return {
	color_scheme = "Catppuccin Mocha",
	window_background_opacity = 0.93,
    -- font = require("wezterm").font("Fira Code"),
    font = require('wezterm').font('Hack Nerd Font'),
    font_size = 14.0,
    window_frame = {
      -- デフォルト値のままなので記述しなくても平気ですが、後で変えたくなった時にわかりやすいので。
      -- font = wezfont 'Roboto',
      -- font = require('wezterm').font("Fira Code"),
      font = require('wezterm').font('Hack Nerd Font'),
      -- サイズはだいぶ小さくしちゃってます。
      -- font_size = 8.0,
    },
    keys = {
        -- cmd + d で水平分割
        {
            key = "d",
            mods = "CMD",
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
       -- cmd + shift + d で垂直分割
        { key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitPane { direction = "Down" } },
                
        -- cmd + w で現在のパネルを閉じる
        { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane { confirm = true } },
        -- { key = "w", mods = "CTRL", action = wezterm.action.CloseCurrentPane { confirm = true } },
        -- cmd + [ で左または上のパネルに移動
        {
          key = '[',
          mods = 'CMD',
          action = wezterm.action.ActivatePaneDirection 'Prev', -- 左または上の方向に移動
        },
        -- cmd + ] で右または下のパネルに移動
        {
          key = ']',
          mods = 'CMD',
          action = wezterm.action.ActivatePaneDirection 'Next', -- 右または下の方向に移動
        },
        -- cmd + shift + [ で上のパネルに移動
        {
          key = '{',
          mods = 'CMD',
          -- action = wezterm.action.ActivatePaneDirection 'Up',
          action = wezterm.action.ActivateTabRelative(-1),
        },
        -- cmd + shift + ] で下のパネルに移動
        {
          key = '}',
          mods = 'CMD',
          -- action = wezterm.action.ActivatePaneDirection 'Down',
          action = wezterm.action.ActivateTabRelative(1),
        },
    },
    -- keys = {
    --   -- cmd + d で垂直方向に新しいペインを開く
    --   {key="d", mods="CMD", action=wezterm.action.SplitPane{direction="Down"}},

    --   -- cmd + shift + d で水平方向に新しいペインを開く（必要に応じて）
    --   {key="d", mods="CMD|SHIFT", action=wezterm.action.SplitPane{direction="Right"}},
    -- },
    use_fancy_tab_bar = false,
    -- skip_close_confirmation_for_panes_with_processes = false,
    status_update_interval = 1000,
}

