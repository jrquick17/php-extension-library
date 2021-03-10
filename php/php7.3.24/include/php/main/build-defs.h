/*                                                                -*- C -*-
   +----------------------------------------------------------------------+
   | PHP Version 7                                                        |
   +----------------------------------------------------------------------+
   | Copyright (c) 1997-2018 The PHP Group                                |
   +----------------------------------------------------------------------+
   | This source file is subject to version 3.01 of the PHP license,      |
   | that is bundled with this package in the file LICENSE, and is        |
   | available through the world-wide-web at the following url:           |
   | http://www.php.net/license/3_01.txt                                  |
   | If you did not receive a copy of the PHP license and are unable to   |
   | obtain it through the world-wide-web, please send a note to          |
   | license@php.net so we can mail you a copy immediately.               |
   +----------------------------------------------------------------------+
   | Author: Stig Sæther Bakken <ssb@php.net>                             |
   +----------------------------------------------------------------------+
*/

#define CONFIGURE_COMMAND " './configure'  '--with-gd' '--with-webp-dir=/Applications/MAMP/Library' '--with-jpeg-dir=/Applications/MAMP/Library' '--with-png-dir=/Applications/MAMP/Library' '--with-zlib' '--with-zlib-dir=/Applications/MAMP/Library' '--with-freetype-dir=/Applications/MAMP/Library' '--prefix=/Applications/MAMP/bin/php/php7.3.24' '--exec-prefix=/Applications/MAMP/bin/php/php7.3.24' '--sysconfdir=/Applications/MAMP/bin/php/php7.3.24/conf' '--with-config-file-path=/Applications/MAMP/bin/php/php7.3.24/conf' '--enable-ftp' '--with-bz2=/Applications/MAMP/Library' '--with-mysqli=mysqlnd' '--enable-mbstring=all' '--with-curl=/Applications/MAMP/Library' '--enable-sockets' '--enable-bcmath' '--with-imap=shared,/Applications/MAMP/Library/lib/imap-2007f' '--with-imap-ssl=/Applications/MAMP/Library' '--enable-soap' '--with-kerberos' '--enable-calendar' '--with-pgsql=shared,/Applications/MAMP/Library/pg' '--enable-exif' '--with-libxml-dir=/Applications/MAMP/Library' '--with-gettext=shared,/Applications/MAMP/Library' '--with-xsl=/Applications/MAMP/Library' '--with-pdo-mysql=mysqlnd' '--with-pdo-pgsql=shared,/Applications/MAMP/Library/pg' '--with-openssl=/Applications/MAMP/Library' '--enable-zip' '--with-pcre-dir=/Applications/MAMP/Library' '--with-libzip=/Applications/MAMP/Library' '--with-iconv=/Applications/MAMP/Library' '--enable-opcache' '--enable-intl' '--with-tidy=shared,/Applications/MAMP/Library' '--with-icu-dir=/Applications/MAMP/Library' '--enable-wddx' '--with-libexpat-dir=/Applications/MAMP/Library' '--with-readline' '--with-mhash' '--with-iconv-dir=/Applications/MAMP/Library' '--with-sodium=/Applications/MAMP/Library' '--with-password-argon2=/Applications/MAMP/Library' '--enable-cgi' '--disable-phpdbg' '--with-xmlrpc' '--enable-pcntl' 'YACC=/Applications/MAMP/Library/bin/bison'"
#define PHP_ADA_INCLUDE		""
#define PHP_ADA_LFLAGS		""
#define PHP_ADA_LIBS		""
#define PHP_APACHE_INCLUDE	""
#define PHP_APACHE_TARGET	""
#define PHP_FHTTPD_INCLUDE      ""
#define PHP_FHTTPD_LIB          ""
#define PHP_FHTTPD_TARGET       ""
#define PHP_CFLAGS		"$(CFLAGS_CLEAN) -prefer-non-pic -static"
#define PHP_DBASE_LIB		""
#define PHP_BUILD_DEBUG		""
#define PHP_GDBM_INCLUDE	""
#define PHP_IBASE_INCLUDE	""
#define PHP_IBASE_LFLAGS	""
#define PHP_IBASE_LIBS		""
#define PHP_IFX_INCLUDE		""
#define PHP_IFX_LFLAGS		""
#define PHP_IFX_LIBS		""
#define PHP_INSTALL_IT		""
#define PHP_IODBC_INCLUDE	""
#define PHP_IODBC_LFLAGS	""
#define PHP_IODBC_LIBS		""
#define PHP_MSQL_INCLUDE	""
#define PHP_MSQL_LFLAGS		""
#define PHP_MSQL_LIBS		""
#define PHP_MYSQL_INCLUDE	"@MYSQL_INCLUDE@"
#define PHP_MYSQL_LIBS		"@MYSQL_LIBS@"
#define PHP_MYSQL_TYPE		"@MYSQL_MODULE_TYPE@"
#define PHP_ODBC_INCLUDE	""
#define PHP_ODBC_LFLAGS		""
#define PHP_ODBC_LIBS		""
#define PHP_ODBC_TYPE		""
#define PHP_OCI8_SHARED_LIBADD 	""
#define PHP_OCI8_DIR			""
#define PHP_OCI8_ORACLE_VERSION		""
#define PHP_ORACLE_SHARED_LIBADD 	"@ORACLE_SHARED_LIBADD@"
#define PHP_ORACLE_DIR				"@ORACLE_DIR@"
#define PHP_ORACLE_VERSION			"@ORACLE_VERSION@"
#define PHP_PGSQL_INCLUDE	""
#define PHP_PGSQL_LFLAGS	""
#define PHP_PGSQL_LIBS		""
#define PHP_PROG_SENDMAIL	"/usr/sbin/sendmail"
#define PHP_SOLID_INCLUDE	""
#define PHP_SOLID_LIBS		""
#define PHP_EMPRESS_INCLUDE	""
#define PHP_EMPRESS_LIBS	""
#define PHP_SYBASE_INCLUDE	""
#define PHP_SYBASE_LFLAGS	""
#define PHP_SYBASE_LIBS		""
#define PHP_DBM_TYPE		""
#define PHP_DBM_LIB		""
#define PHP_LDAP_LFLAGS		""
#define PHP_LDAP_INCLUDE	""
#define PHP_LDAP_LIBS		""
#define PEAR_INSTALLDIR         "/Applications/MAMP/bin/php/php7.3.24/lib/php"
#define PHP_INCLUDE_PATH	".:/Applications/MAMP/bin/php/php7.3.24/lib/php"
#define PHP_EXTENSION_DIR       "/Applications/MAMP/bin/php/php7.3.24/lib/php/extensions/no-debug-non-zts-20180731"
#define PHP_PREFIX              "/Applications/MAMP/bin/php/php7.3.24"
#define PHP_BINDIR              "/Applications/MAMP/bin/php/php7.3.24/bin"
#define PHP_SBINDIR             "/Applications/MAMP/bin/php/php7.3.24/sbin"
#define PHP_MANDIR              "/Applications/MAMP/bin/php/php7.3.24/php/man"
#define PHP_LIBDIR              "/Applications/MAMP/bin/php/php7.3.24/lib/php"
#define PHP_DATADIR             "/Applications/MAMP/bin/php/php7.3.24/share/php"
#define PHP_SYSCONFDIR          "/Applications/MAMP/bin/php/php7.3.24/conf"
#define PHP_LOCALSTATEDIR       "/Applications/MAMP/bin/php/php7.3.24/var"
#define PHP_CONFIG_FILE_PATH    "/Applications/MAMP/bin/php/php7.3.24/conf"
#define PHP_CONFIG_FILE_SCAN_DIR    ""
#define PHP_SHLIB_SUFFIX        "so"
#define PHP_SHLIB_EXT_PREFIX    ""
