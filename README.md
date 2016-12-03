# lua-psl

Bindings to [libpsl](https://github.com/rockdaboot/libpsl), a C library that handles the Public Suffix List (PSL).

The PSL is a list of domains where there may be subdomains outside of the administrator's control.
e.g. the administrator of '.com' does not manage 'github.com'.

This list has found use in many internet technologies including:
  
  - preventing cross-domain cookie leakage
  - allowance of issuing wildcard TLS certificates

More information can be found at https://publicsuffix.org/

## Features

  - Compatible with Lua 5.1, 5.2, 5.3 and [LuaJIT](http://luajit.org/)


## Status

  - This is a new project


# Installation

It's recommended to install lua-psl by using [luarocks](https://luarocks.org/).

    $ luarocks install --server=http://luarocks.org/dev psl

## Dependencies

  - [libpsl](https://github.com/rockdaboot/libpsl) >= 0.4.0

### For running tests

  - [busted](http://olivinelabs.com/busted/)


# Development

## Getting started

  - Clone the repo:
    ```
    $ git clone https://github.com/daurnimator/lua-psl.git
    $ cd lua-psl
    ```

  - Install your local copy:
    ```
    $ luarocks make psl-scm-0.rockspec
    ```

  - Run tests ([install tools first](#for-running-tests))
    ```
    $ busted
    ```
