.PHONY: dev build check commit

dev:
	hugo server -D

build:
	hugo --minify

check:
	bash scripts/check.sh

commit:
	@if [ -z "$(TYPE)" ] || [ -z "$(MSG)" ]; then \
		echo "Usage: make commit TYPE=<type> MSG=\"<subject>\""; \
		exit 1; \
	fi
	bash scripts/commit-safe.sh "$(TYPE)" "$(MSG)"
