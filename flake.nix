{
  description = "A node flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self , nixpkgs, nixpkgs-unstable }: let
    system = "x86_64-linux";
  
  in {

    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };

      unstablepk = import nixpkgs-unstable { inherit system; };
    
    in pkgs.mkShell {
      
      packages = with pkgs; [
        nodejs_18
        nodePackages.pnpm
        unstablepk.hugo
      ];


      shellHook = ''
        echo "node `${pkgs.nodejs}/bin/node --version`"
      '';
    }; 
  };
}
