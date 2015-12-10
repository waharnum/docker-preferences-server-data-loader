# GPII Preferences Server Data Loader Dockerfile

Builds a [sidecar/sidekick container](http://blog.kubernetes.io/2015/06/the-distributed-system-toolkit-patterns.html) for loading the test preferences server data set to a CouchDB instance. Uses the [ansible-preferences-server-data-loader](https://github.com/waharnum/ansible-preferences-server-data-loader) role.


## Building

    - `docker build -t gpii/preferences-server-data-loader .`

## Running

- containerized example (including running Preferences Server container)
  - docker run -d -p 5984:5984 --name couchdb klaemo/couchdb
  - docker run --rm -l couchdb -e COUCHDB_HOST_ADDRESS=couchdb:5984 gpii/preferences-server-data-loader
  - docker run --name prefserver -d -p 8082:8082 -l couchdb -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e PRIME_DB=false gpii/preferences-server

<!-- - running requires a couchdb instance accessible to the container
- fully containerized example, assuming the DB needs to be primed:
    - `docker run -d --name couchdb klaemo/couchdb`
    - `docker run --name prefserver -d -p 8082:8082 -l couchdb -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e PRIME_DB=true gpii/preferences-server`

## How it works
- `build.yml` - playbook for building the container image
- `run.yml` - playbook for runtime deployment steps (reconfiguring couchdb address, application environment and priming the DB), runs when the container is run - uses dynamically created `run-vars.yml` to pass environment variables from `docker run` to Ansible playbook, tests the container is connected properly to couchdb, then starts the application as a foreground process using supervisord
- `run.sh` - creates `run-vars.yml` based on environment variables from `docker run`, runs `run.yml` for runtime deployment steps, and starts the preferencesServer using supervisord -->
