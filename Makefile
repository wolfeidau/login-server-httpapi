default: generate lint test build bundle ##=> Run all default targets
.PHONY: default

ci: deps generate lint test ##=> Run all CI targets
.PHONY: ci

generate: ##=> generate all the things
	@echo "--- generate all the things"
	@go generate ./...
.PHONY: generate

lint: ##=> Lint all the things
	@echo "--- lint all the things"
	@$(shell pwd)/.bin/golangci-lint run
.PHONY: lint

clean: ##=> Clean all the things
	$(info [+] Clean all the things...")
.PHONY: clean

deps: ##=> Intall all the dependencies to build
	$(info [+] Installing deps...")
	@curl -sfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh| sh -s -- -b $(shell pwd)/.bin v1.21.0
.PHONY: deps

test: ##=> Run the tests
	$(info [+] Run tests...")
	@go test -v -cover ./...
.PHONY: test

build: ##=> build all the things
	@echo "--- build all the things"
	@GOOS=linux GOARCH=amd64 go build -o dist/login-server-httpapi ./cmd/login-server-httpapi 
.PHONY: build

bundle: ##=> Build the bundle
	$(info [+] Build bundle...")
	@zip -r -q ./handler.zip public
	@cd dist && zip -r -q ../handler.zip .
.PHONY: bundle
