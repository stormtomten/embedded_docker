#!/bin/bash
# Start the SSH service
service ssh start

# Keep the container running
exec "$@"

