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
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/richardoliveira/script-shell/master/install_shell.sh)"
ZSH=~/.oh-my-zsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install --lts

# Instalação do PNPM e configurações
echo -e '\e[93mPasso 9: Instalando PNPM e configurando...\e[0m'
npm install -g pnpm@latest
source ~/.zshrc

# Instalação do NestJS e TypeScript
echo -e '\e[93mPasso 10: Instalando NestJS e TypeScript...\e[0m'
pnpm install -g turbo @nestjs/cli typescript

# Configuração do Docker
echo -e '\e[93mPasso 11: Configurando Docker...\e[0m'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y && sudo usermod -aG docker \$USER
echo -e '[boot]\ncommand = service docker start' | sudo tee /etc/wsl.conf > /dev/null

# Criação do diretório 'sources'
echo -e '\e[93mPasso 12: Criando diretório \"sources\"...\e[0m'
mkdir sources

if [ -z \"\$1\" ]; then
    parametro='false'
else
    parametro=\"\$1\"
fi

if [ \"\$parametro\" = 'true' ]; then
    # Instalação do AWS CLI e configuração
    echo -e '\e[93mPasso 13: Instalando AWS CLI e configurando...\e[0m'
    sudo apt install python3-pip
    curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'
    unzip awscliv2.zip && sudo ./aws/install && sudo rm -rf aws awscliv2.zip
    pip install git-remote-codecommit
    aws configure sso
    echo '[default]' >> ~/.aws/credentials
    echo 'aws_access_key_id=SEU_ACCESS_KEY' >> ~/.aws/credentials
    echo 'aws_secret_access_key=SEU_SECRET_KEY' >> ~/.aws/credentials
    echo 'aws_session_token=SEU_SESSION_TOKEN' >> ~/.aws/credentials
    code ~/.zshrc
fi

echo -e '\e[93mScript concluído! Feche e abra o seu terminal\e[0m'
"
#chsh -s $(which zsh)
