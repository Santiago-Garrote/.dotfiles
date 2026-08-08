# Neovim Tooling Architecture

This repository keeps Neovim itself declarative and leaves editor behavior close
to upstream defaults.

## What Nix Installs

Home Manager enables NixVim, which generates the Neovim wrapper through Nix
modules. The current NixVim module intentionally only enables Neovim, sets it as
the default editor, and adds the `vi`/`vim` aliases.

External tools that should be available from `PATH`, such as `git`, `ripgrep`,
`fd`, `nixd`, and `nixfmt`, are managed separately from Neovim.

Project-specific tools should usually live in a project `devShell`. In this
repository, QML and Quickshell tools are provided by the flake dev shell.

## What NixVim Configures

`home/garro/programs/neovim/default.nix` is intentionally minimal. It does not
configure plugins, keymaps, language servers, formatters, linters, or custom
Lua. This keeps the editor equivalent to a plain Neovim package managed through
NixVim.

## Why Mason Is Disabled

Mason is not configured. Language servers, formatters, linters, debuggers, and
command-line tools should be managed by Nix when they are added later. This
keeps tool versions reproducible and avoids installing the same executable
through both Mason and Nix.

## Add a New Language

1. Add reusable tools to Home Manager or project-only tools to a `devShell`.
2. Add focused NixVim configuration in `home/garro/programs/neovim/default.nix`.
3. Configure any LSP, formatting, linting, and parser support to use
   executables from `PATH`.
4. Avoid Mason `ensure_installed` entries.
5. Run the repository validation commands.

## Inspect Runtime Status

Useful Neovim commands:

```vim
:checkhealth
:messages
```

## Update Plugins

Update the NixVim flake input:

```bash
nix flake update nixvim
```

Then review and commit `flake.lock` with the related NixVim configuration
change. With the current minimal setup, this updates NixVim itself rather than a
separate plugin lock file.

## Validate the Configuration

Repository checks:

```bash
nix fmt -- --check
nix flake check
nix eval ".#nixosConfigurations.laptop.config.system.build.toplevel.drvPath"
```

Neovim checks:

```vim
:checkhealth
:messages
```
