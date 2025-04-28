#!/bin/bash
set -e

# Ensure SSH directory exists
mkdir -p /var/run/sshd

# Start SSHD in the foreground
exec "$@"
