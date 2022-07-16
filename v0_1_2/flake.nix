{
  description = ''A dataframe library with a dplyr like API'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-datamancer-v0_1_2.flake = false;
  inputs.src-datamancer-v0_1_2.ref   = "refs/tags/v0.1.2";
  inputs.src-datamancer-v0_1_2.owner = "SciNim";
  inputs.src-datamancer-v0_1_2.repo  = "datamancer";
  inputs.src-datamancer-v0_1_2.type  = "github";
  
  inputs."github.com/vindaar/seqmath".owner = "nim-nix-pkgs";
  inputs."github.com/vindaar/seqmath".ref   = "master";
  inputs."github.com/vindaar/seqmath".repo  = "github.com/vindaar/seqmath";
  inputs."github.com/vindaar/seqmath".dir   = "";
  inputs."github.com/vindaar/seqmath".type  = "github";
  inputs."github.com/vindaar/seqmath".inputs.nixpkgs.follows = "nixpkgs";
  inputs."github.com/vindaar/seqmath".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."arraymancer".owner = "nim-nix-pkgs";
  inputs."arraymancer".ref   = "master";
  inputs."arraymancer".repo  = "arraymancer";
  inputs."arraymancer".dir   = "v0_7_13";
  inputs."arraymancer".type  = "github";
  inputs."arraymancer".inputs.nixpkgs.follows = "nixpkgs";
  inputs."arraymancer".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-datamancer-v0_1_2"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-datamancer-v0_1_2";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}