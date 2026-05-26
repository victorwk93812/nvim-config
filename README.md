# Neovim Configuration Files

Just threw in onto Github in case my disk memories randonly crash.

## Prerequisites (Arch Linux)

LSPs and the debug adapter are installed system-wide rather than via Mason.
This keeps them shared with other editors, managed by `pacman -Syu`, and
avoids Mason's slow per-machine downloads (codelldb is ~32 MB).

```bash
yay -S --needed \
  lua-language-server \
  rust-analyzer \
  pyright \
  jdtls \
  texlab \
  clang \
  bash-language-server \
  cmake-language-server \
  gopls \
  deno \
  zls \
  vscode-langservers-extracted \
  yaml-language-server \
  tinymist \
  codelldb-bin
```

| Mason name | Arch pkg | Repo |
|---|---|---|
| `lua_ls` | `lua-language-server` | extra |
| `rust_analyzer` | `rust-analyzer` | extra |
| `pyright` | `pyright` | extra |
| `jdtls` | `jdtls` | extra |
| `texlab` | `texlab` | extra |
| `clangd` | `clang` | extra |
| `bashls` | `bash-language-server` | AUR |
| `cmake` | `cmake-language-server` | AUR |
| `gopls` | `gopls` | extra |
| `denols` | `deno` | extra |
| `zls` | `zls` | AUR |
| `jsonls` | `vscode-langservers-extracted` | extra |
| `yamlls` | `yaml-language-server` | extra |
| `tinymist` | `tinymist` | AUR |
| (DAP) | `codelldb-bin` | AUR |

Notes:
- `codelldb-bin` (binary release) used; the source `codelldb` pkg can fail
  to build. Adapter path: `/usr/lib/codelldb/adapter/codelldb`,
  liblldb: `/usr/lib/codelldb/lldb/lib/liblldb.so`. Wired in
  `lua/plugins/rustaceanvim.lua` and `lua/plugins/nvim-dap.lua`.
- `rust_analyzer` is launched by [rustaceanvim](https://github.com/mrcjkb/rustaceanvim),
  not nvim-lspconfig. Do **not** call `lspconfig.rust_analyzer.setup{}`.
- `docker_language_server` deliberately omitted (no clean Arch pkg yet).
- Mason is still installed for ad-hoc tools (formatters, linters not in
  the distro repos) but `automatic_enable` is disabled so it never spawns
  duplicate LSP clients alongside the system binaries.

Other system requirements:
- Neovim ≥ 0.12
- `tree-sitter` CLI (`pacman -S tree-sitter`)
- `cargo`, `rustc` (for cord.nvim build; `pacman -S rust`)
- `unzip`, `curl`, `tar`, a C compiler (already pulled by base-devel)

## Acknowledgements
