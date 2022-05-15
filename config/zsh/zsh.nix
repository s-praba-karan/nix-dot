pkgs:
{
    enable = true;
    
    # Set dotDir
    dotDir = ".config/zsh";

    # .zshrc
    initExtra = ''
      PROMPT='%F{yellow}%1~%f %F{green}∯%f  '

      export TERM="xterm-256color"
      export EDITOR='nvim'
      export TERMINAL='alacritty'
      export BROWSER='firefox'
      export MANPAGER='nvim +Man!'
      export PATH=$PATH:$HOME/.scripts
      export PATH=$PATH:$HOME/.local/bin/
      export LYNX_CFG=$HOME/.config/lynx/lynx.cfg
      export LYNX_LSS=$HOME/.config/lynx/lynx.lss
      
      autoload -Uz vcs_info
      precmd_vcs_info() { vcs_info }
      precmd_functions+=( precmd_vcs_info )
      setopt prompt_subst
      RPROMPT=\$vcs_info_msg_0_
      zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%r%f'
      zstyle ':vcs_info:*' enable git

    # Tweak settings for history
    history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
    };

    # Aliases
    shellAliases = {
      v = 'nvim -i NONE'
      tmux ='tmux -u'
      t ='tmux -u'
      tn ='t new -s'
      tl ='tmux ls'
      ta ='tmux a -t'
      tk ='tmux kill-ses -t'
      sudo = 'sudo '
      cls = 'clear'
      ls = 'lsd'
      lsa = 'lsd -al'
      tree = 'lsd --tree'
      '?' = 'duck'
      '??' = 'google'
      lf = '~/.scripts/lf-ueberzug'
      todo = 'v ~/.config/conky/todo.md'
      nb = 'newsboat'
      z = 'zathura'
      open = 'xdg-open'
    };




