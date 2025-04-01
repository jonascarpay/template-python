# template-python

Simple Nix template for getting a Python development shell.

### Usage

1. Clone
2. Put dependencies to `myPython` in `flake.nix`
3. `nix flake develop`

### Setup

The development shell includes the following tools:
- `ruff` for linting
- `pyright` for type checking

These can all integrate into your editor with the right setup.
