{

  description = "Nix + Python project templates";

  outputs = { self }: {
    templates = {
      default = self.templates.vanilla;
      uv = {
        description = "UV Python project template";
        path = ./uv;
      };
      vanilla = {
        description = "Pure Nix Python project template";
        path = ./vanilla;
      };
    };
  };
}
