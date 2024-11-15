#!/bin/bash

# Check if the instance metadata service is available
if curl -s --connect-timeout 2 http://169.254.169.254/latest/meta-data/ > /dev/null; then
    echo "This is an AWS virtual machine."
else
    echo "This is not an AWS virtual machine."
fi