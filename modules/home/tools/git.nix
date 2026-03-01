# ============================================================
# PURPOSE:   Git user configuration.
# SCOPE:     user
# ============================================================
{ ... }:
{
  programs.git = {
    enable = true;
    # userEmail = "..."; # Set in profiles
    # userName  = "...";
  };
}
