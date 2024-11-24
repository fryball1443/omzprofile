#!/bin/bash

echo "current hostname: $(hostname)"
echo "would you like to change it? (y/n)"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo "enter new hostname:"
  read -r newhostname
  sudo hostnamectl set-hostname "$newhostname"
  echo "new hostname: $(hostname)"
fi

# sudo hostnamectl set-hostname test442