#!/bin/bash

echo -e "\e[93mIniciando script de instalação...\e[0m"

# Atualiza e faz upgrade
echo -e "\e[93mPasso 1: Atualizando e fazendo upgrade...\e[0m"
sudo apt update && sudo apt full-upgrade -y

# Configuração do update-manager para LTS
echo -e "\e[93mPasso 2: Configurando o update-manager para LTS...\e[0m"
sudo sed -i 's/^Prompt=.*$/Prompt=lts/' /etc/update-manager/release-upgrades
sudo do-release-upgrade

# Instalação de pacotes adicionais
echo -e "\e[93mPasso 3: Instalando pacotes adicionais...\e[0m"
sudo apt install zsh unzip apt-transport-https ca-certificates curl gnupg lsb-release -y

# Configurações do Git
echo -e "\e[93mPasso 4: Configurando Git...\e[0m"
git config --global credential.helper store

# Instalação do Oh My Zsh
echo -e "\e[93mPasso 5: Instalando Oh My Zsh...\e[0m"
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
ZSH=$HOME/.oh-my-zsh RUNZSH=no sh install.sh

rm -rf install.sh

zsh -c "
# Clonagem de plugins do Zsh
echo -e '\e[93mPasso 6: Clonando plugins do Zsh...\e[0m'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Download do arquivo .zshrc
echo -e '\e[93mPasso 7: Baixando arquivo .zshrc...\e[0m'
curl -L https://raw.githubusercontent.com/richardoliveira/zshrc/master/.zshrc -o ~/.zshrc

# Instalação do NVM
echo -e '\e[93mPasso 8: Instalando NVM...\e[0m'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash
source ~/.zshrc
nvm install --lts

# Instalação do HOMEBREW e configurações
echo -e '\e[93mPasso 9: Instalando HOMEBREW e configurando...\e[0m'
/bin/bash -c '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)'
sudo apt-get install build-essential

# Instalação do NestJS e TypeScript
echo -e '\e[93mPasso 10: Instalando NestJS e TypeScript...\e[0m'
npm install -g turbo @nestjs/cli typescript

# Configuração do .NET 9
sudo add-apt-repository ppa:dotnet/backports -y
sudo apt-get update && sudo apt-get install -y dotnet-sdk-9.0
sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-9.0
sudo apt-get install -y dotnet-runtime-9.0

# Configuração do .NET 8
sudo apt-get update && sudo apt-get install -y dotnet-sdk-8.0
sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-8.0
sudo apt-get install -y dotnet-runtime-8.0

# Configuração do .NET 7
sudo apt-get update && sudo apt-get install -y dotnet-sdk-7.0
sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-7.0
sudo apt-get install -y dotnet-runtime-7.0

echo -e '\e[93mScript concluído! Feche e abra o seu terminal\e[0m'
"
#chsh -s $(which zsh)
