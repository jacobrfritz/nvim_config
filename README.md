# Neovim Configuration

A modular, high-performance Neovim configuration designed for professional development across Windows, macOS, and Linux.

## 🚀 Architecture

This configuration uses a modular structure to separate core settings from plugin specifications, making it easy to maintain and extend.

```text
nvim/
├── init.lua                 # Minimal entry point
├── lazy-lock.json           # Managed automatically by lazy.nvim
├── lua/
│   ├── core/                # Neovim fundamentals
│   │   ├── autocmds.lua     # Global autocommands (Yank highlight, Keystroke engine)
│   │   ├── keymaps.lua      # Global keymaps (Window navigation, Git)
│   │   ├── options.lua      # General Vim options (tabs, line numbers, etc.)
│   │   └── platform.lua     # Cross-platform shell/PATH logic
│   │
│   ├── plugins/             # Category-specific plugin specifications
│   │   ├── coding.lua       # Blink.cmp, Luasnip, Autopairs, Auto-save
│   │   ├── editor.lua       # Telescope, Oil, Harpoon, Trouble, Fugitive
│   │   ├── formatting.lua   # Conform.nvim, nvim-lint
│   │   ├── lsp.lua          # Mason, Lspconfig, Lazydev
│   │   ├── treesitter.lua   # Nvim-treesitter
│   │   └── ui.lua           # Tokyonight (Transparent), Lualine, Noice
│   │
│   └── user/                # Machine-specific settings (Git-ignored)
│       └── init.lua         # Local secrets, API keys, and overrides
└── .gitignore               # Configured to ignore lua/user/
```

## ✨ Key Features

-   **Modular Design**: Clean separation of concerns using `lazy.nvim`'s automatic directory loading.
-   **Full LSP Support**: Powered by `nvim-lspconfig` and `Mason`, with autocompletion via `blink.cmp`.
-   **Advanced Navigation**: `Telescope` for fuzzy finding, `Oil.nvim` for file exploration, and `Harpoon` for rapid file switching.
-   **Keystroke Prediction**: A custom engine that logs and predicts keystrokes via a local FastAPI backend.
-   **Cross-Platform**: Automatic shell configuration for Windows (PowerShell) and PATH fixes for macOS.
-   **Aesthetics**: `Tokyonight-moon` with built-in transparency tweaks for a modern look.

## 🛠️ Installation

1.  Clone this repository to your Neovim config directory:
    -   **Windows**: `%LOCALAPPDATA%\nvim`
    -   **Linux/macOS**: `~/.config/nvim`
2.  Open Neovim; `lazy.nvim` will automatically bootstrap and install all plugins.
3.  (Optional) Create `lua/user/init.lua` for any machine-specific configuration.

## ⌨️ Common Keymaps

| Key | Description |
| :--- | :--- |
| `<leader>gs` | Open Git (Fugitive) |
| `<leader>sf` | Search Files (Telescope) |
| `-` | Open parent directory (Oil.nvim) |
| `<leader>a` | Harpoon current file |
| `<C-e>` | Toggle Harpoon menu / Accept prediction |
| `<leader>f` | Format buffer (Conform/Ruff) |
| `<leader>u` | Toggle Undotree |
| `\` | Reveal file in Neo-tree |
| `<C-h/j/k/l>` | Navigate between windows |

## 🔒 Private Configuration

Add any sensitive data or machine-specific overrides to `lua/user/init.lua`. This file is ignored by Git to keep your secrets safe.
