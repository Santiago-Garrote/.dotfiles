# AGENTS.md

## Purpose

This repository contains Santiago Garrote's personal NixOS and Home Manager
configuration.

The goal is to maintain a reproducible, declarative, understandable, and
visually coherent Linux environment.

Treat this repository as production configuration: changes can affect the
entire operating system and the user's ability to log in, launch applications,
or recover the machine.

## User context

Santiago is a Software Engineering student with previous experience using
Debian, Arch Linux, Ubuntu, Mint, and other Linux distributions.

He understands general Linux concepts but is still learning NixOS, Nix, Flakes,
and Home Manager.

When reporting work:

* Explain Nix-specific behavior in Spanish.
* Keep established technical terms in English when that is clearer.
* Explain why a change belongs in NixOS, Home Manager, or a project environment.
* Do not assume familiarity with Nix-specific abstractions.
* Prefer teaching the underlying structure over presenting configuration as
  unexplained magic.

All source code comments, documentation, commit messages, identifiers, and
repository files must be written in English.

## Repository identity

* Repository path: `$HOME/.dotfiles`
* Primary user: `garro`
* NixOS host: `laptop`
* Home Manager is integrated as a NixOS module.
* The repository uses Nix Flakes.
* The desktop environment is based on Hyprland.
* User configuration is managed declaratively whenever practical.

Always run repository commands from `$HOME/.dotfiles` unless the task requires
a different working directory.

Do not invent a different dotfiles path.

## Authoritative configuration

Before changing anything:

1. Inspect `flake.nix`.
2. Inspect the host configuration and its imports.
3. Inspect the relevant Home Manager module and its imports.
4. Search for an existing option, token, helper, package, or configuration
   before introducing a new one.
5. Check the current working tree before editing.

Do not assume that an example from the internet matches this repository's
structure or Nixpkgs version.

The repository itself is the source of truth.

## Engineering principles

Apply these principles in this order:

1. Correctness
2. Safety
3. KISS
4. DRY
5. Clear separation of responsibilities
6. Reproducibility
7. Extensibility

SOLID principles may be applied where they improve boundaries and
maintainability, but do not force object-oriented abstractions into Nix or QML.

Prefer the smallest change that completely solves the requested problem.

Do not introduce an abstraction for a single trivial value unless it represents
a meaningful domain concept or prevents an existing duplication.

Do not perform unrelated cleanup while implementing a requested change.

## NixOS and Home Manager responsibilities

Use NixOS modules for machine-level concerns, including:

* Hardware
* Boot configuration
* Filesystems
* Kernel configuration
* System services
* Networking
* Security policy
* System-wide environment behavior
* Login and display infrastructure

Use Home Manager modules for user-level concerns, including:

* User applications
* Shell configuration
* Editors
* Terminal configuration
* Desktop application configuration
* Hyprland user configuration
* Waybar
* Quickshell
* Notifications
* Launchers
* User themes
* User services

Because Home Manager is integrated into NixOS, do not introduce a separate
standalone Home Manager activation workflow unless explicitly requested.

Use project-local Flakes, `devShells`, and direnv for development dependencies
that belong to one software project rather than to the whole user environment.

## Declarative package management

Prefer declarative Nix configuration over imperative installation.

Do not use or recommend persistent installation through:

* `nix-env`
* `npm install --global`
* `pip install --user`
* `cargo install`
* `curl | sh`
* Application-managed language servers
* Mason-managed language servers
* Untracked manual files under `/etc`

Exceptions are allowed only when the user explicitly requests a temporary or
non-declarative solution.

When an imperative workaround is necessary:

* State that it is imperative.
* Explain why it is being used.
* Avoid mixing it silently with the declarative configuration.
* Provide a path toward a declarative solution when appropriate.

## Module design

Each module should have one clear responsibility.

Prefer small modules grouped by domain rather than one large configuration
file.

A module should normally:

* Declare configuration for one application or coherent subsystem.
* Consume shared values instead of redefining them.
* Avoid hidden side effects.
* Avoid depending on unrelated modules.
* Keep application-specific syntax inside the application adapter.

Before creating a new module, determine whether the change belongs in an
existing module.

Do not create generic helper libraries unless they remove real duplication or
express a stable repository concept.

Preserve the existing import structure unless restructuring is part of the
requested task.

## Theme architecture

The theme system must have a single source of truth.

The current primary palette is Industrial Amber:

* Background: `#16181A`
* Surface: `#202326`
* Border: `#3A3D3F`
* Foreground: `#C9C3B6`
* Muted: `#817D74`
* Accent: `#D08A2C`

