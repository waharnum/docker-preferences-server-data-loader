# GPII Preferences Server Data Loader Dockerfile

Builds a [sidecar/sidekick container](http://blog.kubernetes.io/2015/06/the-distributed-system-toolkit-patterns.html) for loading the test preferences server data set to a CouchDB instance. Uses the [ansible-preferences-server-data-loader](https://github.com/waharnum/ansible-preferences-server-data-loader) role.


## Building

- `docker build -t gpii/preferences-server-data-loader .`

## Running

- running requires a couchdb instance accessible to the container
- containerized example (including running Preferences Server container)
  - `docker run -d -p 5984:5984 --name couchdb klaemo/couchdb`
  - `docker run --rm -l couchdb -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e CLEAR_INDEX=true gpii/preferences-server-data-loader`
  - `docker run --name prefserver -d -p 8082:8082 -l couchdb -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e gpii/preferences-server`
