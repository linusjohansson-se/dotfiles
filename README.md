# dotfiles

Personal dev environment config managed with [GNU Stow](https://www.gnu.org/software/stow/).

---

## What lives where

| Config | Managed by |
|--------|-----------|
| Neovim | dotfiles (git + stow) |
| VSCode settings & keybindings | VSCode Settings Sync (sign in) |
| VSCode extensions | VSCode Settings Sync (sign in) |
| Alacritty, tmux, zsh | dotfiles (git + stow) |

---

## Linux

### 1. Clone dotfiles
```sh
git clone <repo-url> ~/dotfiles
```

### 2. Install Neovim
```sh
# Ubuntu/Debian
sudo apt install neovim

# or latest via tarball: https://github.com/neovim/neovim/releases
```

### 3. Stow packages
```sh
cd ~/dotfiles
stow nvim
stow zsh
stow tmux
stow alacritty   # if applicable
```

### 4. VSCode
- Install VSCode
- Sign in to Settings Sync (GitHub or Microsoft account)
- All settings, keybindings, and extensions restore automatically
- Verify nvim path in settings: `vscode-neovim.neovimExecutablePaths.linux`

---

## macOS

### 1. Clone dotfiles
```sh
git clone <repo-url> ~/dotfiles
```

### 2. Install Neovim
```sh
brew install neovim
```

### 3. Stow packages
```sh
cd ~/dotfiles
stow nvim
stow zsh
stow tmux
```

### 4. VSCode
- Install VSCode
- Sign in to Settings Sync
- Add mac nvim path to VSCode settings if different from Linux:
  ```json
  "vscode-neovim.neovimExecutablePaths.osx": "/opt/homebrew/bin/nvim"
  ```

---

## Windows (WSL)

This setup runs VSCode on Windows with the Remote-WSL extension and VSCode Neovim pointing at a Windows-native Neovim install that loads config from the Windows clone of this repo.

### 1. Set up WSL
Install Ubuntu from the Microsoft Store, then:
```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
stow nvim
stow zsh
stow tmux
```

### 2. Install Neovim for Windows
In a Windows terminal (PowerShell):
```powershell
winget install Neovim.Neovim
```

### 3. Clone dotfiles on the Windows side
```powershell
git clone <repo-url> C:\source\dotfiles
```

### 4. Create the Neovim wrapper
Create `C:\Users\<username>\AppData\Local\nvim\init.lua`:
```lua
vim.opt.runtimepath:prepend("C:\\source\\dotfiles\\nvim\\.config\\nvim")
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("config.lazy")
dofile("C:\\source\\dotfiles\\nvim\\.config\\nvim\\lua\\config\\keymaps.lua")
```
> Replace `C:\source\dotfiles` with your actual Windows dotfiles path.

### 5. VSCode
- Install VSCode
- Sign in to Settings Sync — this restores all settings including the VSCode Neovim extension and its config
- Verify these paths in `settings.json` match your machine:
  ```json
  "vscode-neovim.neovimExecutablePaths.win32": "C:\\Program Files\\Neovim\\bin\\nvim.exe",
  "vscode-neovim.neovimInitVimPaths.win32": "C:\\Users\\<username>\\AppData\\Local\\nvim\\init.lua"
  ```

---

## Keeping Windows and WSL dotfiles in sync

Both clones (`~/dotfiles` in WSL and `C:\source\dotfiles` on Windows) pull from the same remote. After updating Neovim config, run `git pull` in both locations.

The Windows Neovim wrapper (`AppData\Local\nvim\init.lua`) is **not** in dotfiles — it's a one-time per-machine setup since it contains machine-specific paths.

---

## Neovim in VSCode

The Neovim config detects when it's running inside VSCode via `vim.g.vscode` and:
- Skips all LazyVim plugins (VSCode handles LSP, treesitter, UI)
- Loads keymaps that delegate to VSCode commands via `require('vscode').action(...)`

This means the same `keymaps.lua` works in both native Neovim and VSCode Neovim.
