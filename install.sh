#!/usr/bin/env bash
# php-extension-library installer script
# One-liner to download, verify, copy, and enable PHP extensions
#
# Target Usage:
#   curl -fsSL https://raw.githubusercontent.com/jrquick17/php-extension-library/main/install.sh | bash -s redis
#   bash install.sh redis 8.2.14

set -e

# Parse arguments
extension=$(echo "$1" | tr '[:upper:]' '[:lower:]')
php_version="$2"

if [ -z "$extension" ]; then
  echo "Error: Extension name is required." >&2
  echo "Usage:" >&2
  echo "  curl -fsSL https://raw.githubusercontent.com/jrquick17/php-extension-library/main/install.sh | bash -s <extension> [php_version]" >&2
  echo "  or" >&2
  echo "  bash install.sh <extension> [php_version]" >&2
  echo "Supported extensions: pcntl, redis, curl" >&2
  exit 1
fi

# Supported extensions check
if [[ "$extension" != "pcntl" && "$extension" != "redis" && "$extension" != "curl" ]]; then
  echo "Error: Unsupported extension '$extension'." >&2
  echo "Supported extensions: pcntl, redis, curl" >&2
  exit 1
fi

# Default command to query PHP environment
php_cmd="php"

# Detect/Set PHP version
if [ -n "$php_version" ]; then
  # Try to find a version-specific php binary for the specified version (e.g. php8.2, php82, php-8.2 for 8.2.14)
  major_minor=$(echo "$php_version" | awk -F. '{print $1"."$2}')
  major_minor_no_dot=$(echo "$php_version" | awk -F. '{print $1$2}')
  if command -v "php${major_minor}" >/dev/null 2>&1; then
    php_cmd="php${major_minor}"
  elif command -v "php${major_minor_no_dot}" >/dev/null 2>&1; then
    php_cmd="php${major_minor_no_dot}"
  elif command -v "php-${major_minor}" >/dev/null 2>&1; then
    php_cmd="php-${major_minor}"
  elif ! command -v php >/dev/null 2>&1; then
    echo "Error: Specified PHP version is $php_version but no PHP binary is found in PATH." >&2
    exit 1
  fi
else
  if ! command -v php >/dev/null 2>&1; then
    echo "Error: php command not found. Please install PHP or specify a PHP version as the second argument." >&2
    exit 1
  fi
  # Clean php version to keep only standard version numbers (e.g. 8.2.14)
  php_version=$(php -r 'echo preg_replace("/^([0-9]+\.[0-9]+\.[0-9]+(?:(?:alpha|beta|RC|pre|a|b)[0-9]*)?).*/i", "$1", PHP_VERSION);')
fi

# Normalize version key to start with "php" prefix
if [[ "$php_version" =~ ^php ]]; then
  manifest_version_key="$php_version"
else
  manifest_version_key="php$php_version"
fi

# Detect extension directory
ext_dir=$($php_cmd -i 2>/dev/null | grep '^extension_dir' | awk '{print $3}')
if [ -z "$ext_dir" ]; then
  ext_dir=$($php_cmd -r 'echo ini_get("extension_dir");' 2>/dev/null)
fi

if [ -z "$ext_dir" ]; then
  echo "Error: Could not determine PHP extension directory." >&2
  exit 1
fi

# Detect loaded php.ini path
php_ini=$($php_cmd --ini 2>/dev/null | grep 'Loaded Configuration' | awk '{print $4}')
if [ -z "$php_ini" ] || [ "$php_ini" = "(none)" ]; then
  php_ini=$($php_cmd -r 'echo php_ini_loaded_file();' 2>/dev/null)
fi

# Create a temporary directory for manifest and download
tmp_dir=$(mktemp -d)
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

# Fetch manifest.json (allow override for local testing)
manifest_url="https://raw.githubusercontent.com/jrquick17/php-extension-library/main/manifest.json"
if [ -n "$MANIFEST_URL_OVERRIDE" ]; then
  manifest_url="$MANIFEST_URL_OVERRIDE"
fi

manifest_file="$tmp_dir/manifest.json"

echo "Fetching extension manifest..."
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$manifest_url" -o "$manifest_file"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$manifest_file" "$manifest_url"
else
  echo "Error: Neither curl nor wget is available. Please install one of them to proceed." >&2
  exit 1
fi

if [ ! -f "$manifest_file" ]; then
  echo "Error: Failed to retrieve extension manifest." >&2
  exit 1
fi

# PHP script to parse the manifest and query the extension details
php_code='
$manifest_path = $argv[1];
$version_key = $argv[2];
$extension = $argv[3];

if (!file_exists($manifest_path)) {
    fwrite(STDERR, "Error: manifest.json not found locally.\n");
    exit(2);
}

$manifest = json_decode(file_get_contents($manifest_path), true);
if ($manifest === null) {
    fwrite(STDERR, "Error: Failed to parse manifest.json\n");
    exit(2);
}

// Check if version exists in manifest
if (!isset($manifest["extensions"][$version_key])) {
    $supported = [];
    foreach ($manifest["extensions"] as $v => $exts) {
        if (isset($exts[$extension])) {
            $supported[] = preg_replace("/^php/", "", $v);
        }
    }
    usort($supported, "version_compare");
    fwrite(STDERR, "Error: PHP version " . preg_replace("/^php/", "", $version_key) . " is not supported for extension " . $extension . ".\n");
    if (!empty($supported)) {
        fwrite(STDERR, "Supported PHP versions for " . $extension . ":\n");
        fwrite(STDERR, implode(", ", $supported) . "\n");
    }
    exit(1);
}

