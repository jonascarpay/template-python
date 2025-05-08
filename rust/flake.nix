{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
    rust-overlay.url = "github:oxalica/rust-overlay";
    mkflake.url = "github:jonascarpay/mkflake";
  };

  outputs = { nixpkgs, mkflake, rust-overlay, ... }: mkflake.lib.mkflake {
    perSystem = system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            rust-overlay.overlays.default
            (final: prev: {
              PKGNAME = final.callPackage PKGNAME-pkg { };
            })
          ];
        };
        rust-env = pkgs.rust-bin.selectLatestNightlyWith
          (toolchain: toolchain.default.override {
            extensions = [
              "rust-analyzer"
              "clippy"
              "rustfmt"
              "rust-src"
            ];
            targets = [
              "x86_64-unknown-linux-musl"
            ];
          });

        PKGNAME-pkg = { rustPlatform }: rustPlatform.buildRustPackage {
          pname = "PKGNAME";
          version = "0.1";
          src = ./.;
          cargoLock.lockFile = ./Cargo.lock;
        };

      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            rust-env
          ];
        };
        packages = rec {
          default = PKGNAME;
          PKGNAME = pkgs.PKGNAME;
          PKGNAME-static = pkgs.pkgsStatic.PKGNAME;
        };
      };
  };
}
