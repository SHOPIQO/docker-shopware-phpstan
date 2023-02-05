# PHPStan Docker images for Shopware

This image runs PHPStan inside a Docker container. This allows you to use this
image to run as a pre-commit hook.

## pre-commit hook

```yaml
---
default_language_version:
    python: python3

default_stages: [commit, push]

repos:
  - repo: local
    hooks:
      - id: phpstan
        name: phpstan
        entry: ghcr.io/SHOPIQO/docker-shopware-phpstan:6.4.15.0-php8.0
        language: docker_image
        types: [file, php]
        verbose: true
        require_serial: true
```
