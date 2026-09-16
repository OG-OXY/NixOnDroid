{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
{
  home.activation = {
    linkStorageDirect = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -L "$HOME/sdcard" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/sdcard"
        $DRY_RUN_CMD rm -rf "$HOME/sdcard"
        $DRY_RUN_CMD ln -s /sdcard "$HOME/sdcard/"
      fi
      if [ ! -L "$HOME/Downloads" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/Downloads"
        $DRY_RUN_CMD rm -rf "$HOME/Downloads"
        $DRY_RUN_CMD ln -s /sdcard/Downloads "$HOME/Downloads/"
      fi
      if [ ! -L "$HOME/Documents" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/Documents"
        $DRY_RUN_CMD rm -rf "$HOME/Documents"
        $DRY_RUN_CMD ln -s /sdcard/Documents "$HOME/Documents/"
      fi
      if [ ! -L "$HOME/Media/Pictures" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/Media/Pictures"
        $DRY_RUN_CMD rm -rf "$HOME/Media/Pictures"
        $DRY_RUN_CMD ln -s /sdcard/Pictures "$HOME/Media/Pictures/"
      fi
      if [ ! -L "$HOME/Media/Music" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/Media"
        $DRY_RUN_CMD rm -rf "$HOME/Media/Music"
        $DRY_RUN_CMD ln -s /sdcard/Music "$HOME/Media/Music/"
      fi
      if [ ! -L "$HOME/Media/Movies" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/Media"
        $DRY_RUN_CMD rm -rf "$HOME/Media/Movies"
        $DRY_RUN_CMD ln -s /sdcard/Movies "$HOME/Media/Movies/"
      fi
      if [ ! -L "$HOME/Media/Recordings" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/Media"
        $DRY_RUN_CMD rm -rf "$HOME/Media/Recordings"
        $DRY_RUN_CMD ln -s /sdcard/Recordings/ "$HOME/Media/Recordings/"
      fi
      if [ ! -L "$HOME/Media/Camera" ]; then
        $DRY_RUN_CMD mkdir -p "$HOME/Media"
        $DRY_RUN_CMD rm -rf "$HOME/Media/Camera"
        $DRY_RUN_CMD ln -s /sdcard/Camera "$HOME/Media/Camera/"
      fi
    '';
  };
}
