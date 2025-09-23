#!/bin/bash

# Go Module Proxy Configuration for Nexus Repository
# Usage: source setup-go-nexus.sh

echo "Configuring Go to use Nexus repository..."

# Configure Go to use Nexus go-test repository as proxy
export GOPROXY=http://localhost:8081/repository/go-test/,direct
export GONOSUMDB=*
export GOPRIVATE=
export GOINSECURE=localhost:8081

# Create .netrc file for authentication
echo "machine localhost:8081 login admin password admin123" > ~/.netrc
chmod 600 ~/.netrc

echo "✅ Go environment configured for Nexus!"
echo "GOPROXY: $GOPROXY"
echo "GONOSUMDB: $GONOSUMDB"

# Verify configuration
echo ""
echo "Testing connection to Nexus repository..."
if curl -s -I http://localhost:8081/repository/go-test/ > /dev/null; then
    echo "✅ Nexus repository is accessible"
else
    echo "❌ Cannot reach Nexus repository at http://localhost:8081/repository/go-test/"
    echo "   Make sure Nexus is running and go-test repository is configured"
fi

echo ""
echo "Now run: go mod download -x"
echo "All modules will be downloaded through Nexus instead of directly from proxy.golang.org"