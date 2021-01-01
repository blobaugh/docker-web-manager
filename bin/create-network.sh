#!/bin/bash

# Remove any old web networks first
docker network rm web

# Create the Mindsize network. This may fail. That is likely ok.
docker network create web --ip-range=172.43.0.0/16 --subnet=172.43.0.0/16