#!/bin/sh

# Wait until PostGreSQL is ready
RETRIES=5
until psql -h postgresql -U postgres -d fabricexplorer -c "select 1" > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "Waiting for postgres server, $((RETRIES--)) remaining attempts..."
  sleep 3
done