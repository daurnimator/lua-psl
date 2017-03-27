# Introduction

lua-psl is a set of [lua](https://www.lua.org) bindings to [libpsl](https://github.com/rockdaboot/libpsl), a C library that handles the Public Suffix List (PSL).

The PSL is a list of domains where there may be sub-domains outside of the administrator's control.
e.g. the administrator of '.com' does not manage 'github.com'.

This list has found use in many internet technologies including:

  - preventing cross-domain cookie leakage
  - allowance of issuing wild-card TLS certificates

More information can be found at [publicsuffix.org](https://publicsuffix.org/)


# API

## psl library

Load with `require "psl"`

### `psl.load_file(path)` <!-- --> {#psl.load_file}

Loads a psl from the given file path.
On success, returns a [psl object](#psl-object).
On failure, returns `nil`.


### `psl.load_fp(file)` <!-- --> {#psl.load_fp}

Loads a psl from the given [lua file object](https://www.lua.org/manual/5.3/manual.html#6.8).
On success, returns a [psl object](#psl-object).
On failure, returns `nil`.


### `psl.builtin()` <!-- --> {#psl.builtin}

Returns the psl built in to libpsl.
If it exists, returns a [psl object](#psl-object).
If libpsl was compiled without one, returns `nil`.


### `psl.builtin_file_time()` <!-- --> {#psl.builtin_file_time}

Returns the time-stamp of the file used to build the built in psl.
If it exists, returns the time-stamp as an integer.
If libpsl was compiled without one, returns `nil`.


### `psl.builtin_sha1sum()` <!-- --> {#psl.builtin_sha1sum}

Returns the SHA1 checksum of the file used to build the built in psl.
If it exists, returns the checksum as a string of lower-case hex digits.
If libpsl was compiled without one, returns `nil`.


### `psl.builtin_filename()` <!-- --> {#psl.builtin_filename}

Returns the file name of the file used to build the built in psl.
If it exists, returns a string.
If libpsl was compiled without one, returns `nil`.


### `psl.builtin_outdated()` <!-- --> {#psl.builtin_outdated}

Returns a boolean indicating if the built-in data is older than the file currently at [`psl.builtin_filename()`](#psl.builtin_filename).

Note: This function will not exist if lua-psl is compiled against libpsl 0.10 or earlier.


### `psl.dist_filename()` <!-- --> {#psl.dist_filename}

Returns a string containing the path to your computer's default psl database location.
If libpsl was not configured with one or was configured with an empty path, returns `nil`.

Note: This function will not exist if lua-psl is compiled against libpsl 0.15 or earlier.


### `psl.latest(filename)` <!-- --> {#psl.latest}

This function loads the the latest available PSL data from the following locations:

 1. `filename` (application specific filename, may be `nil`)
 2. default psl database location (as returned from [`psl.dist_filename()`](#psl.dist_filename))
 3. built-in PSL data (as returned from [`psl.builtin()`](#psl.builtin))
 4. location of built-in data (as returned from [`psl.builtin_filename()`](#psl.builtin_filename))

If none of the locations contain a valid psl object then returns `nil`.

Note: This function will not exist if lua-psl is compiled against libpsl 0.15 or earlier.


### `psl.get_version()` <!-- --> {#psl.get_version}

Returns a string containing the version of libpsl.


### `psl.check_version_number(version)` <!-- --> {#psl.check_version_number}

Check if the given version number is at least the current library version number.

Returns the current library version number if the given version number is at least the version of the library, otherwise returns `false`. If the `version` argument is missing, `nil` or `0` then returns the current library version number without performing a check.

Note: This function will not exist if lua-psl is compiled against libpsl 0.10 or earlier.


### `psl.str_to_utf8lower(str, encoding, locale)` <!-- --> {#psl.str_to_utf8lower}

Converts a string to UTF-8 lower-case + NFKC representation.

`encoding` (optional) is the charset encoding of `str`.
`locale` (optional) is the locale of `str`.

On success, returns a string.
On failure, returns `nil`.


### `psl.VERSION` <!-- --> {#psl.VERSION}

The libpsl version as a string.

Note: This constant will not exist if lua-psl is compiled against libpsl 0.10 or earlier.


### `psl.VERSION_NUMBER` <!-- --> {#psl.VERSION_NUMBER}

The libpsl version as an integer.

Note: This constant will not exist if lua-psl is compiled against libpsl 0.10 or earlier.


### `psl.VERSION_MAJOR` <!-- --> {#psl.VERSION_MAJOR}

The libpsl major version as an integer.

Note: This constant will not exist if lua-psl is compiled against libpsl 0.10 or earlier.


### `psl.VERSION_MINOR` <!-- --> {#psl.VERSION_MINOR}

The libpsl minor version as an integer.

Note: This constant will not exist if lua-psl is compiled against libpsl 0.10 or earlier.


### `psl.VERSION_PATCH` <!-- --> {#psl.VERSION_PATCH}

The libpsl patch version as an integer.

Note: This constant will not exist if lua-psl is compiled against libpsl 0.10 or earlier.


### `psl.TYPE` <!-- --> {#psl.TYPE}

A table containing constants for [`psl:is_public_suffix()`](#psl:is_public_suffix).

  - `ANY`
  - `ICANN`
  - `PRIVATE`

Note: This table will not exist if lua-psl is compiled against libpsl 0.11 or earlier.


## psl object

### `psl:free()` <!-- --> {#psl:free}

Manually free the resources used by the psl object.

Will be called automatically if the psl object is collected.


### `psl:is_public_suffix(domain, type)` <!-- --> {#psl:is_public_suffix}

Checks if `domain` is on the public suffix list.

`domain` should be a UTF-8 string.

`type` (optional) should be one of the [`psl.TYPE`](#psl.TYPE) constants; the default behaviour is `psl.TYPE.ANY`.
This argument is only supported if compiled against libpsl 0.12.0 or above.

Returns a boolean.


### `psl:unregistrable_domain(domain)` <!-- --> {#psl:unregistrable_domain}

`domain` should be a UTF-8 string.

Returns the longest public suffix part of `domain` as a string.
If `domain` does not contain a public suffix, returns `nil`.


### `psl:registrable_domain(domain)` <!-- --> {#psl:registrable_domain}

`domain` should be a UTF-8 string.

Returns the shortest private suffix part of `domain` as a string.
If `domain` does not contain a private suffix, returns `nil`.


### `psl:suffix_count()` <!-- --> {#psl:suffix_count}

Returns the number of public suffixes as an integer.


### `psl:suffix_exception_count()` <!-- --> {#psl:suffix_exception_count}

Returns the number of public suffix exceptions as an integer.


### `psl:suffix_wildcard_count()` <!-- --> {#psl:suffix_wildcard_count}

Returns the number of public suffix wild-cards as an integer.

Note: This function will not exist if lua-psl is compiled against libpsl 0.10 or earlier.


### `psl:is_cookie_domain_acceptable(hostname, cookie_domain)` <!-- --> {#psl:is_cookie_domain_acceptable}

Checks whether `cookie_domain` is an acceptable cookie domain value for the request `hostname`.

`hostname` and `cookie_domain` should be UTF-8 strings.

Returns a boolean.

#### Example <!-- --> {#psl:is_cookie_domain_acceptable-example}

```lua
local psl = assert(require "psl".builtin())
assert(psl:is_cookie_domain_acceptable("www.example.com", "example.com"))
assert(not psl:is_cookie_domain_acceptable("example.com", "com"))
```


# Links

  - [Github](https://github.com/daurnimator/lua-psl)
  - [Issue tracker](https://github.com/daurnimator/lua-psl/issues)
  - [libpsl](https://github.com/rockdaboot/libpsl)
  - [publicsuffix.org](https://publicsuffix.org/)
