{ config, ... }:

let
  homeDir = name: "${config.home.homeDirectory}/${name}";
in
{
  xdg.userDirs = {
    enable = true;
    createDirectories = false;

    desktop = homeDir "desktop";
    documents = homeDir "documents";
    download = homeDir "downloads";
    music = homeDir "music";
    pictures = homeDir "pictures";
    projects = homeDir "projects";
    publicShare = homeDir "public";
    templates = homeDir "templates";
    videos = homeDir "videos";
  };

  # Export the XDG_*_DIR variables to the whole systemd user session (not just
  # shells), matching the previous environment.d/20-xdg-user-dirs.conf.
  systemd.user.sessionVariables = {
    XDG_DESKTOP_DIR = config.xdg.userDirs.desktop;
    XDG_DOCUMENTS_DIR = config.xdg.userDirs.documents;
    XDG_DOWNLOAD_DIR = config.xdg.userDirs.download;
    XDG_MUSIC_DIR = config.xdg.userDirs.music;
    XDG_PICTURES_DIR = config.xdg.userDirs.pictures;
    XDG_PROJECTS_DIR = config.xdg.userDirs.projects;
    XDG_PUBLICSHARE_DIR = config.xdg.userDirs.publicShare;
    XDG_TEMPLATES_DIR = config.xdg.userDirs.templates;
    XDG_VIDEOS_DIR = config.xdg.userDirs.videos;
  };
}
