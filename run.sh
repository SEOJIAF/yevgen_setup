#!/bin/sh
source .env
ansible-playbook -i inventory.ini playbook.yaml --ask-become-pass