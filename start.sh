#!/bin/sh -e

ansible-playbook run.yml --tags "deploy,test"
