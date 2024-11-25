#!/bin/bash
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED_CMD='sed -i ""'
else
  SED_CMD='sed -i'
fi

if grep -q "exec zsh" ~/.bashrc; then
  eval "$SED_CMD '/exec zsh/d' ~/.bashrc"
fi

wd=$(pwd)
# remove the following line from .zshrc: "alias bash='bash $wd/rm_autozsh_bashrc.sh'"
# Remove the alias from .zshrc if it exists
if grep -q "alias bash='bash $wd/rm_autozsh_bashrc.sh'" ~/.zshrc; then
  escaped_wd=$(echo "$wd" | sed 's/[\/&]/\\&/g')
  eval "$SED_CMD \"/alias bash='bash $escaped_wd\\/rm_autozsh_bashrc.sh'/d\" ~/.zshrc"
fi

# source ~/.zshrc
bash