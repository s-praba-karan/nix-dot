{ pkgs, config, ... }:

{
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
        "electron-13.6.9"
    ];
    # Install all the packages
    environment.systemPackages = with pkgs; [

        # Rice/desktop
        bspwm zsh dunst wl-clipboard polybar feh 
        picom sxhkd alacritty kitty dmenu rofi lxappearance

        # Command-line tools
        ripgrep pfetch ffmpeg exa htop fzf
        pass gnupg slop bat unzip libnotify
        lowdown zk grim slurp imagemagick age
        unzip curl xclip sxiv wget rsync
       
        # GUI applications
        mpv firefox 

        # Development
        git neovim

        # Language servers for neovim; change these to whatever languages you code in
        # Please note: if you remove any of these, make sure to also remove them from nvim/config/nvim/lua/lsp.lua!!
        rnix-lsp
        sumneko-lua-language-server
    ];
}
