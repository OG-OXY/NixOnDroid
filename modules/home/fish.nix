{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    functions = {
      y = {
        body = ''
          set -l tmp (mktemp -t "yazi-cwd.XXXXX")
          command yazi $argv --cwd-file="$tmp"
          if set -l cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
          end
          rm -f -- "$tmp"
        '';
      };
      gback = {
        description = "Safely undo the last Git commit but keep file changes";
        body = ''
          if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
            echo (set_color red)"❌ Error: Not a git repository!"(set_color normal)
            return 1
          end
          echo (set_color yellow)"⏪ Undoing last commit safely (keeping modifications)..."(set_color normal)       git reset --soft HEAD~1
          echo (set_color green)"✨ Done! Check 'git status' to see your uncommitted files."(set_color normal)
        '';
      };
      start-ssh = {
        body = ''
          eval (command -v sshd) -p 8022 -f /dev/null -h ~/.ssh/ssh_host_ed25519_key -o "StrictModes=no" -o "UsePAM=no" -o "AuthorizedKeysFile=~/.ssh/authorized_keys"
        '';
      };
      start-llama = {
        body = ''
          ${pkgs.llama-cpp}/bin/llama-server \
            -m ~/.cache/llama.cpp/ggml-org_Qwen2.5-Coder-7B-Instruct-Q8_0-GGUF_qwen2.5-coder-7b-instruct-q8_0.gguf \
            --n-gpu-layers 33 \
            --threads 8 \
            --port 8080 $argv
        '';
      };
      start-claude = {
        description = "Launch Claude CLI with local model";
        body = ''
          set -x ANTHROPIC_BASE_URL "http://localhost:8080"
          set -x ANTHROPIC_API_KEY "local"
          claude --model Qwen2.5-Coder-7B-Instruct-Q8_0 $argv
        '';
      };
    };

    shellAbbrs = {
      ls = "ls -a";
      cds = "cd ~/.config/nix-on-droid/";
      ga = "git add -A";
      gc = "git commit -m \"";
      gf = "git fetch origin";
      gpo = "git pull origin master";
      gp = "git push -u origin master";
      gpf = "git push -u --force origin master";
      yz = "yazi";
      nv = "nvim";
      v = "vis";
      nrs = "nix-on-droid switch --flake .#nix-on-droid";
      nrsu = "nix-on-droid switch --upgrade --flake .#nix-on-droid";
      vm = "./result/bin/run-nixos-vm";
      nb = "nix-backup";
      nub = "nix-upgrade-backup";
      ts = "start-ssh";
    };

    shellInit = "";

    interactiveShellInit = ''
      set -g fish_greeting "Welcome to Nix-On-Droid!"
      set -g fish_handle_reflow 1
      fastfetch
      starship init fish | source
      if type -q direnv
          direnv hook fish | source
      end
    '';

    plugins = with pkgs.fishPlugins; [
      {
        name = "bass";
        src = bass.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "sponge";
        src = sponge.src;
      }
      {
        name = "done";
        src = done.src;
      }
      {
        name = "abbreviation-tips";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fish-abbreviation-tips";
          rev = "v0.7.0"; # Verified latest tag
          sha256 = "sha256-F1t81VliD+v6WEWqj1c1ehFBXzqLyumx5vV46s/FZRU=";
        };
      }
      {
        name = "fish-you-should-use";
        src = pkgs.fetchFromGitHub {
          owner = "paysonwallach";
          repo = "fish-you-should-use";
          rev = "master";
          sha256 = "sha256-MmGDFTgxEFgHdX95OjH3jKsVG1hdwo6bRht+Lvvqe5Y=";
        };
      }
    ];
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
