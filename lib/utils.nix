# ============================================================
# PURPOSE:   Pure utility functions.
# SCOPE:     global
# ============================================================
_:
{
  # Example utility
  capitalize = str:
    let
      firstChar = lib.substring 0 1 str;
      rest = lib.substring 1 (lib.stringLength str - 1) str;
    in
      lib.toUpper firstChar + rest;
}
