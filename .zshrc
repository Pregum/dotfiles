
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# starship
eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.pub-cache/bin
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"


## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f $HOME/.dart-cli-completion/zsh-config.zsh ]] && . $HOME/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


## 以下は[こちら](https://qiita.com/tatsugon14/items/7a7390f8d45b276fcbb1) を参考に記載している

# zplug
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
# source ~/.zplug/init.zsh
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# 非同期処理できるようになる
zplug "mafredri/zsh-async"
# # テーマ(ここは好みで。調べた感じpureが人気)
# zplug "sindresorhus/pure"
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
zplug "zsh-users/zsh-history-substring-search"
# 過去に入力したコマンドの履歴が灰色のサジェストで出る
zplug "zsh-users/zsh-autosuggestions"
# 補完強化
zplug "zsh-users/zsh-completions"
# 256色表示にする
zplug "chrissicool/zsh-256color"
# コマンドライン上の文字リテラルの絵文字を emoji 化する
zplug "mrowa44/emojify", as:command
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
# コマンドの履歴機能
# 履歴ファイルの保存先
HISTFILE=$HOME/.zsh_history
# メモリに保存される履歴の件数
HISTSIZE=10000
# HISTFILE で指定したファイルに保存される履歴の件数
SAVEHIST=10000
# Then, source plugins and add commands to $PATH
zplug load

## starship反映
eval "$(starship init zsh)"

## fzf反映
source <(fzf --zsh)

# patrol(flutterのE2Eテストライブラリ)の設定
# android_homeの設定(ref: https://developer.android.com/tools/variables#set)
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# この辺りはCPPFLAGSに複数回代入処理があるので、下記記事などを参考にhomebrew側で管理させる方が良さそう
# https://zenn.dev/ultimatile/articles/keg-only-package-with-environment-modules
# openjdk via homebrew (for patrol_cli install)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

# libpg via homebrew (for patrol_cli install)
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/libpq/lib/pkgconfig"

# fvmのパス設定
# export PATH=$PATH:$HOME/.pub-cache/bin
export PATH=$PATH:$HOME/fvm/default/bin

# WezTerm用: ディレクトリ変更時にgitブランチとリポジトリ名をuser varにセット
function _wezterm_set_user_vars() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  local repo=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)
  printf "\033]1337;SetUserVar=git_branch=%s\007" $(echo -n "$branch" | base64)
  printf "\033]1337;SetUserVar=git_repo=%s\007" $(echo -n "$repo" | base64)
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _wezterm_set_user_vars
add-zsh-hook precmd _wezterm_set_user_vars

export PATH=$PATH:$GOPATH/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pregum/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pregum/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pregum/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pregum/google-cloud-sdk/completion.zsh.inc'; fi
# eval "$(~/.local/bin/mise activate zsh)"

# Enable multi-line editing with Shift+Enter
# This allows you to enter multi-line commands in the terminal
bindkey '^J' self-insert  # Ctrl+J for newline
bindkey '^M' accept-line  # Enter to execute

# Alternative: Enable ZLE (Zsh Line Editor) multi-line mode
setopt interactivecomments  # Allow comments in interactive mode
setopt no_hist_ignore_space # Don't ignore commands starting with space
# export PATH="$PATH:~/src/github.com/Pregum/git-worktree-sync"
export PATH="$PATH:/Users/pregum/bin"
export PATH="$HOME/.local/bin:$PATH"

# Added by Antigravity
export PATH="/Users/pregum/.antigravity/antigravity/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
