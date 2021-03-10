# php-extension-library

## Index ##

* [About](#about)
* [Setup](#setup)
* [Documentation](#documentation)
* [Issues](#issues)

## About ## 

This is a PHP extension library collection with `*.so` files to make adding libraries to PHP easy. 

* Visit [my website](https://jrquick.com) for other cool projects!

## Setup

## Documentation

### pcntl.so

*Current Versions*
* php@5.*
* php@7.1.*
* php@7.2.*
* php@7.3.*
* php@7.4.*
* php@8.*

  1. Download `pcntl.so` from the appropriate subdirectory of this repo based on your php version
  2. Move to extensions
    * Move `pcntl.so` file to `/Applications/MAMP/bin/php/phpX.Y.Z/lib/php/extensions/no-debug-non-zts-xxxxxxxx`
  3. Update INI
    * Add `extension=pcntl.so` to your `php.ini`
      * **Tip:** Use `php --ini` to locate the file.

### redis.so

*Current Versions*
* php@5.*
* php@7.1.*
* php@7.2.*
* php@7.3.*
* php@7.4.*
* php@8.*

#### php@^3.0.0

  1. Mkdir `include/php` in php root
    * Example: `/Applications/MAMP/bin/php/php5.5.10/include/php`.
  2. Download php source file from php.net
    * Example: If you want to compile extension for `php 5.4.42`, then download `php5.4.42.tar.gz`
  3. Extract tar to the `include/php` directory.
  4. Execute `./configure` in `include/php`.
  5. `cd /Applications/MAMP/bin/php/phpX.Y.Z/bin` and execute `./pecl install redis` (for default version)
    * **Tip:**: Run `./pecl install redis-2.2.8` for special version.
  6. Add `extension="redis.so"` to the end of `php.ini` 

#### php@^4.0.0
  0. You may need install `autoconf` via `brew install autoconf`.
  1. `cd /Applications/MAMP/bin/php/phpX.Y.Z/bin` and execute `./pecl install redis` (for default version) 
    * **Tip:** Run `./pecl install redis-3.1.2` for special version.
  2. Add `extension="redis.so"` to the end of `php.ini`
  
#### php@>=5.0.0

  1. Download `pcntl.so` from the appropriate subdirectory of this repo based on your php version
  2. Move to extensions
    * Move `redis.so` file to `/Applications/MAMP/bin/php/phpX.Y.Z/lib/php/extensions/no-debug-non-zts-xxxxxxxx`
  3. Update INI
    * Add `extension=redis.so` to your `php.ini`
      * **Tip:** Use `php --ini` to locate the file.

## Issues ##

If you find any issues feel free to open a request in [the Issues tab](https://github.com/jrquick17/php-extension-library/issues). If I have the time I will try to solve any issues but cannot make any guarantees. Feel free to contribute yourself.
