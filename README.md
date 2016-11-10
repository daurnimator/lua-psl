# lua-psl

Bindings to [libpsl](https://github.com/rockdaboot/libpsl), a C library that handles the Public Suffix List (PSL).

The PSL is a list of domains where there may be subdomains outside of the admin's control.  
e.g. the administrator of '.com' does not manage 'github.com'.

This list has found use in many internet technologies including:
  
  - preventing cross-domain cookie leakage
  - allowance of issuing wildcard TLS certificates

More information can be found at https://publicsuffix.org/
