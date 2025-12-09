local wezterm = require("wezterm")

local function BaseName(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local HEADER = ""

local SYMBOL_COLOR = { "#ffb2cc", "#a4a4a4" }
local FONT_COLOR = { "#dddddd", "#888888" }
local BACK_COLOR = "#2d2d2d"
local HOVER_COLOR = "#434343"

-- user varsからbase64デコードして値を取得
local function get_user_var(pane, name)
	local user_vars = pane:get_user_vars()
	if user_vars and user_vars[name] then
		-- WezTermは自動的にbase64デコードしてくれる
		return user_vars[name]
	end
	return ""
end

-- タブタイトルのフォーマット（タブバーに表示される内容）
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local index = tab.is_active and 1 or 2
	local bg = hover and HOVER_COLOR or BACK_COLOR
	local zoomed = tab.active_pane.is_zoomed and " " or " "

	local pane = tab.active_pane

	-- カレントディレクトリを取得
	local cwd = pane.current_working_dir
	local cwd_string = ""
	local depth = 0
	if cwd then
		local full_path = cwd.file_path
		full_path = full_path:gsub("^" .. wezterm.home_dir, "~")
		_, depth = full_path:gsub("/", "")

		local last_dir = full_path:match("([^/]+)/?$") or full_path

		if #last_dir <= 10 then
			local parts = {}
			for part in full_path:gmatch("[^/]+") do
				table.insert(parts, part)
			end
			if #parts >= 2 then
				cwd_string = parts[#parts - 1] .. "/" .. parts[#parts]
			else
				cwd_string = last_dir
			end
		else
			cwd_string = last_dir
		end
	end

	-- user varsからgit情報を取得
	local branch = get_user_var(pane, "git_branch")
	local repo = get_user_var(pane, "git_repo")

	-- タブに表示するテキストを構築
	local display_parts = {}
	if repo ~= "" then
		table.insert(display_parts, repo)
	end
	if branch ~= "" then
		table.insert(display_parts, " " .. branch)
	end

	local git_info = table.concat(display_parts, "")
	local tab_text = cwd_string
	if git_info ~= "" then
		tab_text = git_info .. " " .. cwd_string
	end

	return {
		{ Foreground = { Color = SYMBOL_COLOR[index] } },
		{ Background = { Color = bg } },
		{ Text = HEADER .. "[" .. tostring(depth) .. "] " .. zoomed },

		{ Foreground = { Color = FONT_COLOR[index] } },
		{ Background = { Color = bg } },
		{ Text = tab_text .. "  " },
	}
end)

-- タブのタイトルを更新（Cmd+P のランチャーで表示される内容）
-- この関数はstatus.luaから呼び出される（update-statusイベントの重複を避けるため）
function UpdateTabTitle(window, pane)
	-- CWD（末尾ディレクトリ名）
	local cwd = ""
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		local path = cwd_uri.file_path or ""
		cwd = BaseName(path)
		-- 末尾の/を除去
		cwd = cwd:gsub("/$", "")
	end

	-- user varsからgit情報を取得
	local branch = get_user_var(pane, "git_branch")
	local repo = get_user_var(pane, "git_repo")

	-- 実行中のプロセス名
	local proc = pane:get_foreground_process_name() or ""
	proc = BaseName(proc)

	-- 表示タイトルを構築
	local parts = {}
	if repo ~= "" then
		table.insert(parts, repo)
	end
	if branch ~= "" then
		table.insert(parts, " " .. branch)
	end
	if cwd ~= "" and cwd ~= repo then
		table.insert(parts, cwd)
	end
	if proc ~= "" and proc ~= "zsh" and proc ~= "bash" then
		table.insert(parts, proc)
	end

	local new_title = table.concat(parts, " | ")
	if new_title == "" then
		new_title = cwd ~= "" and cwd or "Terminal"
	end

	-- タブタイトルを更新（Launcherもこの文字列を使う）
	local mux_tab = pane:tab()
	if mux_tab then
		local current_title = mux_tab:get_title()
		if current_title ~= new_title then
			mux_tab:set_title(new_title)
		end
	end
end

-- ref: https://zenn.dev/choplin/articles/cb16c2da711de8
wezterm.on("bell", function(window, pane)
	window:toast_notification("Claude Code", "Task completed", nil, 4000)
end)