Treat these as palette values, not values to duplicate throughout application
configuration.

Theme architecture must preserve this direction:

```text
Palette
  -> semantic design tokens
    -> application-specific adapters
```

Application modules such as Hyprland, Waybar, Kitty, Quickshell, launchers, and
notification daemons should consume semantic tokens.

Do not:

* Copy raw hexadecimal colors into multiple application modules.
* Make an application adapter the authoritative theme definition.
* Couple the palette directly to one application's property names.
* Introduce a second competing source of theme values.

Prefer semantic names such as:

* `background`
* `surface`
* `border`
* `foreground`
* `muted`
* `accent`

Add more semantic tokens only when they represent a real repeated visual role.

## Visual direction

The desktop follows an industrial electronics and machinery aesthetic.

Prefer:

* Functional layouts
* Strong information hierarchy
* Restrained decoration
* Consistent spacing
* Industrial instrumentation influences
* Amber status and signal accents
* Dark neutral surfaces
* Clear state feedback

Avoid:

* Decoration without a purpose
* Excessive gradients
* Excessive transparency
* Inconsistent rounded corners
* Arbitrary animations
* Multiple unrelated accent colors
* Recreating the same visual information in several components

The long-term wallpaper direction is to move useful information into live
desktop widgets and leave only non-functional decorative elements in the static
wallpaper.

Do not implement that entire direction opportunistically during an unrelated
task.

## Hyprland

Preserve the repository's existing Hyprland configuration approach and syntax.

Before adding an option:

* Confirm that it exists in the installed Hyprland version.
* Check whether the repository already configures the same behavior elsewhere.
* Avoid copying configuration written for an incompatible Hyprland version.

Keep keybindings grouped by purpose.

Do not silently replace existing keybindings.

When adding a binding, report:

* The selected key combination
* Its action
* Any conflict found
* The file where it was added

Do not restart Hyprland or terminate the active session without explicit
permission.

## Quickshell and QML

Santiago wants to learn Quickshell and QML by building widgets incrementally.

Unless explicitly asked for a complete implementation:

* Prefer a small working step.
* Explain the QML or Quickshell concept involved.
* Avoid generating an entire widget framework at once.
* Keep components focused and composable.
* Separate data acquisition, state, presentation, and interaction where useful.
* Avoid premature abstractions.
* Reuse theme tokens rather than embedding visual constants.
* Keep shell commands out of presentation components when practical.

Do not claim that QML code is type-safe or memory-safe in the same sense as
Rust.

When external commands are required, validate their output and failure modes.

## Neovim and development tooling

Prefer Nix-managed external development tools, including:

* Language servers
* Formatters
* Linters
* Debug adapters
* Compilers
* Runtime dependencies

Neovim plugins may use the repository's chosen plugin management approach, but
external executables should not be silently installed by editor plugins.

Do not introduce Mason as the source of language servers unless explicitly
requested.

Keep editor configuration independent from one specific development project
when the functionality is generally useful.

Use project-local development environments for project-specific tools.

## State versions and Flake inputs

Never change any of the following without explicit user approval:

* `system.stateVersion`
* `home.stateVersion`
* Nixpkgs release branches
* Home Manager release branches
* Flake input sources
* Lock file dependencies beyond what the task requires

Do not change a state version merely because a newer NixOS release exists.

Do not run a broad `nix flake update` when only one input needs to change.

When updating an input, prefer a targeted lock-file update and report exactly
which input changed.

## Hardware configuration

Treat `hardware-configuration.nix` as generated machine-specific configuration.

Do not edit it for organization, formatting, theming, package installation, or
general cleanup.

Modify it only when the task specifically concerns detected hardware,
filesystems, swap, or another machine-level requirement and the change is
understood.

Never delete or regenerate it without explicit approval.

## Secrets and private data

Never add secrets, credentials, tokens, private keys, passwords, cookies, or
machine-specific authentication data to Git.

Before adding a file, check whether it may contain private data.

Do not print secret values in command output or summaries.

Use references to secret-management mechanisms rather than embedding secrets in
Nix expressions.

Do not modify SSH keys, GPG keys, browser profiles, password stores, or
authentication agents unless explicitly requested.

## File editing rules

Before editing a file:

* Read the relevant surrounding configuration.
* Search for duplicate declarations.
* Identify whether the file is generated.
* Preserve unrelated user changes.
* Preserve the existing formatting style unless it is clearly inconsistent.

After editing:

* Review the resulting diff.
* Check for duplicated options.
* Check for dead imports.
* Check for accidental absolute paths.
* Check for values that belong in the shared theme.
* Check that no unrelated files changed.