// Check if extension exists for this version
if (!isset($manifest["extensions"][$version_key][$extension])) {
    $supported = [];
    foreach ($manifest["extensions"] as $v => $exts) {
        if (isset($exts[$extension])) {
            $supported[] = preg_replace("/^php/", "", $v);
        }
    }
    usort($supported, "version_compare");
    fwrite(STDERR, "Error: Extension " . $extension . " is not supported for PHP version " . preg_replace("/^php/", "", $version_key) . ".\n");
    if (!empty($supported)) {
        fwrite(STDERR, "Supported PHP versions for " . $extension . ":\n");
        fwrite(STDERR, implode(", ", $supported) . "\n");
    }
    exit(1);
}

$info = $manifest["extensions"][$version_key][$extension];
echo $info["file"] . " " . $info["sha256"] . "\n";
'

php_stdout_file="$tmp_dir/php_stdout"
php_stderr_file="$tmp_dir/php_stderr"

$php_cmd -r "$php_code" "$manifest_file" "$manifest_version_key" "$extension" > "$php_stdout_file" 2> "$php_stderr_file"
php_status=$?

if [ $php_status -ne 0 ]; then
  cat "$php_stderr_file" >&2
  exit 1
fi

result=$(cat "$php_stdout_file")
if [ -z "$result" ]; then
  echo "Error: Unknown error checking manifest compatibility." >&2
  exit 1
fi

read -r extension_file expected_sha256 <<< "$result"

# Determine download URL (allow override for local testing)
if [ -n "$DOWNLOAD_URL_OVERRIDE" ]; then
  # Replace placeholders {VERSION} and {FILE}
  download_url="${DOWNLOAD_URL_OVERRIDE//\{VERSION\}/$manifest_version_key}"
  download_url="${download_url//\{FILE\}/$extension_file}"
else
  download_url="https://raw.githubusercontent.com/jrquick17/php-extension-library/main/${manifest_version_key}/${extension_file}"
fi

so_file="$tmp_dir/${extension_file}"

echo "Downloading '${extension}' extension binary..."
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$download_url" -o "$so_file"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$so_file" "$download_url"
else
  echo "Error: Neither curl nor wget is available." >&2
  exit 1
fi

if [ ! -f "$so_file" ]; then
  echo "Error: Failed to download the extension binary from $download_url" >&2
  exit 1
fi

# Verify SHA256 checksum
echo "Verifying SHA256 checksum..."
calculate_sha256() {
  local file="$1"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$file" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$file" | awk '{print $1}'
  elif command -v openssl >/dev/null 2>&1; then
    openssl dgst -sha256 "$file" | awk '{print $2}'
  else
    $php_cmd -r 'echo hash_file("sha256", $argv[1]);' "$file"
  fi
}

actual_sha256=$(calculate_sha256 "$so_file")

if [ "$actual_sha256" != "$expected_sha256" ]; then
  echo "Error: SHA256 mismatch for ${extension_file}!" >&2
  echo "Expected: $expected_sha256" >&2
  echo "Actual:   $actual_sha256" >&2
  rm -f "$so_file"
  exit 1
fi

echo "SHA256 checksum verified successfully."

# Check write permission to extension directory
if [ ! -w "$ext_dir" ]; then
  echo "Error: No write permission to PHP extension directory: $ext_dir" >&2
  echo "Please run this script with sudo, or copy the file manually using sudo:" >&2
  echo "  sudo cp \"$so_file\" \"$ext_dir/\"" >&2
  exit 1
fi

# Copy the file
echo "Copying ${extension_file} to ${ext_dir}..."
cp "$so_file" "$ext_dir/"
if [ $? -ne 0 ]; then
  echo "Error: Failed to copy ${extension_file} to ${ext_dir}." >&2
  exit 1
fi

# Update php.ini
if [ -n "$php_ini" ] && [ -f "$php_ini" ]; then
  # Check if extension is already configured
  if grep -q -E "^\s*extension\s*=\s*\"?${extension}(\.so)?\"?\s*$" "$php_ini" || grep -q -E "^\s*extension\s*=\s*\"?php_${extension}(\.dll)?\"?\s*$" "$php_ini"; then
    echo "Extension '${extension}' is already configured in $php_ini."
  else
    if [ ! -w "$php_ini" ]; then
      echo "Warning: No write permission to $php_ini." >&2
      echo "Please manually add the following line to your php.ini:" >&2
      echo "  extension=${extension}.so" >&2
    else
      # Append to php.ini, ensuring a trailing newline exists first
      if [ -n "$(tail -c 1 "$php_ini" 2>/dev/null)" ]; then
        echo "" >> "$php_ini"
      fi
      echo "extension=${extension}.so" >> "$php_ini"
      echo "Successfully enabled extension '${extension}' in $php_ini."
    fi
  fi
else
  echo "Warning: Loaded php.ini file not found." >&2
  echo "Please manually add the following line to your php.ini:" >&2
  echo "  extension=${extension}.so" >&2
fi

echo ""
echo "========================================================"
echo "  PHP Extension '${extension}' installed successfully!"
echo "========================================================"
echo "1. If you are using a web server (e.g., Apache, Nginx, PHP-FPM, MAMP, or XAMPP),"
echo "   please restart it for the changes to take effect."
echo "2. You can verify that the extension is active by running:"
echo "   $php_cmd -m | grep ${extension}"
echo "========================================================"
echo ""
