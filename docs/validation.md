# Repository Validation

Run the full non-activating validation workflow from the repository root:

```bash
./scripts/validate
```

The script checks:

- Nix formatting with `nix fmt -- --check`.
- Flake outputs with `nix flake check`.
- Evaluation of the `laptop` NixOS system derivation path.

This does not activate the system and does not run `nixos-rebuild switch`.
