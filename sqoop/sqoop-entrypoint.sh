#!/bin/bash

# Verify Sqoop installation
echo "Verifying Sqoop installation..."
sqoop version

# Keep the container running
tail -f /dev/null
