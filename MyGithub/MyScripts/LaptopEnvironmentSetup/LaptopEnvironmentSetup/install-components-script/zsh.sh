#! /bin/bash
SUDO_PASSWORD=$1

sudo apt-get install zsh -y

### oh-my-zsh will ask if user want to change default shell to zsh and if yes for confirmation will ask for sudo password; for uninterrupted installation process script will provide "Y" and password via pipe
{ echo "Y";  echo $SUDO_PASSWORD } | sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
gh repo clone romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k

### find theme name by grepping line starting with "ZSH_THEME=" and cut out everything before it and after it
current_theme_name=$(grep 'ZSH_THEME\=".*"' ~/.zshrc -E -i)
### cut out what is after it
current_theme_name=${current_theme_name%\"}
### cut out what is before it
current_theme_name=${current_theme_name##*\"}

### replace '/' char by '\/' for sed execution
current_theme_name=${current_theme_name//\//\\\/}

### replace current theme with "powerlevel10k"
sed -i "s/${current_theme_name}/powerlevel10k\/powerlevel10k/g" ~/.zshrc