# Nexus Repository Test Project

This project demonstrates how to configure different build tools to work with Nexus Repository Manager as a proxy.

## Project Structure

```
test-nexus/
├── maven/          # Maven project files
│   ├── pom.xml     # Maven dependencies (jackson-databind, commons-codec)
│   ├── settings.xml # Maven Nexus configuration
│   └── src/        # Java source code
├── go/             # Go module files
│   ├── go.mod      # Go dependencies (UUID, gorilla/mux, etc.)
│   ├── go.sum      # Go dependency checksums
│   ├── main.go     # Go source code
│   ├── setup-go-nexus.sh # Go Nexus configuration script
│   ├── README.md   # Go build instructions and setup
│   ├── COMPLETE-PROJECT-SUMMARY.md # Go project documentation
│   └── FIREWALL-QUARANTINE-TEST-STEPS.md # Go firewall testing guide
├── npm/            # NPM project files
│   ├── package.json # NPM dependencies (express, lodash, uuid, etc.)
│   ├── .npmrc      # NPM Nexus configuration
│   └── README.md   # NPM setup instructions and repository creation
├── python/         # Python project files (PythonProject1)
│   ├── pyproject.toml # Python project configuration
│   ├── requirements.txt # Python dependencies (numpy, pandas)
│   ├── README.md   # Python project documentation
│   ├── dist/       # Distribution files
│   └── simple/     # Package source code
└── README.md       # This file
```

## Build Commands

### Maven
```bash
cd maven/
mvn -s settings.xml clean install -U
```

### Go
```bash
cd go/
source setup-go-nexus.sh && go clean -modcache && go mod download -x
go build
```

### NPM
```bash
cd npm/
npm install
```

### Python
```bash
cd python/
pip install -r requirements.txt
python -m build
```

## Configuration Summary

- **Maven**: Uses `settings.xml` with mirror pointing to Nexus
- **Go**: Uses module proxy configuration
- **NPM**: Uses `.npmrc` with registry pointing to Nexus proxy  
- **Python**: Uses `pyproject.toml` for build configuration and pip for dependency management

All four tools are configured to pull dependencies through Nexus Repository Manager instead of directly from public registries.