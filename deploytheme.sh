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

wd=$(pwd)

# check to see if zsh is installed
# if ! command -v zsh &> /dev/null; then
#if /usr/bin/zsh directory does not exist, then run the following commands
echo ""
echo ""
if [ ! -d "/usr/bin/zsh" ]; then
  echo "    zsh is not installed."
  if [[ -f /etc/debian_version ]]; then
    echo "    updating repositories..."
    if ! sudo apt update && sudo apt upgrade; then
      echo "    error updating repositories"
      exit 1
    fi

    if ! sudo apt upgrade -y; then
      echo "    error upgrading repositories"
      exit 1
    fi

    echo ""
    echo ""
    echo "    Installing zsh..."
    if ! sudo apt install zsh; then
      echo "    error installing zsh"
      exit 1
    fi

  else
    echo "    Unsupported OS. Please install zsh manually."
    echo "    Continue anyway? Installation may not run properly. (y/n)"
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
      echo "    Continuing installation..."
    else
      echo "    Installation cancelled."
      exit 1
    fi
  fi
else
  echo "    zsh is already installed."
fi

echo ""
echo ""
# Check if ~/.oh-my-zsh directory exists
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "    ~/.oh-my-zsh directory does not exist. Installing Oh My Zsh..."
  if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
    echo "    error installing Oh My Zsh"
    exit 1
  else
    echo "    Oh My Zsh installed successfully."
  fi
else
  echo "    ~/.oh-my-zsh directory already exists."
fi

echo ""
echo ""
# copy fryball.zsh-theme to ~/.oh-my-zsh/custom/themes/
if ! cp ./fryball.zsh-theme ~/.oh-my-zsh/custom/themes/; then
  echo "    error: failed to copy fryball.zsh-theme to ~/.oh-my-zsh/custom/themes/"
  exit 1
else
  echo "    fryball.zsh-theme copied to ~/.oh-my-zsh/custom/themes/"
fi

# # Determine the appropriate sed command based on the operating system
# if [[ "$OSTYPE" == "darwin"* ]]; then
#   SED_CMD='sed -i ""'
# else
#   SED_CMD='sed -i'
# fi

echo ""
echo ""
# Search through .zshrc for ZSH_THEME="robbyrussell" and replace it with ZSH_THEME="fryball"
if grep -q 'ZSH_THEME="robbyrussell"' ~/.zshrc; then
  echo "    switching zsh theme to personal theme......."
  if ! eval "$SED_CMD 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"fryball\"/' ~/.zshrc"; then
    echo "    error: failed to update ZSH_THEME in .zshrc"
    exit 1
  else
    echo "    successfully updated ZSH_THEME in .zshrc"
  fi
elif grep -q 'ZSH_THEME="fryball"' ~/.zshrc; then
  echo '    ZSH_THEME="fryball" already set in .zshrc'
  echo '    no changes made to .zshrc'
else
  echo '    ZSH_THEME="robbyrussell" not found in .zshrc'
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
# \$USER@%M

# Check if the script is running on an AWS virtual machine. if so, prompt to modify zsh theme to show user@hostname
if curl -s --connect-timeout 2 http://169.254.169.254/latest/meta-data/ > /dev/null; then
  echo "    This is an AWS virtual machine. Modifying zsh theme..."
  eval "$SED_CMD 's/^PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg\[blue\]%}%~%{\$reset_color%}\"/# PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg\[blue\]%}%~%{\$reset_color%}\"/' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme"
  eval "$SED_CMD 's/^# PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg_bold\[green\]%} \$USER@%M %{\$fg\[blue\]%}%~%{\$reset_color%}\"/PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg_bold\[green\]%} \$USER@%M %{\$fg\[blue\]%}%~%{\$reset_color%}\"/' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme"
  echo "    modified zsh theme for AWS VM."
