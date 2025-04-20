#! bin/bash

update_system(){
  echo "Updating the system..."
  sudo apt update && sudo apt upgrade -y
  echo "System updated successfully"
}

install_default_text_editor(){
    PS3='Please enter your default text editor: '
    options=("Install vscode" "Install vim")
    select opt in "${options[@]}"
    do
        case $opt in
            "Install vscode")
                echo "You chose to install VSCode"
                install_vscode
                break
                ;;
            "Install vim")
                echo "You chose to install Vim"
                install_vim
                break
                ;;
            *)
                echo "Invalid option: $REPLY"
                ;;
        esac
    done
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
  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Zsh installed successfully"
}

install_tmux() {
  echo "Installing Tmux..."
  sudo apt install -y tmux
  echo "Tmux installed successfully"
}

install_tpm(){
  echo "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  if [ ! -f ~/.tmux.conf ]; then
    touch ~/.tmux.conf
  fi

  cp tmux/.tmux.conf ~/.tmux.conf
  echo "Tmux installed successfully"
  echo "Open a new tmux session and press 'prefix + I' to install all plugins"
}

install_fonts() {
  echo "Installing Fonts..."
  sudo mkdir -p ~/.fonts
  sudo cp -a ./fonts/. ~/.fonts
  sudo fc-cache -fv
  echo "Fonts installed successfully"
}

install_spaceship_theme() {
  echo "Installing Spaceship theme..."
  sudo git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
  sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  sudo mkdir -p ~/.config
  sudo cp ./zsh/spaceship.zsh ~/.config
  sudo cp ./zsh/.zshrc ~/.zshrc
  source ~/.zshrc
  echo "Spaceship theme installed successfully"
}

install_catppuccin_theme() {
  echo "Installing Catppuccin theme..."
  curl -L https://raw.githubusercontent.com/catppuccin/gnome-terminal/v1.0.0/install.py | python3 -
  echo "Catppuccin theme installed successfully"
}

install_docker(){
  echo "Installing Docker..."

  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  # Install the latest Docker packages
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Create the docker user group
  sudo groupadd docker
  sudo usermod -aG docker $USER

  # Configure Docker to start on boot with systemd
  sudo systemctl enable docker.service
  sudo systemctl enable containerd.service

  echo "Docker installed successfully"
}

if [ -d "$HOME/dotfiles" ]
then
  echo "You already installed the Dotfile"
else
  echo "Installing Dotfiles"
  update_system
  install_curl
  install_git
  install_default_text_editor
  install_zsh
  install_oh_my_zsh
  install_tmux
  install_tpm
  install_fonts
  install_spaceship_theme
  install_catppuccin_theme
  echo "Dotfile installed successfully"
fi
