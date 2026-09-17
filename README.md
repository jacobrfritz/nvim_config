# Neovim Configuration

A modern, high-performance, modular Neovim setup built with Lua and `lazy.nvim`. Engineered for speed, clean aesthetics, and a smooth IDE-like experience across macOS, Linux, and Windows.

---

## 🚀 Architecture

```text
~/.config/nvim/
├── init.lua                 # Minimal bootstrap entry point
├── lazy-lock.json           # Plugin lockfile (managed by lazy.nvim)
├── lua/
│   ├── core/                # Core editor settings & foundations
│   │   ├── autocmds.lua     # Yank highlighting, cursor position memory
│   │   ├── keymaps.lua      # General navigation, editing, and window maps
│   │   ├── options.lua      # Editor options (tab width, relative lines, etc.)
│   │   └── platform.lua     # Cross-platform environment & PATH normalization
│   │
│   ├── plugins/             # Modular plugin specifications
│   │   ├── coding.lua       # Blink.cmp, LuaSnip, Autopairs, Auto-save, Mini.ai
│   │   ├── editor.lua       # Telescope, Oil, Harpoon2, Neo-tree, Diffview, Undotree
│   │   ├── formatting.lua   # Conform.nvim (format on save), nvim-lint
│   │   ├── lsp.lua          # Native LSP, Mason, Mason-tool-installer, Fidget
│   │   ├── treesitter.lua   # Treesitter syntax highlighting & Treesitter-context
│   │   └── ui.lua           # Tokyonight (Transparent), Lualine, Noice, Gitsigns
│   │
│   └── user/                # Machine-specific settings (Git-ignored)
│       └── init.lua         # Local overrides, tokens, or custom settings
└── README.md
```

---

## 📋 Prerequisites

For optimal experience and automatic tool installations, ensure these dependencies are installed:

* **Neovim**: `v0.10+` (tested on `v0.11`)
* **Nerd Font**: Installed and configured in your terminal (e.g., JetBrainsMono Nerd Font)
* **Build Tools**: `git`, `make`, and a C compiler (`gcc`, `clang`, or Xcode Command Line Tools)
* **Search Tools**: `ripgrep` (`brew install ripgrep`) and `fd` (`brew install fd`)
* **Language Runtimes**: Node.js & npm (for Prettier/LSP tools), Python 3 (for Ruff)

---

## ⌨️ Keybindings Reference

> Leader key is configured as **`<Space>`**. Local leader is also **`<Space>`**.

### 1. General & Window Navigation

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<Esc>` | Normal | Clear search highlight (`nohlsearch`) |
| `<C-h>` | Normal | Move focus to left window |
| `<C-l>` | Normal | Move focus to right window |
| `<C-j>` | Normal | Move focus to lower window |
| `<C-k>` | Normal | Move focus to upper window |
| `<Esc><Esc>` | Terminal | Exit terminal mode to normal mode |

### 2. Editing Ergonomics

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<C-d>` | Normal | Scroll half-page down and center cursor (`zz`) |
| `<C-u>` | Normal | Scroll half-page up and center cursor (`zz`) |
| `n` | Normal | Next search match and center cursor |
| `N` | Normal | Previous search match and center cursor |
| `J` | Visual | Move selected lines down |
| `K` | Visual | Move selected lines up |
| `<leader>p` | Visual | Paste without overwriting the default register (`"_dP`) |
| `<leader>f` | Normal / Visual | Format buffer with `conform.nvim` |
| `<leader>u` | Normal | Toggle Undotree graphical undo history |

### 3. File Exploration & Fast Navigation

| Key | Mode | Description |
| :--- | :--- | :--- |
| `-` | Normal | Open parent directory in **Oil.nvim** (edit filesystem like a buffer) |
| `\` | Normal | Toggle **Neo-tree** file drawer on / off |
| `<leader>a` | Normal | Add current file to **Harpoon** |
| `<C-e>` | Normal | Toggle **Harpoon** quick menu |
| `<leader>1` | Normal | Switch to Harpoon file 1 |
| `<leader>2` | Normal | Switch to Harpoon file 2 |
| `<leader>3` | Normal | Switch to Harpoon file 3 |
| `<leader>4` | Normal | Switch to Harpoon file 4 |

### 4. Fuzzy Search (Telescope)

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>sf` | Normal | [S]earch [F]iles in project |
| `<leader>sg` | Normal | [S]earch by Live [G]rep |
| `<leader>sw` | Normal | [S]earch current [W]ord under cursor |
| `<leader>s.` | Normal | [S]earch Recent Files |
| `<leader><leader>` | Normal | Find existing open buffers |
| `<leader>/` | Normal | Fuzzily search within current buffer |
| `<leader>s/` | Normal | Live grep only in open files |
| `<leader>sd` | Normal | [S]earch [D]iagnostics |
| `<leader>sk` | Normal | [S]earch [K]eymaps |
| `<leader>sh` | Normal | [S]earch [H]elp documentation |
| `<leader>sr` | Normal | [S]earch [R]esume last search |
| `<leader>sn` | Normal | [S]earch [N]eovim configuration files |

### 5. LSP & Diagnostics

