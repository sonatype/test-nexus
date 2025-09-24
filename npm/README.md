# NPM Nexus Repository Setup

## Prerequisites

### 1. Create npm-proxy Repository in Nexus
If the npm-proxy repository doesn't exist, create it using the Nexus REST API:

```bash
curl -X POST "http://localhost:8081/service/rest/v1/repositories/npm/proxy" \
  -H "accept: application/json" \
  -H "Content-Type: application/json" \
  -u admin:admin123 \
  -d '{
    "name": "npm-proxy",
    "online": true,
    "storage": {
      "blobStoreName": "default",
      "strictContentTypeValidation": true
    },
    "proxy": {
      "remoteUrl": "https://registry.npmjs.org/",
      "contentMaxAge": 1440,
      "metadataMaxAge": 1440
    },
    "negativeCache": {
      "enabled": true,
      "timeToLive": 1440
    },
    "httpClient": {
      "blocked": false,
      "autoBlock": true
    }
  }'
```

### 2. Configure .npmrc
The `.npmrc` file is configured to use the Nexus npm-proxy repository:

```
registry=http://localhost:8081/repository/npm-proxy/
//localhost:8081/repository/npm-proxy/:_auth=*token*
always-auth=true
email=admin@example.com
```

**Note:** The `_auth` field uses scoped authentication format for the specific repository.

## Installation Commands

### Install all dependencies
```bash
npm install
```

### Verify repository status
```bash
# Check if npm-proxy repository exists
curl -u admin:admin123 -s http://localhost:8081/service/rest/v1/repositories | grep npm-proxy

# Verify repository is accessible
curl -I http://localhost:8081/repository/npm-proxy/
```

## Test Package Availability

Test individual packages to ensure they're cached in npm-proxy:

```bash
# Test core packages
curl -o/dev/null -s -w "%{http_code}\n" http://localhost:8081/repository/npm-proxy/express
curl -o/dev/null -s -w "%{http_code}\n" http://localhost:8081/repository/npm-proxy/lodash
curl -o/dev/null -s -w "%{http_code}\n" http://localhost:8081/repository/npm-proxy/uuid
curl -o/dev/null -s -w "%{http_code}\n" http://localhost:8081/repository/npm-proxy/axios

# Test specific versions (optional)
curl -o/dev/null "http://localhost:8081/repository/npm-proxy/express/-/express-4.18.2.tgz"
curl -o/dev/null "http://localhost:8081/repository/npm-proxy/lodash/-/lodash-4.17.21.tgz"
```

## Dependencies Included

This project includes:

**Production Dependencies:**
- express ^4.18.2 - Web framework
- lodash ^4.17.21 - Utility library
- uuid ^9.0.1 - UUID generation
- axios ^1.5.0 - HTTP client
- moment ^2.29.4 - Date handling
- cors ^2.8.5 - CORS middleware
- dotenv ^16.3.1 - Environment variables
- bcryptjs ^2.4.3 - Password hashing
- jsonwebtoken ^9.0.2 - JWT handling
- morgan ^1.10.0 - HTTP request logger
- helmet ^7.0.0 - Security headers
- validator ^13.11.0 - Input validation
- chalk ^4.1.2 - Terminal colors
- error-ex ^1.3.2 - Error handling
- multer ^1.4.5-lts.1 - File uploads
- compression ^1.7.4 - Response compression

**Development Dependencies:**
- nodemon ^3.0.1 - Development server
- jest ^29.7.0 - Testing framework
- eslint ^8.49.0 - Code linting
- prettier ^3.0.3 - Code formatting
- concurrently ^8.2.1 - Run multiple commands
- cross-env ^7.0.3 - Cross-platform environment variables

## Installation Result

After running `npm install`, the following was accomplished:
- ✅ 497 packages installed and cached in npm-proxy
- ✅ All dependencies available offline through Nexus
- ✅ Repository acts as proxy to https://registry.npmjs.org/
- ✅ Packages accessible via `http://localhost:8081/repository/npm-proxy/PACKAGE_NAME`

## Troubleshooting

### Authentication Issues
If you see authentication errors, ensure the `.npmrc` uses the correct scoped format:
```
//localhost:8081/repository/npm-proxy/:_auth=YWRtaW46YWRtaW4xMjM=
```

### Repository Not Found
If npm-proxy repository doesn't exist, create it using the REST API command above.

### Package Not Found
First installation will populate packages in the proxy. Subsequent installs will use cached versions.
