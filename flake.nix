{

  description = "Nix project templates";

  outputs = { self }: {
    templates = {

      rust = {
        path = ./rust;
        description = "Rust template";
      };

      python-uv = {
        path = ./python-uv;
        description = "uv, with nix providing uv, pyright, ruff and the python interpreter";
        welcomeText = ''
          # Getting started
          To initialize the project, enter the dev shell, and run `uv init`.

          # Configuration
          After initializing, the "ruff.toml" and "pyrightconfig.json" files can optionally be combined with "pyproject.toml".

          ## pyright
          ```
          [tool.pyright]
          strict = true
          venvPath = "."
          venv = ".venv"
          ```

          ## ruff
          ```
          [tool.ruff.lint]
          target-version = "py312"
          line-length = 160
          select = [ "ALL" ]
          ignore = [
            # disable as necessary
          ]
          ```
        '';
      };

      python-vanilla = {
        description = "pure nix python project template";
        path = ./python-vanilla;
      };

    };
  };
}
