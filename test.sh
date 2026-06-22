#!/bin/sh
ansible-inventory -i inventory.yml --list
ansible servers -m ping -i inventory.yml