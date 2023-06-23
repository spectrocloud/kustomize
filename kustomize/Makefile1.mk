default: bin/kustomize

PKG ?= sigs.k8s.io/kustomize/kustomize/v4
GORELEASER := $(shell command -v goreleaser 2> /dev/null)

VERSION ?= v4.5.7-20230623
GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)
GIT_COMMIT ?= $(shell git rev-parse HEAD)
BUILD_DATE ?= $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
BUILD_DATE_STRIPPED := $(subst -,,$(subst :,,$(BUILD_DATE)))

#----------------------#
.PHONY: build
build: build-linux build-mac build-windows

.PHONY: build-linux
build-linux: build-linux-amd64 build-linux-arm64 build-linux-arm-v7 build-linux-s390x build-linux-ppc64le

.PHONY: build-linux-amd64
build-linux-amd64:
	GOARCH=amd64 CGO_ENABLED=0 GOOS=linux go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/linux/amd64/ $(PKG)

.PHONY: build-linux-arm64
build-linux-arm64:
	GOARCH=arm64 CGO_ENABLED=0 GOOS=linux go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/linux/arm64/ $(PKG)

.PHONY: build-linux-s390x
build-linux-s390x:
	GOARCH=s390x CGO_ENABLED=0 GOOS=linux go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/linux/s390x/ $(PKG)

.PHONY: build-linux-ppc64le
build-linux-ppc64le:
	GOARCH=ppc64le CGO_ENABLED=0 GOOS=linux go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/linux/ppc64le/ $(PKG)

.PHONY: build-linux-arm-v7
build-linux-arm-v7:
	GOARCH=arm CGO_ENABLED=0 GOOS=linux go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/linux/arm/v7/ $(PKG)

.PHONY: build-mac
build-mac: build-mac-arm64 build-mac-amd64

.PHONY: build-mac-amd64
build-mac-amd64:
	GOARCH=amd64 CGO_ENABLED=0 GOOS=darwin go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/darwin/amd64/ $(PKG)

.PHONY: build-mac-arm64
build-mac-arm64:
	GOARCH=arm64 CGO_ENABLED=0 GOOS=darwin go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/darwin/arm64/ $(PKG)

.PHONY: build-windows
build-windows: build-windows-amd64 build-windows-arm64

.PHONY: build-windows-amd64
build-windows-amd64:
	GOARCH=amd64 CGO_ENABLED=0 GOOS=windows go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/windows/amd64/ $(PKG)

.PHONY: build-windows-arm64
build-windows-arm64:
	GOARCH=arm64 CGO_ENABLED=0 GOOS=windows go build -v --ldflags="-w -s -X 'sigs.k8s.io/kustomize/api/provenance.version=$(VERSION)' -X sigs.k8s.io/kustomize/api/provenance.buildDate=$(BUILD_DATE) -X sigs.k8s.io/kustomize/api/provenance.gitCommit=$(GIT_COMMIT)" \
		-o bin/windows/arm64/ $(PKG)
