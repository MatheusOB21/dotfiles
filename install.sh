update_system(){
  echo "Updating the system..."
  sudo apt update && sudo apt upgrade -y
  echo "System updated successfully"
}

install_vscode() {
  echo "Installing Vscode..."
  sudo apt install -y wget gpg software-properties-common
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt update
  sudo apt install -y code
  echo "Vscode installed successfully" 
}

install_vim() {
  echo "Installing Vim..."
  sudo apt install -y vim
  echo "Vim installed successfully"
}

install_git() { 
  echo "Installing Git..."
  sudo apt install -y git
  echo "Git installed successfully"
}

install_zsh() {
  echo "Installing Zsh..."
  sudo apt install -y zsh
  echo "Zsh installed successfully"
}

install_curl() {
  echo "Installing Curl..."
  sudo apt install -y curl
  echo "Curl installed successfully"
}

install_oh_my_zsh() {
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Zsh installed succesfully"
}

install_tmux() {
  echo "Installing Tmux..."
  sudo apt install -y tmux
  echo "Tmux installed succesfully"
}

install_tpm(){
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  
  if [ ! -f ~/.tmux.conf ]; then
    touch ~/.tmux.conf
  fi

  cp tmux/.tmux.conf ~/.tmux.conf
  echo "Tmux installed succesfully"
  echo "Open a new tmux session and press 'prefix + I' to install all plugins"

}

install_fonts() {
  echo "Installing Fonts..."
  mkdir -p ~/.fonts
  cp -a ./fonts/. ~/.fonts
  fc-cache -fv
  echo "Fonts installed"
}

install_spaceship_theme() {
  echo "Installing Spaceship theme..."
  mkdir -p "$ZSH_CUSTOM/themes/spaceship-prompt"
  cp -r ./zsh/themes/spaceship-prompt "$ZSH_CUSTOM/themes/"
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  mkdir -p ~/.config 
  cp ./zsh/spaceship.zsh ~/.config
  cp ./zsh/.zshrc ~/.zshrc
  source ~/.zshrc
  echo "Spaceship theme installed succesfully"
}

install_catppuccin_theme() {
  echo "Installing Catppuccin theme..."
  curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v1.0.0/install.py | python3 -
  echo "Catppuccin theme installed succesfully"
}

if [ -d "$HOME/dotfiles" ]
then
  echo "Installing Dotfiles"
else
  echo "You already installed the Dotfile"
  update_system
  install_vscode
  install_git
  install_zsh
  install_oh_my_zsh
  install_tmux
  install_tpm
  install_fonts
  install_spaceship_theme
fi
