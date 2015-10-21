#!/bin/bash

# define variables
ROLE_NAME=franklinkim.pm2

# install dependencies
ansible-galaxy install franklinkim.nodejs

# create role symnlink
ln -s $(pwd) /usr/share/ansible/roles/$ROLE_NAME

echo 'running playbook'
ansible-playbook -vvvv -i 'localhost,' -e "pwd=$(pwd)" -c local $(pwd)/tests/main.yml
