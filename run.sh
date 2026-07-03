#!/bin/bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
set -a
. ./.env
set +a

clear
ansible-galaxy role install -r requirements.yml --force
ansible-galaxy collection install -r requirements.yml --force

sleep 1
clear

ansible-playbook -i inventory.yml playbook.yaml --ask-become-pass