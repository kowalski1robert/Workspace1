#!/bin/bash
### NOTE: The script targets ssh private keys from .ssh dir named *_rsa
declare -a ssh_keys=($(ls ~/.ssh))

eval "$(ssh-agent -s)" > /dev/null

for ssh_key in ${ssh_keys[@]}; do
  if [[ $ssh_key != *'.pub' ]] && [[ $ssh_key == *'_rsa' ]]; then
    ssh-add ~/.ssh/$ssh_key > /dev/null 2>&1
  fi
done
