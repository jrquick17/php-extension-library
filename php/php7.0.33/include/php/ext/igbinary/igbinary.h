#ifndef PHPEXT_IGBINARY_BASE_IGBINARY_H
#define PHPEXT_IGBINARY_BASE_IGBINARY_H
#include "php_version.h"
#if PHP_MAJOR_VERSION == 5
#include "src/php5/igbinary.h"
#elif PHP_MAJOR_VERSION == 7
#include "src/php7/igbinary.h"
#else
#error "Unsupported php version for igbinary build"
#endif
#endif
