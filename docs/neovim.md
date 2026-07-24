# Neovim Tooling Architecture

This repository keeps editor plugins and external development tools separate.

## What Nix Installs

Home Manager enables Neovim, sets it as the default editor, and installs the
Neovim wrapper. Nix also installs external tools that should be available from
`PATH`, such as:

- `git`, `ripgrep`, and `fd` for general editor and shell workflows.
- `nixd` for Nix language server support.
- `nixfmt-rfc-style`, exposed as `nixfmt`, for Nix formatting.

Project-specific tools should usually live in a project `devShell`. In this
repository, QML and Quickshell tools are provided by the flake dev shell.

## What lazy.nvim Installs

`lazy.nvim` manages Neovim plugins. The configuration imports LazyVim defaults
and local plugin specs from `lua/plugins/`.

Plugin lock state belongs in `lazy-lock.json`.

## Why Mason Is Disabled

Mason is disabled because language servers, formatters, linters, debuggers, and
command-line tools are managed by Nix. This keeps tool versions reproducible and
avoids installing the same executable through both Mason and Nix.

## Add a New Language

1. Add reusable tools to Home Manager or project-only tools to a `devShell`.
2. Add a focused plugin spec in `lua/plugins/<language>.lua`.
3. Configure LSP, formatting, linting, and parsers to use executables from
   `PATH`.
4. Avoid Mason `ensure_installed` entries.
5. Run the repository validation commands.

## Inspect LSP Status

Useful Neovim commands:

```vim
:checkhealth
:checkhealth vim.lsp
:LspInfo
:messages
```

## Inspect Formatter Selection

Use:

```vim
:ConformInfo
:set filetype?
```

For Nix files, formatting should resolve to `nixfmt`.

## Update Plugins

Use:

```vim
:Lazy
```

After updating plugins, review and commit `lazy-lock.json` with the related
Neovim configuration change.

## Validate the Configuration

Repository checks:

```bash
nix fmt -- --check
nix flake check
nix eval ".#nixosConfigurations.laptop.config.system.build.toplevel.drvPath"
```

Neovim checks:

```vim
:LazyHealth
:checkhealth
:checkhealth vim.lsp
:LspInfo
:ConformInfo
:messages
```
