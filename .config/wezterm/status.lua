local wezterm = require 'wezterm'

local HEADER_HOST = { Foreground = { Color = '#75b1a9' }, Text = '' }
local HEADER_CWD = { Foreground = { Color = '#92aac7' }, Text = '' }
local HEADER_DATE = { Foreground = { Color = '#ffccac' }, Text = '󱪺' }
local HEADER_TIME = { Foreground = { Color = '#bcbabe' }, Text = '' }
local HEADER_BATTERY = { Foreground = { Color = '#dfe166' }, Text = '' }

local DEFAULT_FG = { Color = '#9a9eab' }
local DEFAULT_BG = { Color = '#333333' }

local SPACE_1 = ' '
local SPACE_3 = '   '

local function AddElement(elems, header, str)
  table.insert(elems, { Foreground = header.Foreground })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = header.Text .. SPACE_1 })

  table.insert(elems, { Foreground = DEFAULT_FG })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = str .. SPACE_3 })
end

local HEADER_KEY_NORMAL = { Foreground = DEFAULT_FG, Text = '' }
local HEADER_LEADER = { Foreground = { Color = '#ffffff' }, Text = '' }
local HEADER_IME = { Foreground = DEFAULT_FG, Text = 'あ' }

local function AddIcon(elems, icon)
  table.insert(elems, { Foreground = icon.Foreground })
  table.insert(elems, { Background = DEFAULT_BG })
  table.insert(elems, { Text = SPACE_1 .. icon.Text .. SPACE_3 })
end

local function GetKeyboard(elems, window)
  if window:leader_is_active() then
    AddIcon(elems, HEADER_LEADER)
    return
  end

  AddIcon(elems, window:composition_status() and HEADER_IME or HEADER_KEY_NORMAL)
end

local function LeftUpdate(window, pane)
    local elems = {}
    GetKeyboard(elems, window)

    window:set_left_status(wezterm.format(elems))
end

local function GetHostAndCwd(elems, pane)
    local uri = pane:get_current_working_dir()

    if not uri then
        return
    end

    local cwd_uri = uri.file_path or uri:sub(8)
    local slash = cwd_uri:find '/'

    if not slash then
        return
    end

    local host = cwd_uri:sub(1, slash - 1)
    local dot = host:find '[.]'

    AddElement(elems, HEADER_HOST, dot and host:sub(1, dot - 1) or host)
    AddElement(elems, HEADER_CWD, cwd_uri:sub(slash))
end

local function GetDate(elems)
    AddElement(elems, HEADER_DATE, wezterm.strftime '%a %b %-d')
end

local function GetTime(elems)
    AddElement(elems, HEADER_TIME, wezterm.strftime '%H:%M')
end

local function GetBattery(elems, window)
    if not window:get_dimensions().is_full_screen then
        return
    end

    for _, b in ipairs(wezterm.battery_info()) do
        AddElement(elems, HEADER_BATTERY, string.format('%.0f%%', b.state_of_charge * 100))
    end
end

local function RightUpdate(window, pane)
    local elems = {}

    GetHostAndCwd(elems, pane)
    GetDate(elems)
    GetBattery(elems, window)
    GetTime(elems)

    window:set_right_status(wezterm.format(elems))
end

wezterm.on('update-status', function(window, pane)
    LeftUpdate(window, pane)
    RightUpdate(window, pane)
    
    -- テーマ切り替え処理（wezterm.luaから直接実行）
    if _G.theme_override_themes then
        local cwd = pane:get_current_working_dir()
        if cwd and cwd.file_path then
            wezterm.log_info("Theme override: Checking path: " .. cwd.file_path)
            
            local theme = nil
            if string.find(cwd.file_path, "/develop%-lite/") or string.find(cwd.file_path, "/develop%-lite$") then
                theme = _G.theme_override_themes["develop-lite"]
                wezterm.log_info("Theme override: Found develop-lite -> " .. theme)
            elseif string.find(cwd.file_path, "/enhance/") or string.find(cwd.file_path, "/enhance$") then
                theme = _G.theme_override_themes.enhance
                wezterm.log_info("Theme override: Found enhance -> " .. theme)
            elseif string.find(cwd.file_path, "/review/") or string.find(cwd.file_path, "/review$") then
                theme = _G.theme_override_themes.review
                wezterm.log_info("Theme override: Found review -> " .. theme)
            elseif string.find(cwd.file_path, "/sandbox/") or string.find(cwd.file_path, "/sandbox$") then
                theme = _G.theme_override_themes.sandbox
                wezterm.log_info("Theme override: Found sandbox -> " .. theme)
            end
            
            if not theme then
                theme = "Catppuccin Mocha"  -- デフォルト
                wezterm.log_info("Theme override: No match, using default: " .. theme)
            end
            
            local current = _G.current_theme_override or "Catppuccin Mocha"
            if theme ~= current then
                wezterm.log_info("Theme override: Changing from " .. current .. " to " .. theme)
                local overrides = window:get_config_overrides() or {}
                overrides.color_scheme = theme
                window:set_config_overrides(overrides)
                _G.current_theme_override = theme
                
                window:toast_notification("WezTerm", "Theme: " .. theme, nil, 1500)
            end
        end
    end
end)
