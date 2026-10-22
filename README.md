# Neovim Configuration Files

Just threw in onto Github in case my disk memories randonly crash.

## Prerequisites (Arch Linux)

LSPs in the official repos are installed system-wide with pacman: shared
with other editors and updated by `pacman -Syu`. The ones that are
**AUR-only** on Arch come from **Mason** instead, so no AUR helper is
needed on any machine.

```bash
# official repos
sudo pacman -S --needed \
  lua-language-server \
  rust \
  rust-analyzer \
  pyright \
  texlab \
  clang \
  bash-language-server \
  gopls \
  deno \
  zls \
  yaml-language-server \
  tinymist

# what the Mason packages below need to install and run
sudo pacman -S --needed nodejs npm python jdk-openjdk unzip
```

Mason packages (`lua/plugins/lsp.lua`, `mason_packages`): installed
automatically on the first start if missing. By hand: `:MasonInstall
json-lsp cmake-language-server jdtls codelldb`. Update them from `:Mason`
(`U`), since `pacman -Syu` doesn't see them.

| LSP name | Arch pkg | From |
|---|---|---|
| `lua_ls` | `lua-language-server` | extra |
| `rust_analyzer` | `rust-analyzer` | extra |
| `pyright` | `pyright` | extra |
| `jdtls` | (AUR `jdtls`) | Mason `jdtls`, needs `jdk-openjdk` |
| `texlab` | `texlab` | extra |
| `clangd` | `clang` | extra |
| `bashls` | `bash-language-server` | extra |
| `cmake` | (AUR `cmake-language-server`) | Mason `cmake-language-server`, needs `python` |
| `gopls` | `gopls` | extra |
| `denols` | `deno` | extra |
| `zls` | `zls` | extra |
| `jsonls` | (AUR `vscode-langservers-extracted`) | Mason `json-lsp`, needs `nodejs`, `npm` |
| `yamlls` | `yaml-language-server` | extra |
| `tinymist` | `tinymist` | extra |
| (DAP) | (AUR `codelldb-bin`) | Mason `codelldb`, needs `unzip` |

Repos checked with `pacman -Si` (2026-10).

Notes:
- codelldb paths are resolved in `lua/config/codelldb.lua`, used by
  `lua/plugins/rustaceanvim.lua` and `lua/plugins/nvim-dap.lua`. It prefers
  Mason's copy (`<data>/mason/packages/codelldb/extension/...`) and falls
  back to AUR `codelldb-bin` (`/usr/lib/codelldb/...`).
- **AUR instead of Mason** still works: `yay -S jdtls cmake-language-server
  vscode-langservers-extracted codelldb-bin` and drop those names from
  `mason_packages`. If both are installed, Mason's wins: its `bin/` is
  prepended to `PATH`.
- `rust_analyzer` is launched by [rustaceanvim](https://github.com/mrcjkb/rustaceanvim),
  not nvim-lspconfig. Do **not** call `lspconfig.rust_analyzer.setup{}`.
- `docker_language_server` deliberately omitted (no clean Arch pkg yet).
- Mason is also kept for ad-hoc tools (formatters, linters not in the
  distro repos). `automatic_enable` is disabled, so it never starts LSP
  clients itself; `vim.lsp.enable({...})` in `lsp.lua` decides which run.

Other system requirements:
- Neovim ≥ 0.12
- `tree-sitter` CLI: `pacman -S tree-sitter-cli`. The `tree-sitter` package
  is only the library; nvim-treesitter needs the CLI to install parsers.
- A C compiler and `make` (base-devel), for compiling parsers
- `cargo`, `rustc` (for cord.nvim build; `pacman -S rust`, see above)
- `ripgrep` and `fd`, for Telescope / pickers
- `lazygit`, for lazygit.nvim
- `unzip`, `wget`, `curl`, `tar`, for Mason. base-devel does **not** pull in
  `unzip` or `wget`.
- `nodejs`, `npm`, `python`, `jdk-openjdk`, for the Mason packages above

```bash
sudo pacman -S --needed tree-sitter-cli base-devel ripgrep fd lazygit unzip wget curl tar
```

### Headless machine (server over SSH)

Same packages, minus what needs a display or a local browser:

- **Skip:** image.nvim and its ImageMagick, `peek.nvim` and `typst-preview`
  (browser previews), VimTeX's viewer and TeX Live unless you compile LaTeX
  there, cord.nvim (Discord presence), and a clipboard tool. Clipboard goes
  through OSC 52 over SSH.
- **No AUR helper needed:** the AUR-only servers come from Mason (above).
  Skip `jdk-openjdk` if you won't edit Java there; Mason still installs
  `jdtls`, which just can't start.
- `:checkhealth` warnings about the clipboard, image rendering and the
  Perl/Ruby/Node/Python providers are expected there.

## Acknowledgements
