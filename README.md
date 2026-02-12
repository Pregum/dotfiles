# dotfiles

個人の開発環境設定ファイル群です。

## 構成

```
.bin/               # インストールスクリプト
.config/
  fish/             # Fish shell 設定
  git/              # Git 設定
  gwq/              # gwq (Git worktree manager) 設定
  karabiner/        # Karabiner-Elements 設定
  lazygit/          # Lazygit 設定
  mise/             # mise (ツールバージョン管理) 設定
  nvim/             # Neovim (LazyVim) 設定
  starship.toml     # Starship プロンプト設定
  wezterm/          # WezTerm ターミナル設定
.zshrc              # Zsh 設定
.zprofile           # Zsh プロファイル
```

## セットアップ

```bash
# インストールスクリプトを実行
.bin/install.sh
```

## gwq + lazygit 連携

[gwq](https://github.com/d-kuro/gwq) を使って Git worktree を管理し、lazygit からシームレスに操作できるように設定しています。

### gwq の設定 (`~/.config/gwq/config.toml`)

```toml
[naming]
template = '{{.Host}}/{{.Owner}}/{{.Repository}}={{.Branch}}'

[worktree]
basedir = '~/src'
```

- `basedir` を ghq と同じ `~/src` に設定し、リポジトリとworktreeを一元管理
- `naming.template` により `github.com/Owner/Repo=branch-name` の形式で配置

### lazygit のキーバインド (`~/.config/lazygit/config.yml`)

#### Worktrees パネル

| キー | 動作 |
|------|------|
| `n`  | gwq add -i (新規worktree作成 / 組み込みを置き換え) |
| `w`  | gwq add -i (新規worktree作成) |
| `d`  | gwq remove (worktree削除 / fuzzy finder) |
| `D`  | gwq remove -b (worktree + ブランチ削除) |
| `s`  | gwq status (全worktreeの状態表示) |

#### Branches パネル

| キー | コンテキスト | 動作 |
|------|-------------|------|
| `w`  | localBranches  | gwq add (選択ブランチでworktree作成) |
| `w`  | remoteBranches | gwq add (選択リモートブランチでworktree作成) |

#### グローバル

| キー | 動作 |
|------|------|
| `W`  | gwq cd (worktreeへ移動) |

### インストール

```bash
brew install d-kuro/tap/gwq
brew install lazygit
```
