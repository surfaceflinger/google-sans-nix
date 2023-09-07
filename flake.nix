{
  description = "Google Sans font extracted from ChromeOS packaged for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "armv7l-linux" "riscv64-linux" ];

      imports = [ flake-parts.flakeModules.easyOverlay ];

      perSystem = { config, self', pkgs, ... }: {
        packages.google-sans = pkgs.runCommand "google-sans" { src = ./.; } ''
          install -Dm644 $src/google-sans/{static,variable}/* -t $out/share/fonts/truetype
        '';
        packages.default = self'.packages.google-sans;
      };
    };
}