else
  echo "    This is not an AWS virtual machine. Would you like to show user@hostname? (y/n)"
  read -r response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    eval "$SED_CMD 's/^PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg\[blue\]%}%~%{\$reset_color%}\"/# PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg\[blue\]%}%~%{\$reset_color%}\"/' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme"
    eval "$SED_CMD 's/^# PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg_bold\[green\]%} \$USER@%M %{\$fg\[blue\]%}%~%{\$reset_color%}\"/PROMPT=\"%(?:%{\$fg_bold\[green\]%}➜ :%{\$fg_bold\[red\]%}➜ ) %{\$fg_bold\[green\]%} \$USER@%M %{\$fg\[blue\]%}%~%{\$reset_color%}\"/' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme"
    echo "    modified zsh theme to show user@hostname."
  else
    echo "    reverting to default zsh theme."
  fi
fi

# check if the script is running on wsl2
# if so, ask "would you like to set default WSL theme so it is magenta instead of cyan?"
# if yes, replace every instance of the word "cyan" with "magenta" in ~/.oh-my-zsh/custom/themes/fryball.zsh-theme
# if no, don't do anything

# Check if the script is running on WSL2
if [ -d "/home/unix" ]; then
  echo "    This is WSL2. Modifying zsh theme..."
  echo "   Would you like to set default WSL theme so it is magenta instead of cyan? (y/n)"
  read -r response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    eval "$SED_CMD 's/cyan/magenta/g' ~/.oh-my-zsh/custom/themes/fryball.zsh-theme"
    echo "    modified zsh theme for WSL2."
  else
    echo "    No changes made to zsh theme."
  fi
else
  echo "    This is not WSL2. No changes made to zsh theme."
fi

echo ""
echo ""
echo ""
echo ""
echo "    Installation complete...."
echo "   Do you want zsh or bash to be your default shell?"
echo "    type zsh or bash"
read -r response
if [[ "$response" == "zsh" ]]; then
  if ! chsh -s /usr/bin/zsh; then
    echo "    error changing default shell to zsh"
    echo "    attempting change via appending to ~/.bashrc"
    # if "exec zsh" is in .bashrc, then remove it, and add it to the end of the file
    if grep -q "exec zsh" ~/.bashrc; then
      eval "$SED_CMD '/exec zsh/d' ~/.bashrc"
    fi
    # append the following command and assign it to alias bash to the .zshrc file
    # current working directory/rm_autozsh_bashrc.sh
    if [ -f "$wd/rm_autozsh_bashrc.sh" ]; then
      echo "" >> ~/.zshrc
      echo "" >> ~/.zshrc
      echo "    alias bash='bash $wd/rm_autozsh_bashrc.sh'" >> ~/.zshrc
      # echo "alias bash='sed -i \"/alias bash=/d\" ~/.zshrc && bash $wd/rm_autozsh_bashrc.sh'" >> ~/.zshrc
      # echo "bash -c 'sed -i \"/alias bash=/d\" ~/.zshrc && bash $wd/rm_autozsh_bashrc.sh'" >> ~/.zshrc
      echo "    alias bash added to ~/.zshrc"
    fi
    echo "" >> ~/.bashrc
    echo "" >> ~/.bashrc
    echo "exec zsh" >> ~/.bashrc
    source ~/.bashrc
    exit 0
  fi
  echo "    zsh is now your default shell."
elif [[ "$response" == "bash" ]]; then
  if ! chsh -s /bin/bash; then
    echo "    error changing default shell to bash"
    echo "    attempting change via removing 'exec zsh' from ~/.bashrc"
    # if "exec zsh" is in .bashrc, then remove it
    if grep -q "exec zsh" ~/.bashrc; then
      eval "$SED_CMD '/exec zsh/d' ~/.bashrc"
    fi
    source ~/.bashrc
  fi
  echo "    bash is now your default shell."
else
  echo "    Invalid response. No changes made to default shell."
fi

# if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
#   # if "exec zsh" is in .bashrc, then remove it, and add it to the end of the file
#   if grep -q "exec zsh" ~/.bashrc; then
#     eval "$SED_CMD '/exec zsh/d' ~/.bashrc"
#   fi
#   echo "exec zsh" >> ~/.bashrc
#   source ~/.bashrc
#   exit 0
# fi
echo ""
echo ""
echo "    Would you like to run zsh? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  zsh
fi
