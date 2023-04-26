#!/usr/bin/env bash
set -euo pipefail

# Function to clean up the plugin directory if the installation fails
cleanup() {
  if [ -d "$HELM_PLUGIN_DIR" ]; then
    rm -rf "$HELM_PLUGIN_DIR"
  fi
}

# Check for dependencies
dependencies=("aws" "openssl")

for dep in "${dependencies[@]}"; do
  if ! command -v "$dep" >/dev/null 2>&1; then
    echo -e "\033[31mError: $dep is not installed. Please install it and try again.\033[0m"
    cleanup
    exit 1
  fi
done

echo "Helm s3-values plugin installed successfully!"