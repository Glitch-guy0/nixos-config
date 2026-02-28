# ============================================================
# PURPOSE:   Wraps a SOPS age secret reference with scope metadata.
# SCOPE:     shared
# USAGE:     lib.mkSecret { name = "api-key"; scope = "user"; owner = "alice"; }
# ============================================================
{ name, scope, owner ? null, path ? null }:
{
  sopsFile =
    if path != null      then path
    else if scope == "host"   then ../secrets/hosts/${owner}.yaml
    else if scope == "user"   then ../secrets/users/${owner}.yaml
    else ../secrets/shared/common.yaml;
  key = name;
}
