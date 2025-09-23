module firewall-test

go 1.21

require (
	// These WORK and could trigger firewall quarantine policies:
	
	// Pseudo-versions (commit-based) - often flagged as prerelease
	golang.org/x/exp v0.0.0-20231226003508-02704c960a9b // Experimental package
	
	// v0.x.x versions - considered prerelease/unstable by many policies
	github.com/go-playground/validator/v10 v10.16.0 // This works
	
	// Let's add more v0.x.x versions that commonly exist
	github.com/pkg/errors v0.9.1 // Popular error package
	github.com/google/uuid v0.0.0-20161128191214-064e2069ce9c // Old pseudo-version
)