Never overwrite an entire file when a focused edit is sufficient.

Never discard user changes to make a patch apply.

## Command safety

Do not execute destructive or system-activating commands without explicit
approval.

This includes:

* `sudo nixos-rebuild switch`
* `sudo nixos-rebuild boot`
* `sudo nixos-rebuild test`
* `home-manager switch`
* Session restarts
* Reboots
* Shutdowns
* Filesystem formatting
* Partition changes
* Deleting configuration directories
* Recursive deletion
* Git history rewriting
* Force pushes

Do not use `sudo` unless the user explicitly approves the specific operation.

Never run commands equivalent to:

```text
rm -rf
git reset --hard
git clean -fd
git checkout -- .
git restore .
```

Use targeted operations and explain their scope.

Do not kill desktop, audio, game, or session processes as part of unrelated
work.

## Validation

Use the least expensive validation that provides meaningful confidence.

For every change:

1. Review `git diff`.
2. Run `git diff --check`.
3. Run the most relevant local syntax, formatting, or configuration check
   available.
4. Run broader Nix validation when the change affects Nix configuration.

The baseline repository validation command is:

```bash
nix flake check
```

When a NixOS or integrated Home Manager change requires a complete build, use
the non-activating system build when appropriate:

```bash
nix build .#nixosConfigurations.laptop.config.system.build.toplevel
```

Do not activate the result without explicit approval.

If validation cannot run because of network access, sandbox restrictions,
untracked Flake files, missing dependencies, or an existing unrelated failure:

* Do not claim that validation passed.
* Report the exact command attempted.
* Summarize the relevant failure.
* Distinguish an existing failure from one introduced by the current change.

Do not fix unrelated validation failures unless requested.

## Git workflow

Assume the working tree may contain valuable user changes.

Before modifying files, inspect:

```bash
git status --short
```

Do not:

* Stage files without being asked.
* Commit without being asked.
* Push without being asked.
* Amend commits without being asked.
* Rebase without being asked.
* Rewrite history.
* Remove untracked files.
* Revert unrelated changes.

When asked to create a commit:

* Keep it small and focused.
* Use Conventional Commits.
* Write the commit message in English.
* Include only files belonging to the requested change.
* Review the staged diff before committing.

Examples:

```text
feat(theme): add semantic warning token
fix(hyprland): correct fullscreen keybinding
refactor(home): split terminal configuration module
docs(quickshell): explain widget module structure
chore(flake): update home-manager input
```

## Documentation

Documentation must explain decisions, not merely restate configuration.

Update documentation when a change affects:

* Repository structure
* Setup steps
* User-facing behavior
* Architecture
* Required commands
* Known limitations
* Recovery procedures

Keep documentation in English.

Do not create documentation files for trivial implementation details.

Do not create or update a progress log unless the user requests it or the
repository already defines that workflow.

## Decision making

When several approaches are valid, prefer the one that:

1. Matches the existing repository architecture.
2. Is declarative.
3. Has the smallest operational surface.
4. Is easiest for a new NixOS user to understand.
5. Avoids duplicated state.
6. Can be validated without activating the system.
7. Is easy to revert through Git.

If a meaningful architectural choice remains, present the options and make a
clear recommendation.

Do not ask for confirmation for minor implementation details that can be safely
inferred.

Do ask before:

* Activating system configuration
* Changing release channels
* Changing state versions
* Deleting data
* Reorganizing large portions of the repository
* Introducing a major framework
* Replacing an established component
* Making an irreversible change

## Scope discipline

Complete the requested task and stop.

Do not opportunistically:

* Rewrite unrelated modules.
* Rename broad directory structures.
* Replace working applications.
* Update all dependencies.
* Apply a new formatting style repository-wide.
* Convert every repeated expression into an abstraction.
* Implement future roadmap items.
* Commit or push the result.

Record unrelated issues as observations rather than changing them.

## Final response format

After completing a task, report the result in Spanish using this structure:

### Resultado

A concise explanation of what was completed.

### Archivos modificados

* `path/to/file`: purpose of the change

Omit this section when no files changed.

### Validación

List each command executed and whether it passed, failed, or was not run.

Never say that a check passed unless it was actually executed successfully.

### Decisiones

Explain only the important architectural or Nix-specific decisions.

Omit this section when there were no meaningful decisions.

### Pendiente

List remaining work, required manual activation, or known limitations.

If system activation is required, provide the exact command but do not run it
without approval.

Keep the final report concise enough that Santiago can paste it into the
NixOS Ricing ChatGPT project as a progress update.
