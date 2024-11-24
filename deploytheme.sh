#!/bin/bash
# create a script that does the following
# copy ./fryball.zsh-theme to ~/.oh-my-zsh/custom/themes/
# search through .zshrc for ZSH_THEME="robbyrussell" and replace it with ZSH_THEME="fryball"
# if ZSH_THEME="robbyrussell" is not found in .zshrc, cancel the operation and print a message to the user
# Determine the appropriate sed command based on the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED_CMD='sed -i ""'
else
  SED_CMD='sed -i'
fi

# check to see if zsh is installed
if ! command -v zsh &> /dev/null; then
  echo "zsh is not installed."
  if [[ -f /etc/debian_version ]]; then
    echo "updating repositories..."
    if ! sudo apt update && sudo apt upgrade; then
      echo "error updating repositories"
      exit 1
    fi

    if ! sudo apt upgrade -y; then
      echo "error upgrading repositories"
      exit 1
    fi

    echo "Installing zsh..."
    if ! sudo apt update && sudo apt install -y zsh; then
      echo "error installing zsh"
      exit 1
    fi

  else
    echo "Unsupported OS. Please install zsh manually."
    exit 1
  fi
else
  echo "zsh is already installed."
fi

# Check if ~/.oh-my-zsh directory exists
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "~/.oh-my-zsh directory does not exist. Installing Oh My Zsh..."
  if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
    echo "error installing Oh My Zsh"
    exit 1
  fi
else
  echo "~/.oh-my-zsh directory already exists."
fi

# copy fryball.zsh-theme to ~/.oh-my-zsh/custom/themes/
if ! cp ./fryball.zsh-theme ~/.oh-my-zsh/custom/themes/; then
  echo "error: failed to copy fryball.zsh-theme to ~/.oh-my-zsh/custom/themes/"
  exit 1
fi

# # Determine the appropriate sed command based on the operating system
# if [[ "$OSTYPE" == "darwin"* ]]; then
#   SED_CMD='sed -i ""'
# else
#   SED_CMD='sed -i'
# fi

# Search through .zshrc for ZSH_THEME="robbyrussell" and replace it with ZSH_THEME="fryball"
if grep -q 'ZSH_THEME="robbyrussell"' ~/.zshrc; then
  echo "switching zsh theme to personal theme......."
  if ! eval "$SED_CMD 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"fryball\"/' ~/.zshrc"; then
    echo "error: failed to update ZSH_THEME in .zshrc"
    exit 1
  fi
  echo "successfully updated ZSH_THEME in .zshrc"
elif grep -q 'ZSH_THEME="fryball"' ~/.zshrc; then
  echo 'ZSH_THEME="fryball" already set in .zshrc'
  echo 'no changes made to .zshrc'
else
  echo 'ZSH_THEME="robbyrussell" not found in .zshrc'
  exit 1
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

# Check if the script is running on an AWS virtual machine
if curl -s --connect-timeout 2 http://169.254.169.254/latest/meta-data/ > /dev/null; then
  echo "This is an AWS virtual machine. Modifying zsh theme..."
  eval "$SED_CMD 's/^PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg\[blue\]%}%~%{\$reset_color%}\"/# PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg\[blue\]%}%~%{\$reset_color%}\"/' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme"
  eval "$SED_CMD 's/^# PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) \$USER@%M %{\$fg\[blue\]%}%~%{\$reset_color%}\"/PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) \$USER@%M %{\$fg\[blue\]%}%~%{\$reset_color%}\"/' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme"
  echo "modified zsh theme for AWS VM."
else
  echo "This is not an AWS virtual machine. No changes made to show user@hostname."
fi


