#!/bin/sh
ansible-inventory -i inventory.ini --list
ansible servers -m ping -i inventory.ini