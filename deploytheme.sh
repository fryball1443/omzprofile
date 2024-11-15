# create a script that does the following
# copy ./fryball.zsh-theme to ~/.oh-my-zsh/custom/themes/
# search through .zshrc for ZSH_THEME="robbyrussell" and replace it with ZSH_THEME="fryball"
# if ZSH_THEME="robbyrussell" is not found in .zshrc, cancel the operation and print a message to the user

# copy fryball.zsh-theme to ~/.oh-my-zsh/custom/themes/
cp ./fryball.zsh-theme ~/.oh-my-zsh/custom/themes/

# search through .zshrc for ZSH_THEME="robbyrussell" and replace it with ZSH_THEME="fryball"
if grep -q "ZSH_THEME=\"robbyrussell\"" ~/.zshrc; then
  sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="fryball"/' ~/.zshrc
else
  echo "ZSH_THEME=\"robbyrussell\" not found in .zshrc"
fi

# if the following test returns true, then the script is running on an AWS virtual machine
# if curl -s --connect-timeout 2 http://169.254.169.254/latest/meta-data/ > /dev/null; then
#     echo "This is an AWS virtual machine."
# else
#     echo "This is not an AWS virtual machine."
# fi
# if so, uncomment the following line in ~/.oh-my-zsh/custom/themes/fryball.zsh-theme
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) $USER@%M %{$fg[blue]%}%~%{$reset_color%}" #admin@hubble display
# and comment out the following line
# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[blue]%}%~%{$reset_color%}"
# if not, don't do anything

if curl -s --connect-timeout 2 http://169.254.169.254/latest/meta-data/ > /dev/null; then
    sed -i '' 's/PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[blue]%}%~%{$reset_color%}"/PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) $USER@%M %{$fg[blue]%}%~%{$reset_color%}"/' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme
    sed -i '' 's/# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) $USER@%M %{$fg[blue]%}%~%{$reset_color%}"/PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) $USER@%M %{$fg[blue]%}%~%{$reset_color%}"/' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme
else
    # echo "This is not an AWS virtual machine."
fi

