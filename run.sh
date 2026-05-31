#!/bin/sh
set -a
. ./.env
set +a

clear
ansible-playbook -i inventory.ini playbook.yaml --ask-become-pass