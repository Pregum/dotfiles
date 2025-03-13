# for github
eval "$(ssh-agent -s)"

# for homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# for exa alias
# disabled になったので、ezaに乗り換え
# alias ls='exa --git --time-style=long-iso -gla'
alias ls='eza --git --time-style=long-iso -gla'

## for git
alias gs='git status'
alias gss='git status --cached'
alias gl='git log'
alias glgb='git log --graph --branches'
alias glg='git log --graph'
alias gln='git log --name-status'
alias gb='git branch'
alias gc='git checkout'
alias gr='git remote'
alias grr='git remote -vv'
alias ga='git add'
alias gaa='git add -u'
alias gaaa='git add -A'
alias gd='git diff'
alias gdd='git diff --cached'
alias gf='git fetch'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gp='git push'
alias gpo='git push origin'
alias gpu='git push upstream'

# nvim
alias vim='nvim'
alias nvim-conf='nvim ~/.config/nvim/init.vim'
alias vim-conf='nvim ~/.config/nvim/init.vim'

# key-chain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# z
. ~/z/z.sh
alias j='z'

# # anyenv
# export PATH="$HOME/.anyenv/bin:$PATH"
# eval "$(anyenv init -)"

# mise
export PATH="$HOME/.local/share/mise/shims:$PATH"

# lazygit
alias lg='lazygit'
alias l='lazygit'
alias lconf='vim ~/Library/Application\ Support/lazygit/config.yml'

# コマンド履歴を１万行保存する
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups  # 同じコマンドを履歴に残さない
setopt share_history     # 同時に起動したzshで履歴を共有する

# Ctrl + N/Pでコマンド履歴を検索する
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end


## ghqをctrl+]で開くキーバインド
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf
