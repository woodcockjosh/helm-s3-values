#!/usr/bin/env sh
set -euo pipefail

# Function to check if a string is an S3 URL
is_s3_url() {
  local url="$1"
  [[ $url == s3://* ]]
}

# Function to download a file from S3 to a specified directory
download_file() {
  local s3_url="$1"
  local local_dir="$2"

  # Download the file from the S3 bucket
  aws s3 cp "$s3_url" "$local_dir" >/dev/null 2>&1
}

# Function to generate a random ID
generate_random_id() {
   openssl rand -hex 4
}

# Main script logic
args=("$@")
random_id=$(generate_random_id)
temp_dir="/tmp/$random_id"

for i in "${!args[@]}"; do
  if [[ "${args[i]}" == "--values" ]]; then
    if is_s3_url "${args[i+1]}"; then
      # Extract bucket and path from the S3 URL
      bucket_and_path=$(echo "${args[i+1]}" | sed -e 's|^s3://||')

      # Create the local directory structure to match the S3 path
      local_file_path="$temp_dir/$bucket_and_path"
      mkdir -p "$(dirname "$local_file_path")"

      # Download the file
      download_file "${args[i+1]}" "$local_file_path"

      # Update the command arguments
      args[i+1]="$local_file_path"
    fi
  fi
done

# Execute the Helm command with the downloaded files
$HELM_BIN "${args[@]}"

# Clean up the temporary directory
rm -rf "$temp_dir"