#!/bin/bash

# Atualiza e faz upgrade
sudo apt update && sudo apt full-upgrade -y

# Configuração do update-manager para LTS
sudo sed -i 's/^Prompt=.*$/Prompt=lts/' /etc/update-manager/release-upgrades
sudo do-release-upgrade

# Instalação de pacotes adicionais
sudo apt install zsh unzip python3-pip apt-transport-https ca-certificates curl gnupg lsb-release -y

# Configurações do Git
git config --global user.email "rgoliveira3@stefanini.com"
git config --global user.name "Richard Oliveira"
git config --global credential.helper store

# Instalação do Oh My Zsh
ZSH=~/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clonagem de plugins do Zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Download do arquivo .zshrc
curl -L https://raw.githubusercontent.com/richardoliveira/zshrc/master/.zshrc -o ~/.zshrc
