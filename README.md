# GPII Preferences Server Data Loader Dockerfile

Builds a [sidecar/sidekick container](http://blog.kubernetes.io/2015/06/the-distributed-system-toolkit-patterns.html) for loading the test preferences server data set (including the /auth configuration) to a CouchDB instance. Uses the [ansible-preferences-server-data-loader](https://github.com/waharnum/ansible-preferences-server-data-loader) role.


## Building

- `docker build -t gpii/preferences-server-data-loader .`

## Runtime Environment Variables

- `COUCHDB_HOST_ADDRESS`: host address of the couchdb instance to use. You will typically need to be explicit about this. (default: `localhost:5984`)
- `CLEAR INDEX`: should the data loading process wipe and recreate the /preferences and /auth indexes? If not set to `true`, this will cause the data load to fail if attempting to load test data to an instance where the test data already exists; you must be explicit in running the container to erase an existing index. (default: `false`)

## Running

- running requires a couchdb instance accessible to the container
- containerized example (including running Preferences Server container)
  - `docker run -d -p 5984:5984 --name couchdb inclusivedesign/couchdb`
  - `docker run --rm --link couchdb -e COUCHDB_HOST_ADDRESS=couchdb:5984 -e CLEAR_INDEX=true gpii/preferences-server-data-loader`
  - `docker run --name prefserver -d -p 8082:8082 --link couchdb -e NODE_ENV=preferencesServer.production -e COUCHDB_HOST_ADDRESS=couchdb:5984 gpii/preferences-server`
