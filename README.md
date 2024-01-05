No Powershell, faça a instalação da versão da distro.
Exemplo:
```powershell
wsl -d Ubuntu
```

Após a instalação da distro, já no terminal execute o seguinte comando para instalação:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/richardoliveira/install-ubuntu/master/install_script.sh)"
```

O script acima permite a instalação do AWS CLI e do git-remote-codecommit através do parametro opcional true, conforme comando a seguir:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/richardoliveira/install-ubuntu/master/install_script.sh)" -- true
```
