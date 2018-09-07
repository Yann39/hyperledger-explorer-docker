#!/bin/sh

# Wait until PostGreSQL is ready
RETRIES=5
until $(nc -zv postgresql 5432 || [ $RETRIES -eq 0 ]); do
    echo "Waiting for postgres container to be up, $((RETRIES--)) remaining attempts..."
    sleep 2
done