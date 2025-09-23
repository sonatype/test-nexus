# Go Module Configuration with Nexus

## Prerequisites

### 1. Configure Anonymous Access in Nexus
1. Log into Nexus Repository Manager at `http://localhost:8081`
2. Go to **Administration** → **Security** → **Anonymous Access**
3. **Enable anonymous access** for the Go repository
4. Or ensure proper authentication is configured

## Setup and Build Commands

### 1. Configure Go to use Nexus proxy
```bash
source setup-go-nexus.sh
```

### 2. Clean and download dependencies
```bash
source setup-go-nexus.sh && go clean -modcache && go mod download -x
```

### 3. Build the project
```bash
go build
```

## What the setup script does:
- Sets `GOPROXY=http://localhost:8081/repository/go-test/,direct`
- Sets `GONOSUMDB=*` (disables checksum verification)
- Sets `GOINSECURE=localhost:8081` (allows insecure connections)
- Creates `~/.netrc` with authentication credentials

## Dependencies included:
- `github.com/gofrs/uuid` - UUID generation
- `github.com/gorilla/mux` - HTTP router
- `github.com/gorilla/schema` - Form encoding/decoding
- `github.com/json-iterator/go` - Fast JSON processing
- `github.com/sirupsen/logrus` - Logging

## Verification
After running the commands, all Go modules will be downloaded through your Nexus repository instead of directly from `proxy.golang.org`.