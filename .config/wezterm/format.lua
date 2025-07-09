local wezterm = require 'wezterm'

local function BaseName(s)
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

-- wezterm.on('format-window-title', function(tab)
--     return BaseName(tab.active_pane.foreground_process_name)
-- end

local HEADER = '' -- 文字化けしちゃってるかもしれませんが、アイコンフォント入ってます。

local SYMBOL_COLOR = { '#ffb2cc', '#a4a4a4' }
local FONT_COLOR = { '#dddddd', '#888888' }
local BACK_COLOR = '#2d2d2d'
local HOVER_COLOR = '#434343'

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local index = tab.is_active and 1 or 2

  local bg = hover and HOVER_COLOR or BACK_COLOR
  local zoomed = tab.active_pane.is_zoomed and '🔎 ' or ' '
  
  -- カレントディレクトリを取得
  local cwd = tab.active_pane.current_working_dir
  local cwd_string = ''
  if cwd then
    local full_path = cwd.file_path
    -- ホームディレクトリを ~ に置換
    full_path = full_path:gsub('^' .. wezterm.home_dir, '~')
    
    -- 最後のディレクトリ名を取得
    local last_dir = full_path:match("([^/]+)/?$") or full_path
    
    -- 10文字以内の場合は2階層分を表示
    if #last_dir <= 10 then
      -- パスを/で分割
      local parts = {}
      for part in full_path:gmatch("[^/]+") do
        table.insert(parts, part)
      end
      
      -- 最後の2つを結合
      if #parts >= 2 then
        cwd_string = parts[#parts - 1] .. '/' .. parts[#parts]
      else
        cwd_string = last_dir
      end
    else
      cwd_string = last_dir
    end
  end

  -- タブの内容を返す（WezTermが自動的に幅を調整）
  return {
    { Foreground = { Color = SYMBOL_COLOR[index] } },
    { Background = { Color = bg } },
    { Text = HEADER .. zoomed },

    { Foreground = { Color = FONT_COLOR[index] } },
    { Background = { Color = bg } },
    { Text = cwd_string .. '  ' }, -- 余白を追加
  }
end)
