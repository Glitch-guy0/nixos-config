# ============================================================
# PURPOSE:   Auto-import every .nix file in a directory as a module list.
# SCOPE:     global
# USAGE:     imports = lib.importDir ./modules/home;
# ============================================================
dir:
builtins.filter (p: p != null)
  (map (f:
    let path = dir + "/${f}";
    in if builtins.hasSuffix ".nix" f && f != "default.nix"
       then path else null
  ) (builtins.attrNames (builtins.readDir dir)))
