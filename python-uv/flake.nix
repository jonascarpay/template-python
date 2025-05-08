{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.mkflake.url = "github:jonascarpay/mkflake";

  outputs = { self, nixpkgs, mkflake }: mkflake.lib.mkflake {
    perSystem = system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python3;
      in
      {
        devShells.default = pkgs.mkShell {
          env = {
            UV_NO_MANAGED_PYTHON = "1";
            UV_PYTHON_DOWNLOADS = "never";
            UV_PYTHON = python.interpreter;
          };
          shellHook = ''
            # Copied from https://pyproject-nix.github.io/uv2nix/usage/hello-world.html, not sure what the exact point is
            unset PYTHONPATH
          '';
          packages = [
            python
            pkgs.uv
            pkgs.pyright
            pkgs.ruff
          ];
        };
      };
  };

}
