# lua-psl

Bindings to [libpsl](https://github.com/rockdaboot/libpsl), a C library that handles the Public Suffix List (PSL).

The PSL is a list of domains where there may be sub-domains outside of the administrator's control.
e.g. the administrator of '.com' does not manage 'github.com'.

This list has found use in many internet technologies including:
  
  - preventing cross-domain cookie leakage
  - allowance of issuing wildcard TLS certificates

More information can be found at [publicsuffix.org](https://publicsuffix.org/)

## Documentation

Can be found at [https://daurnimator.github.io/lua-psl/](https://daurnimator.github.io/lua-psl/)


## Features

  - Compatible with Lua 5.1, 5.2, 5.3 and [LuaJIT](http://luajit.org/)


## Status

  - This project was started in late 2016
  - Binds all functions available from libpsl up to the 0.17 release


# Installation

It's recommended to install lua-psl by using [luarocks](https://luarocks.org/).

    $ luarocks install psl

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


## Generating documentation

Documentation is written in markdown and intended to be consumed by [pandoc](http://pandoc.org/)

  - To generate self-contained HTML documentation:
    ```
    $ pandoc -t html5 --template=doc/template.html --section-divs --self-contained --toc -c doc/site.css doc/index.md doc/metadata.yaml
    ```

  - To generate a pdf manual:
    ```
    $ pandoc -s -t latex -V documentclass=article -V classoption=oneside -V links-as-notes -V geometry=a4paper,includeheadfoot,margin=2.54cm doc/index.md doc/metadata.yaml -o lua-psl.pdf
    ```
