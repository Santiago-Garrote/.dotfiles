# Recreate the System

This document describes the steps needed to recreate Santiago's NixOS laptop
from this repository.

The repository is the source of truth for NixOS and Home Manager
configuration. Secrets, SSH private keys, browser profiles, and other
machine-local state are intentionally not stored here.

## 1. Install NixOS

Install NixOS on the target machine using the normal installer.

During partitioning and installation, make sure the generated hardware
configuration matches the target machine. This repository contains
`nixos/hardware-configuration.nix` for the current laptop and should only be
reused on the same hardware or after careful review.

## 2. Clone the Dotfiles

Clone this repository into the expected path:

```bash
git clone <repository-url> /home/garro/.dotfiles
cd /home/garro/.dotfiles
```

The flake expects the host configuration to be available from this repository.

## 3. Review Machine-Specific Files

Before activation, review:

```bash
nixos/hardware-configuration.nix
nixos/system/state-version.nix
home/garro/core/identity.nix
```

Do not change `system.stateVersion` or `home.stateVersion` during recreation
unless intentionally migrating state semantics.

## 4. Validate Without Activating

Run the repository validation script:

```bash
./scripts/validate
```

For a direct flake check:

```bash
nix flake check
```

If new untracked files are present during local development, validate the
working tree with:

```bash
nix flake check path:/home/garro/.dotfiles
```

## 5. Build Without Activating

Build the system closure without switching the running system:

```bash
nix build /home/garro/.dotfiles#nixosConfigurations.laptop.config.system.build.toplevel
```

This catches build issues without activating the configuration.

## 6. Activate the System

After validation and build succeed, activate the configuration:

```bash
sudo nixos-rebuild switch --flake /home/garro/.dotfiles#laptop
```

Home Manager is integrated as a NixOS module, so this command also applies the
user configuration for `garro`.

## 7. Restore SSH Identities

SSH private keys are not stored in this repository.

The current profile paths are:

```text
~/.ssh/id_ed25519
~/.ssh/id_ed25519_austral
```

If the faculty key does not exist, create it manually:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_austral -C "sgarrote@mail.austral.edu.ar"
```

Register the corresponding `.pub` key with the required Git provider or
faculty service.

## 8. Development Profiles

Home Manager creates these profile roots:

```text
~/dev/personal
~/dev/faculty
```

Git repositories under each root automatically receive the matching Git
identity and SSH configuration.

Direnv is configured with an exact allowlist for the generated profile
`.envrc` files, so these two profile roots should not require a manual
`direnv allow` after activation.

## 9. Manual State Not Covered

Recreate or restore these outside the repository:

- SSH private keys and agent state.
- GPG keys.
- Browser profiles and login sessions.
- Password stores and credentials.
- Downloaded games, Flatpak application state, and other large user data.
- Any project-specific secrets or `.env` files.

Do not add these files to Git.
