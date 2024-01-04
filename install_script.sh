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
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clonagem de plugins do Zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Download do arquivo .zshrc
curl -L https://raw.githubusercontent.com/richardoliveira/zshrc/master/.zshrc -o ~/.zshrc

# Instalação do NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts

# Instalação do PNPM e configurações
npm install -g pnpm@latest && source ~/.zshrc
pnpm setup && source ~/.zshrc

# Instalação do NestJS e TypeScript
pnpm install -g turbo @nestjs/cli typescript

# Configuração do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y && sudo usermod -aG docker $USER
echo -e "[boot]\ncommand = service docker start" | sudo tee /etc/wsl.conf > /dev/null

# Instalação do AWS CLI e configuração
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install && sudo rm -rf aws awscliv2.zip
pip install git-remote-codecommit
aws configure sso

# Configuração do SSH
ssh-keygen

# Criação do diretório "sources"
mkdir sources
