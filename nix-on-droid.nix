{
  pkgs,
  #config,
  #lib,
  #inputs,
  ...
}:
{

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  user.shell = "${pkgs.fish}/bin/fish";

  # System PKGS.
  environment = {
    sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
      EDITOR = "nvim";
      VISUAL = "nvim";
      ANTHROPIC_BASE_URL = "http://localhost:8080";
      ANTHROPIC_API_KEY = "local";
      ANTHROPIC_AUTH_TOKEN = "local";
    };
    packages = with pkgs; [
      fish
      vis
      git
      openssh
      claude-code
      llama-cpp
      tree
      dysk
      btop
      # Neovim TS and Dependencies.
      tree-sitter
      vimPlugins.nvim-treesitter.withAllGrammars
      lazygit
      trash-cli
      imagemagick
      ghostscript
      # Nix LS, Format and Linters.
      nixd
      nixfmt
      statix
      deadnix
      # Fish shell LS.
      fish-lsp
      # Python LS, Black Format.
      pyright
      black
      # Lua LS and Stylua Format.
      lua-language-server
      stylua
      #  bash, html, cssls, jsonls, eslint, LS's and javascript prettier format.
      nodePackages.bash-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.prettier
      # .toml
      taplo
      # Markdown
      marksman
      # jq json cli formatter/bug squasher.
      jq
      # Linter and formatter for yaml.
      yamllint
      yamlfmt
      #.xml
      lemminx
      # GNU Core-Lib/Utils.
      gawk
      curl
      wget2
      wget
      ripgrep
      fd
      gnumake
      #gcc
      clang
      clang-tools
      rustc
      rust-analyzer
      cargo
      yarn
      nodejs
      ruby
      python3
      ncurses
      pinentry-curses
      procps
      killall
      diffutils
      findutils
      util-linux
      tzdata
      hostname
      man
      gnugrep
      gnupg
      gnused
      gnutar
      bzip2
      gzip
      xz
      zip
      unzip
    ];
    #++ [
    #inputs.nixCats.packages.aarch64-linux.default
    #inputs.nvf.packages.aarch64-linux.default
    #];
    etcBackupExtension = ".bak";
  };

  time.timeZone = "America/New_York";
  system.stateVersion = "24.05";
}
