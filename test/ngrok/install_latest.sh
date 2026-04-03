#!/bin/bash

set -e

source dev-container-features-test-lib

# Feature-specific tests
check "ngrok installed" bash -c "ngrok version"
check "ngrok is executable" which ngrok

# Report results
reportResults
