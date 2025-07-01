{
  description = "An backend project covering several advanced concepts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      withSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux" # TODO! NOT Verified
        "x86_64-darwin" # TODO! NOT Verified
        "aarch64-linux" # TODO! NOT Verified
        "aarch64-darwin" # Verified
      ];
      withPkgs =
        callback:
        withSystem (
          system:
          callback (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true; # Terraform is unfree software
            }
          )
        );
    in
    {
      devShells = withPkgs (pkgs: {
        default = pkgs.mkShell {
          packages = [
            # Those we don't need yet are commented out

            # Frontend UI language
            # pkgs.nodejs_22 # JS and NodeJS
            # pkgs.pnpm # Package manager

            # Backend service language
            pkgs.dotnetCorePackages.sdk_9_0 # C# and .NET
            pkgs.redocly # OpenAPI CLI and SPA generator

            # Platform language
            pkgs.terraform # IaC language
            pkgs.docker # Container

            # Project Management
            pkgs.hcloud # Hetzner Cloud CLI
            pkgs.just # Task runner
            pkgs.sops # Secrets managements
            pkgs.age # Encryption tool
          ];

          env = {
            DOTNET_ROOT = builtins.toString pkgs.dotnetCorePackages.sdk_9_0;
          };
        };
      });

      formatter = withPkgs (pkgs: pkgs.nixfmt-rfc-style);
    };
}
