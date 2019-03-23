#! /bin/bash

## VARS
ANSIBLE_CONFIG_PATH=$(pwd)/playbook
ANSIBLE_HOST_PATH=$ANSIBLE_CONFIG_PATH/inventory/hosts.yml
CONTAINER_NAME=$1
PORT=$2
LOGIN_USER=$3
MINKE_MEN=$4

## Set ENV
export ANSIBLE_CONFIG=$ANSIBLE_CONFIG_PATH

## REPLACE ANSIBLE PATH
sed -i -e s?ANSIBLE_HOST_PATH?"$ANSIBLE_HOST_PATH"? playbook/ansible.cfg

## REPLACE CONTAINER NAME
sed -i -e s?CONTAINER_NAME?"$CONTAINER_NAME"? playbook/inventory/hosts.yml

## REPLACE CONTAINER NAME
sed -i -e s?PORT?"$PORT"? playbook/inventory/hosts.yml

## REPLACE CONTAINER NAME
sed -i -e s?LOGIN_USER?"$LOGIN_USER"? playbook/inventory/hosts.yml

## EXEC ANSIBLE
ansible-playbook playbook/site.yml -vvvv -e hash_test=$HASH_TEST

## REINSTATE REPLACED TEXT
sed -i -e s?"$ANSIBLE_HOST_PATH"?ANSIBLE_HOST_PATH? playbook/ansible.cfg
sed -i -e s?"$CONTAINER_NAME"?CONTAINER_NAME? playbook/inventory/hosts.yml
sed -i -e s?"$PORT"?PORT? playbook/inventory/hosts.yml
sed -i -e s?"$LOGIN_USER"?LOGIN_USER? playbook/inventory/hosts.yml
