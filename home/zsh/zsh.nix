{
  config,
  pkgs,
  ...
}:
{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    antidote.enable = true;
    autocd = true;

    antidote.plugins = [
      "romkatv/powerlevel10k kind:fpath"
    ];

    shellAliases = {
      "sudo" = "sudo ";
      "pi" = "ssh jan-schlachter.com";
      "micron" = "ssh biqu@192.168.178.35";
      "ltm" = "latexmk -silent";
      "f" = "firefox";
      # do I need this one really?
      "ts" = "tmux source ~/.config/tmux/tmux.conf";
    };

    initExtra = ''
      bindkey "^N" clear-screen
      bindkey "^I" autosuggest-accept

      # for yazi tui file explorer
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      # for powerlevel10k
      [[ ! -f ${./p10k.zsh} ]] || source ${./p10k.zsh}
      autoload -Uz promptinit && promptinit && prompt powerlevel10k
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
