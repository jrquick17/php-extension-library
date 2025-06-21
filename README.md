# PHP Extension Library

A collection of pre-compiled PHP extensions (`.so` files) for easy installation across multiple PHP versions.

## Table of Contents

- [Overview](#overview)
- [Supported Extensions](#supported-extensions)
- [Installation Guide](#installation-guide)
- [Supported PHP Versions](#supported-php-versions)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## Overview

This library provides pre-compiled shared object files for popular PHP extensions, eliminating the need to compile from source. Perfect for development environments like MAMP, XAMPP, or custom PHP installations.

**Available Extensions:**
- **pcntl** - Process Control functions for Unix-like systems
- **redis** - Redis client for connecting to Redis databases

## Supported Extensions

### 📦 PCNTL Extension
Process Control extension that enables PHP to fork processes and handle signals.

**Use cases:**
- Multi-process applications
- Signal handling
- Process management
- Background job processing

### 📦 Redis Extension
High-performance Redis client for PHP applications.

**Use cases:**
- Caching
- Session storage
- Real-time messaging
- Data structure operations

## Installation Guide

### Method 1: Download Pre-compiled Extension (Recommended)

1. **Identify your PHP version:**
   ```bash
   php --version
   ```

2. **Download the extension:**
   - Browse to the matching `phpX.Y.Z/` directory
   - Download the required `.so` file (`pcntl.so` or `redis.so`)

3. **Find your PHP extensions directory:**
   ```bash
   php -i | grep extension_dir
   ```
   
   Common paths:
   ```
   # MAMP
   /Applications/MAMP/bin/php/phpX.Y.Z/lib/php/extensions/no-debug-non-zts-xxxxxxxx
   
   # XAMPP
   /Applications/XAMPP/xamppfiles/lib/php/extensions/no-debug-non-zts-xxxxxxxx
   
   # Linux
   /usr/lib/php/YYYYMMDD/
   ```

4. **Copy the extension file:**
   ```bash
   cp downloaded-extension.so /path/to/php/extensions/
   ```

5. **Update php.ini:**
   ```bash
   # Find your php.ini file
   php --ini
   
   # Add extension to php.ini
   echo "extension=pcntl.so" >> /path/to/php.ini
   # OR
   echo "extension=redis.so" >> /path/to/php.ini
   ```

6. **Restart your web server and verify:**
   ```bash
   php -m | grep -E "(pcntl|redis)"
   ```

### Method 2: Compile Using PECL (Alternative)

If the pre-compiled version doesn't work, you can compile using PECL:

#### For Redis Extension:

**PHP 5.x:**
```bash
# Install dependencies
brew install autoconf  # macOS only

# Create include directory
mkdir -p /Applications/MAMP/bin/php/phpX.Y.Z/include/php

# Download and extract PHP source
wget https://www.php.net/distributions/php-X.Y.Z.tar.gz
tar -xzf php-X.Y.Z.tar.gz -C /Applications/MAMP/bin/php/phpX.Y.Z/include/php

# Configure PHP source
cd /Applications/MAMP/bin/php/phpX.Y.Z/include/php/php-X.Y.Z
./configure

# Install Redis extension
cd /Applications/MAMP/bin/php/phpX.Y.Z/bin
./pecl install redis

# Add to php.ini
echo "extension=redis.so" >> /path/to/php.ini
```

**PHP 7.x/8.x:**
```bash
cd /Applications/MAMP/bin/php/phpX.Y.Z/bin
./pecl install redis
echo "extension=redis.so" >> /path/to/php.ini
```

## Supported PHP Versions

### PCNTL Extension
- PHP 5.3.27 - 5.6.36
- PHP 7.0.0 - 7.4.15
- PHP 8.0.0 - 8.0.2

### Redis Extension
- PHP 5.0.0 - 5.6.36
- PHP 7.0.0 - 7.4.15
- PHP 8.0.0 - 8.0.2

> **Note:** Over 300 specific PHP versions are supported. Check the repository directories for your exact version.

## Troubleshooting

### Common Issues

**Extension not loading:**
```bash
# Check if extension is enabled
php -m | grep extension_name

# Check for errors
php -i | grep -A5 -B5 extension_name
```

**Wrong architecture/version:**
- Ensure the extension matches your PHP version exactly
- Check if you're using the correct architecture (32-bit vs 64-bit)
- Verify thread safety settings match your PHP build

**Permission issues:**
```bash
# Fix file permissions
chmod 755 /path/to/extension.so
chown www-data:www-data /path/to/extension.so  # Linux
```

**MAMP-specific issues:**
- Use MAMP's PHP binary, not system PHP
- Extensions directory path should match MAMP's PHP installation
- Restart MAMP after making changes

### Getting Help

1. Check the [Issues](https://github.com/jrquick17/php-extension-library/issues) for similar problems
2. Include the following in your issue report:
   - PHP version (`php --version`)
   - Operating system
   - Error messages
   - Installation method used

## Contributing

Contributions are welcome! Please feel free to:

- Report bugs or issues
- Request support for additional PHP versions
- Submit pull requests with improvements
- Add support for new extensions

---

**Author:** [jrquick.com](https://jrquick.com)

**License:** Please check individual extension licenses
