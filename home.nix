{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
{
  # 1. State environment
  home = {
    username = "nix-on-droid";
    homeDirectory = "/data/data/com.termux.nix/files/home";
    stateVersion = "25.11";
    shellAliases = {
      start-claude = "claude --model ggml-org/Qwen2.5-Coder-7B-Instruct-Q8_0-GGUF:Q8_0";
    };
    file = {
      ".claude/settings.json".text = ''
        {
          "env": {
            "CLAUDE_CODE_ATTRIBUTION_HEADER": "0"
          "theme": "dark"
          }
        }
      '';
      ".bash_profile".text = ''
        if [[ -z "$FISH_ALREADY_STARTED" ]]; then
        export FISH_ALREADY_STARTED=1
        exec ${pkgs.fish}/bin/fish -l
        fi
      '';
    };
    packages =
      (with pkgs; [
        #PKGS
      ])
      ++ [
        #inputs.herdr.packages.aarch64-linux.default
      ];
  };

  imports = [
    ./modules/home/activation.nix
    ./modules/home/fish.nix
    ./modules/home/neovim.nix
    #./modules/home/neo.nix
    ./modules/home/fastfetch.nix
  ];

  xdg = {
    configFile = {
      "nvim" = {
        source = ./modules/home/NVIM;
        recursive = true;
      };
    };
    dataFile = {
      #
    };
  };

  programs = {
    home-manager.enable = true;
    tmux.enable = true;
    yazi = {
      enable = true;
      settings = {
        #.
      };
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      settings = {
        init.defaultbranch = "master";
        safe.directory = "*";
        user = {
          name = "og-oxy"; # <-- change to your name
          email = "ogoxy.yt@gmail.com"; # <-- change to your email
        };
      };
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "NixOS" = {
          hostname = "100.99.131.97";
          port = 22;
          user = "ty";
          extraOptions = {
            "StrictHostKeyChecking" = "no";
            "UserKnownHostsFile" = "/dev/null";
          };
        };
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      pinentry = {
        package = pkgs.pinentry-curses;
      };
    };
  };
}
