# Theo Neovim Config

A small, modern Neovim configuration for Linux and WSL. It targets Neovim 0.12+,
uses lazy.nvim for reproducible plugin management, and keeps machine-local
customization out of Git.

## Philosophy

- Keep the config readable and personal without becoming a full distribution.
- Prefer native Neovim 0.12+ APIs and documented plugin setup.
- Use `lazy-lock.json` so plugin versions can be restored on another machine.
- Avoid hardcoded local paths and generated plugin-loader files.

## Requirements

- Neovim 0.12+
- Git, curl, tar, unzip
- A C compiler and build tools
- `tree-sitter` CLI
- `ripgrep`
- `fd` or `fdfind`
- Node.js and npm
- Python 3
- Optional: `stylua`, `prettier`, `ruff`, `black`, and a Nerd Font

## Installation

Back up any existing config first:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

Clone this repository:

```bash
git clone https://github.com/theoord/nvim ~/.config/nvim
cd ~/.config/nvim
```

On Ubuntu WSL, install/check dependencies:

```bash
./scripts/install-wsl.sh
```

Start Neovim and restore locked plugin versions:

```bash
nvim
:Lazy restore
:checkhealth
```

## WSL Notes

- Keep projects in the Linux filesystem, for example under `~/code`, not
  `/mnt/c/...`.
- Install Linux Node, Python, compilers, and formatters inside WSL.
- Use Windows Terminal, WezTerm, or another terminal with good font support.
- Do not mix Windows Node/Python binaries with WSL Neovim.

## Plugins

- `lazy.nvim`: plugin manager
- `rose-pine`: colorscheme
- `telescope.nvim`: fuzzy finding
- `nvim-treesitter`: syntax parsing and highlighting
- `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig`: LSP tooling
- `blink.cmp`: completion
- `vim-fugitive`, `gitsigns.nvim`: Git workflow
- `harpoon`: quick file marks
- `undotree`: undo history UI
- `conform.nvim`: formatting

## Keymaps

| Key | Action |
| --- | --- |
| `<leader>pv` | Open netrw |
| `<leader>nh` | Clear search highlight |
| `<Esc>` | Clear search highlight |
| `<leader>w` | Next window |
| `<leader>d` | Open mongosh terminal |
| `<leader>q` | Open diagnostic list |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>pf` | Find files |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>ps` | Grep prompt |
| `<leader>pr` | Project replace prompt |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |
| `<leader>gs` | Git status |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gd` | Git diff split |
| `<leader>gds` | Git diff split |
| `<leader>a` | Harpoon add file |
| `<leader>h` | Harpoon menu |
| `<leader>s` | Harpoon menu |
| `<leader>1`..`<leader>4` | Harpoon files 1 through 4 |
| `<A-h>`..`<A-l>` | Harpoon files 1 through 4 |
| `<leader>u` | Undo tree |
| `<leader>cf` | Format buffer |
| `gd`, `gD`, `gi`, `gr`, `K` | LSP navigation and hover |
| `<leader>rn` | LSP rename |
| `<leader>ca` | LSP code action |
| `<leader>pd` | Project diagnostics |

Leader is Space.

## Language Support

| Language | LSP | Treesitter | Formatting |
| --- | --- | --- | --- |
| Lua | `lua_ls` | Yes | `stylua` |
| TypeScript/JavaScript | `ts_ls` | Yes | `prettier` |
| Python | `pyright` | Yes | `ruff_format`, then `black` |
| Markdown | None by default | Yes | `prettier` |
| Bash | None by default | Yes | LSP fallback only |

Mason installs `lua_ls`, `ts_ls`, and `pyright`. External formatters are not
installed by Neovim; install them with your OS package manager, npm, pip, or Mason
as appropriate.

## Updates

Update plugins intentionally:

```vim
:Lazy update
```

Commit the changed `lazy-lock.json`. On another machine, restore the same plugin
revisions with:

```vim
:Lazy restore
```

## Local Customizations

Create `lua/theo/local.lua` for private mappings or machine-specific settings.
This file is ignored by Git.

Example:

```lua
vim.keymap.set("n", "<leader>di", ":edit /path/to/private/file<cr>", {
  desc = "Open private file",
})
```

The French accent helper is opt-in:

```lua
vim.g.theo_enable_french_accents = true
require("theo.config.french")
```

## Troubleshooting

- Old Neovim: install Neovim 0.12+ from an official release, AppImage, Homebrew
  on Linux, or another current source.
- Treesitter parser failures: install a C compiler and `tree-sitter`, then run
  `:Lazy build nvim-treesitter`.
- Telescope live grep does nothing: install `ripgrep`.
- Telescope file finding is slow or incomplete: install `fd` or `fdfind`.
- LSP not starting: run `:Mason`, verify the server is installed, then run
  `:checkhealth vim.lsp`.
- Formatting fails: install the formatter shown by `:ConformInfo`.
- WSL clipboard issues: install clipboard integration for your terminal or set
  up `win32yank.exe`.
- Broken plugin/cache state: run `./scripts/reset-state.sh`, then start Neovim
  and run `:Lazy restore`.

## Health Check

```bash
./scripts/doctor.sh
```
