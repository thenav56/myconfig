## ZSH

#### Install ZSH

> https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH

```bash
sudo apt install zsh
```

#### Install oh-my-zsh

> https://github.com/robbyrussell/oh-my-zsh/blob/master/README.md

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### .zshrc

> Link zshrc to ~/.zshrc

```bash
ln -s ~/git/myconfig/zsh/zshrc ~/.zshrc
```

#### Additional Plugin

> Install Autosuggestions

```bash
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```
