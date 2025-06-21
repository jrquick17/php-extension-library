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

## Extension Comparison Table

| Feature | **PCNTL** | **Redis** |
|---------|-----------|-----------|
| **Primary Purpose** | Process Control & Forking | In-Memory Data Store & Caching |
| **Platform Support** | Unix/Linux only | Cross-platform |
| **Web Server Compatible** | ❌ CLI only | ✅ Full support |
| **Memory Usage** | Low | High (in-memory storage) |
| **Performance Impact** | Minimal | Very fast (RAM-based) |
| **Data Persistence** | N/A | Optional (configurable) |
| **Complexity** | Medium | Low-Medium |
| **Learning Curve** | Steep | Moderate |

### 📋 **Detailed Feature Comparison**

| **Category** | **PCNTL Extension** | **Redis Extension** |
|--------------|-------------------|-------------------|
| **Core Functions** | `pcntl_fork()`, `pcntl_exec()`, `pcntl_wait()`, `pcntl_signal()` | `SET`, `GET`, `DEL`, `EXISTS`, `EXPIRE`, `INCR` |
| **Data Types** | Process IDs, Exit codes, Signals | Strings, Lists, Sets, Hashes, Sorted Sets, Streams |
| **Concurrency** | Multi-process via forking | Single-threaded with async I/O |
| **Use Cases** | CLI scripts, daemons, parallel processing | Web caching, session storage, real-time features |
| **Resource Usage** | CPU-intensive for forking | Memory-intensive for storage |
| **Scalability** | Limited by system processes | Horizontal via clustering |
| **Error Handling** | Signal-based, exit codes | Exception-based, connection errors |
| **Configuration** | Process limits, signal masks | Connection pools, serialization, compression |

## Supported Extensions

### 📦 PCNTL Extension
**Process Control for Unix Systems**

**Key Features:**
- ✅ Process forking (`pcntl_fork()`)
- ✅ Signal handling (`pcntl_signal()`)
- ✅ Process execution (`pcntl_exec()`)
- ✅ Child process management (`pcntl_wait()`)
- ✅ Alarm scheduling (`pcntl_alarm()`)

**Best For:**
- Command-line applications
- Background job processors
- Multi-process daemons
- System administration scripts
- Parallel task execution

**Limitations:**
- Unix/Linux systems only
- Not suitable for web servers
- Requires careful memory management

### 📦 Redis Extension
**High-Performance In-Memory Data Store**

**Key Features:**
- ✅ Multiple data structures (strings, lists, sets, hashes)
- ✅ Built-in serialization (PHP, JSON, igbinary, msgpack)
- ✅ Compression support (LZF, ZSTD, LZ4)
- ✅ Connection pooling and persistence
- ✅ Transactions and pipelining
- ✅ Pub/Sub messaging

**Best For:**
- Web application caching
- Session management
- Real-time analytics
- Message queuing
- Leaderboards and counting
- Geospatial applications

**Performance Benefits:**
- 🚀 In-memory storage (sub-millisecond latency)
- 🚀 Reduces database load by 60-90%
- 🚀 Handles 100,000+ operations/second
- 🚀 Built-in data structure operations

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
- PHP 8.0.0 - 8.4.2

### Redis Extension
- PHP 5.0.0 - 5.6.36
- PHP 7.0.0 - 7.4.15
- PHP 8.0.0 - 8.4.2

**Latest PHP 8.x Versions Added:**
- PHP 8.0.3 - 8.0.30
- PHP 8.1.0 - 8.1.30
- PHP 8.2.0 - 8.2.26
- PHP 8.3.0 - 8.3.15
- PHP 8.4.0 - 8.4.2

> **Note:** Over 500 specific PHP versions are now supported. Check the repository directories for your exact version.

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
