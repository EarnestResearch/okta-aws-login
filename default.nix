{ pkgs ? import ./nixpkgs { }
}:
pkgs.haskell-nix.stackProject
  {
    src = pkgs.haskell-nix.haskellLib.cleanGit { name = "okta-aws-login"; src = ./.; };

    modules = [
      {
        packages.okta-aws-login.doHaddock = false;
        packages.okta-aws-login.cabal-generator = pkgs.lib.mkForce null;
        packages.okta-aws-login.dontStrip = false;
        packages.okta-aws-login.enableShared = false;
        packages.okta-aws-login.enableStatic = true;
      }
    ];
  } // {
  pre-commit-check = pkgs.callPackage nix/precommit.nix { };
}
