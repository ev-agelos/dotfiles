{ config, pkgs, ... }:

{
  home.username = "evangelos";
  home.homeDirectory = "/home/evangelos";
  xdg.enable = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.xorg.xset
    pkgs.xorg.setxkbmap
    pkgs.xcape
    pkgs.starship
    pkgs.carapace
    pkgs.pew

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/starship.toml".source = ./starship.toml;
    ".config/kitty".source = ./kitty;
    ".config/nvim".source = ./neovim;
    ".config/git".source = ./git;
    ".config/ripgrep".source = ./ripgrep;
    ".pdbrc.py".source = ./python/pdbrc.py;
    ".config/ipython".source = ./python/ipython;
    ".config/pythonrc".source = ./python/pythonrc;
    ".config/mpv".source = ./mpv;

    # Set up to run these commands in an autostart script
    ".local/bin/setup_keyboard".source = ./scripts/setup_keyboard;
    ".config/autostart/setxkbmap-xcape.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=${config.home.homeDirectory}/.local/bin/setup_keyboard
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    X-GNOME-Autostart-Delay=4
    Name=Faster cursor and caps lock mapping to Esc and Ctrl
    '';

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/evangelos/etc/profile.d/hm-session-vars.sh
  home.sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.sessionVariables.PYENV_ROOT}/bin"
      "${config.home.sessionVariables.GOPATH}/bin"
      "/usr/local/go/bin"
      "${config.home.sessionVariables.CARGO_HOME}/bin"
      "${config.home.sessionVariables.FNM_PATH}"
      "${config.home.sessionVariables.JAVA_HOME}/bin"
      "${config.home.sessionVariables.XDG_DATA_HOME}/coursier/bin"
  ];
  home.sessionVariables = {
    GOPATH = "${config.home.sessionVariables.XDG_DATA_HOME}/";
    RIPGREP_CONFIG_PATH = "${config.home.sessionVariables.XDG_CONFIG_HOME}/ripgrep/rgrc";
    RUSTUP_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/rustup";
    ANSIBLE_HOME = "${config.home.sessionVariables.XDG_CONFIG_HOME}/ansible";
    ANSIBLE_CONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/ansible/ansible.cfg";
    PYLINTHOME = "${config.home.sessionVariables.XDG_CONFIG_HOME}/pylint";
    PYTHON_HISTORY = "${config.home.sessionVariables.XDG_STATE_HOME}/python/history";
    PYTHONPYCACHEPREFIX = "${config.home.sessionVariables.XDG_CACHE_HOME}/python";
    PYTHONUSERBASE = "${config.home.sessionVariables.XDG_DATA_HOME}/python";
    IPYTHONDIR = "${config.home.sessionVariables.XDG_CONFIG_HOME}/ipython";
    PYTHONSTARTUP = "${config.home.sessionVariables.XDG_CONFIG_HOME}/pythonrc";
    PYENV_ROOT = "${config.home.sessionVariables.XDG_DATA_HOME}/pyenv";
    JUPYTER_PLATFORM_DIRS = 1;
    DOCKER_CONFIG="${config.home.sessionVariables.XDG_CONFIG_HOME}/docker";
    MYPY_CACHE_DIR = "${config.home.sessionVariables.XDG_CONFIG_HOME}/mypy_cache";
    RUFF_CACHE_DIR = "${config.home.sessionVariables.XDG_CONFIG_HOME}/ruff";
    NPM_CONFIG_USERCONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/npm/npmrc";
    PASSWORD_STORE_DIR = "${config.home.sessionVariables.XDG_DATA_HOME}/pass";
    GNUPGHOME = "${config.home.sessionVariables.XDG_DATA_HOME}/gnupg";
    CARGO_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/cargo";
    PSQL_HISTORY = "${config.home.sessionVariables.XDG_STATE_HOME}/psql_history";
    PGPASSFILE = "${config.home.sessionVariables.XDG_CONFIG_HOME}/pg/pgpass";
    ICEAUTHORITY = "${config.home.sessionVariables.XDG_CACHE_HOME}/ICEauthority";
    LESSHISTFILE = "-";
    LESS = "-R";
    EDITOR = "nvim";
    MANPAGER = "nvim --appimage-extract-and-run +Man!";
    TERMINAL = "kitty";
    JAVA_HOME = "${config.home.sessionVariables.XDG_CACHE_HOME}/coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u2920b10/OpenJDK8U-jdk_x64_linux_hotspot_8u292b10.tar.gz/jdk8u2920b10";
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.home.sessionVariables.XDG_CONFIG_HOME}/java -Djava.util.prefs.userRoot=${config.home.sessionVariables.XDG_CONFIG_HOME}/java";
    FNM_PATH = "${config.home.sessionVariables.XDG_DATA_HOME}/fnm";
    KUBECONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/kube";
    KUBECACHEDIR = "${config.home.sessionVariables.XDG_CACHE_HOME}/kube";
    AZURE_CONFIG_DIR = "${config.home.sessionVariables.XDG_DATA_HOME}/azure";

    WGETRC = "${config.home.sessionVariables.XDG_CONFIG_HOME}/wgetrc";
    TASKDATA = "${config.home.sessionVariables.XDG_CONFIG_HOME}/task";
    TASKRC = "${config.home.sessionVariables.XDG_CONFIG_HOME}/taskrc";
    NODE_REPL_HISTORY = "${config.home.sessionVariables.XDG_DATA_HOME}/node_repl_history";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
        sbt = "sbt -ivy ${config.home.sessionVariables.XDG_CONFIG_HOME}/ivy2 -sbt-dir ${config.home.sessionVariables.XDG_DATA_HOME}/sbt";
        wget = "wget --hsts-file=${config.home.sessionVariables.XDG_CACHE_HOME}/wget-hsts";
        tbls = "tbls --config ${config.home.sessionVariables.XDG_CONFIG_HOME}/tbls.yaml";
        kubectl = "kubectl --cache-dir ${config.home.sessionVariables.KUBECACHEDIR}";
    };
  };
  programs.nushell.enable = true;
}
