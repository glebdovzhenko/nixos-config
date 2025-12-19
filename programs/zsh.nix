{ config, pkgs, lib, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
    plugins = [
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "v1.1.2";
          sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
        };
      }
    ];
    initContent = ''
      eval "$(direnv hook zsh)"
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      function y() {
    	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	    yazi "$@" --cwd-file="$tmp"
	    IFS= read -r -d \'\' cwd < "$tmp"
	    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	    rm -f -- "$tmp"
      }  
      '';


  };
}
