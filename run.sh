#!/bin/sh
set -a
. ./.env
set +a

clear
ansible-galaxy role install -r requirements.yml --force
ansible-galaxy collection install -r requirements.yml --force
ansible-playbook -i inventory.yml playbook.yaml --ask-become-pass