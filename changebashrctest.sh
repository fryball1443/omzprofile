#!/bin/bash

# add the following to ~/.zshrc

# get the current working directory and store in variable called wd
wd=$(pwd)


# append the following command and assign it to alias bash to the .zshrc file
# current working directory/rm_autozsh_bashrc.sh
if [ -f "$wd/rm_autozsh_bashrc.sh" ]; then
  echo "" >> ~/.zshrc
  echo "" >> ~/.zshrc
  echo "alias bash='bash $wd/rm_autozsh_bashrc.sh'" >> ~/.zshrc
  # echo "alias bash='sed -i \"/alias bash=/d\" ~/.zshrc && bash $wd/rm_autozsh_bashrc.sh'" >> ~/.zshrc
  # echo "bash -c 'sed -i \"/alias bash=/d\" ~/.zshrc && bash $wd/rm_autozsh_bashrc.sh'" >> ~/.zshrc
  echo "alias bash added to ~/.zshrc"
fi
