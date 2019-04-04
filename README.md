# Installation:

  1. Download `redis.so` 
    * Download `redis.so` from the appropriate subdirectory of this repo based on major and minor version number X.Y.
  2. Move to MAMP
    * Move `redis.so` file to `/Applications/MAMP/bin/php/phpX.Y.Z/lib/php/extensions/no-debug-non-zts-xxxxxxxx`
  3. Update INI
    * Add `extension=redis.so` to the end of your `php.ini`
      * **Tip:** Use `php --ini` to locate the file.
  4. Restart MAMP.

## How to do it yourself.

### For 3.x

  1. Mkdir `include/php` in `/Applications/MAMP/bin/php/phpX.Y.Z/`
    * Example: `/Applications/MAMP/bin/php/php5.5.10/include/php`.
  2. Download php source file from php.net
    * Example: If you want to compile extension for `php 5.4.42`, then download `php5.4.42.tar.gz`
  3. Extract tar to the `include/php` directory.
  4. Execute `./configure` in `include/php`.
  5. `cd /Applications/MAMP/bin/php/phpX.Y.Z/bin` and execute `./pecl install redis` (for default version)
    * **Tip:**: Run `./pecl install redis-2.2.8` for special version.
  6. Add `extension="redis.so"` to the end of `php.ini` 
    * **Tip:** Open MAMP click File → Edit Template → PHP → PHP 5.X.Y php.ini
  7. Restart MAMP.

### For 4.x
  0. You may need install `autoconf` via `brew install autoconf`.
  1. `cd /Applications/MAMP/bin/php/phpX.Y.Z/bin` and execute `./pecl install redis` (for default version) 
    * **Tip:** Run `./pecl install redis-3.1.2` for special version.
  2. Add `extension="redis.so"` to the end of `php.ini`
    * **Tip:** Open MAMP Pro dashboard → LANGUAGE-PHP → 'Manually enable other extensions'
  3. Restart MAMP.


