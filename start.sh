#!/bin/sh -e

# Create an Ansible variables file for playbook-docker-run based on environment variables passed to the container

cat > run-vars.yml<<EOF
---
preferences_server_data_loader_couchdb_host_address: $COUCHDB_HOST_ADDRESS
preferences_server_data_loader_cleanup_after: false
preferences_server_data_loader_clear_index: true

EOF

ansible-playbook run.yml --tags "deploy,test"
