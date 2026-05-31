#!/bin/sh
export DOZZLE_PASSWORD='sexypes'
export DOZZLE_EMAIL='SSH_USER@oryks.org'
export DOZZLE_USERNAME='SSH_USER'
clear
ansible-playbook -i inventory.ini playbook.yaml --ask-become-pass