| Key | Mode | Description |
| :--- | :--- | :--- |
| `gd` / `grd` | Normal | [G]oto [D]efinition (Telescope) |
| `grr` | Normal | [G]oto [R]eferences (Telescope) |
| `gri` | Normal | [G]oto [I]mplementation (Telescope) |
| `grt` | Normal | [G]oto [T]ype Definition (Telescope) |
| `grD` | Normal | [G]oto [D]eclaration |
| `grn` | Normal | [R]e[n]ame symbol |
| `gra` | Normal / Visual | Code [A]ction |
| `gO` | Normal | Open Document Symbols |
| `gW` | Normal | Open Workspace Symbols |
| `<leader>th` | Normal | [T]oggle Inlay [H]ints (if supported by LSP) |
| `<leader>q` | Normal | Open diagnostic Quickfix list |
| `<leader>xx` | Normal | Toggle Trouble project diagnostics |
| `<leader>xX` | Normal | Toggle Trouble buffer diagnostics |

### 6. Git Integration

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<leader>gs` | Normal | Open Git status (`vim-fugitive`) |
| `<leader>gd` | Normal | Open side-by-side Git diff view (`diffview.nvim`) |
| `<leader>gh` | Normal | View Git history of current file (`DiffviewFileHistory %`) |
| `<leader>gH` | Normal | View Git history of entire branch (`DiffviewFileHistory`) |
| `]c` / `[c` | Normal | Jump to next / previous Git hunk (`gitsigns`) |
| `<leader>hs` | Normal / Visual | Stage Git hunk |
| `<leader>hr` | Normal / Visual | Reset Git hunk |
| `<leader>hp` | Normal | Preview Git hunk inline |
| `<leader>hb` | Normal | Blame current line |
| `<leader>tb` | Normal | Toggle inline Git blame |
| `<leader>tD` | Normal | Toggle inline deleted lines preview |

### 7. Terminal

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<C-t>` | Normal / Terminal | Toggle floating terminal (`toggleterm.nvim`) |

---

## 🔌 Installed Plugins

| Plugin | Category | Description |
| :--- | :--- | :--- |
| **[lazy.nvim](https://github.com/folke/lazy.nvim)** | Package Manager | Fast, modern plugin manager |
| **[blink.cmp](https://github.com/saghen/blink.cmp)** | Completion | Ultra-fast completion engine with signature help & fuzzy matching |
| **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)** | Snippets | Snippet engine integration for Blink.cmp |
| **[lazydev.nvim](https://github.com/folke/lazydev.nvim)** | Lua Tooling | Full Neovim API types & completion for plugin development |
| **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** | LSP | Native language server configurations |
| **[mason.nvim](https://github.com/williamboman/mason.nvim)** | LSP Management | Tool installer for LSPs, DAP, linters, and formatters |
| **[conform.nvim](https://github.com/stevearc/conform.nvim)** | Formatting | Fast autoformatting (Ruff, Stylua, Prettier) on save |
| **[nvim-lint](https://github.com/mfussenegger/nvim-lint)** | Linting | Asynchronous linter (Markdownlint) |
| **[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** | Highlighting | Advanced AST syntax highlighting and indentation |
| **[nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context)** | Context | Sticky header showing current function/class when scrolling |
| **[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** | Fuzzy Finder | Extensible fuzzy finder for files, git, diagnostics, and code |
| **[oil.nvim](https://github.com/stevearc/oil.nvim)** | File Explorer | Edit filesystem directories like standard Neovim buffers |
| **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)** | File Explorer | Tree-view sidebar file manager |
| **[harpoon](https://github.com/ThePrimeagen/harpoon)** | Navigation | Quick file bookmarking and rapid jumping |
| **[diffview.nvim](https://github.com/sindrets/diffview.nvim)** | Git | Side-by-side diffing, merge reviews, and git file history |
| **[vim-fugitive](https://github.com/tpope/vim-fugitive)** | Git | Classic, robust Git wrapper |
| **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)** | Git | Gutter signs, hunk previews, hunk staging, and blame |
| **[tokyonight.nvim](https://github.com/folke/tokyonight.nvim)** | Theme | `tokyonight-moon` with native background transparency |
| **[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)** | Status / Winbar | Winbar showing mode, file info, diagnostics, and git branch |
| **[noice.nvim](https://github.com/folke/noice.nvim)** | UI | Modern UI for messages, cmdline, and popup menu |
| **[which-key.nvim](https://github.com/folke/which-key.nvim)** | Keymap Helper | Popup popup showing pending keybindings and hints |
| **[trouble.nvim](https://github.com/folke/trouble.nvim)** | Diagnostics | Pretty list for workspace & buffer diagnostics |
| **[undotree](https://github.com/mbbill/undotree)** | History | Visual undo history tree |
| **[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** | Terminal | Persistent floating terminal |
| **[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)** | Markdown | Inline rendering for markdown headers, tables, callouts, latex |
| **[nvim-autopairs](https://github.com/windwp/nvim-autopairs)** | Editing | Automatically close brackets and quotes |
| **[mini.nvim](https://github.com/echasnovski/mini.nvim)** | Utilities | `mini.ai` (text objects) and `mini.surround` (quote/tag surroundings) |
| **[guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim)** | Indentation | Automatically detects tabstop and shiftwidth |
| **[auto-save.nvim](https://github.com/okuuva/auto-save.nvim)** | Editing | Automatically saves buffer changes |

---

## 🔒 Local & Private Customizations

To add machine-specific settings, custom keymaps, or secrets without modifying Git-tracked files:

1. Create `lua/user/init.lua` (this directory is ignored by `.gitignore`):
   ```lua
   -- lua/user/init.lua
   -- Put custom machine-specific options, environment variables, or extra plugins here
   ```
2. Neovim automatically loads this file at startup if present.
