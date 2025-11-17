# install-lib os

True if the given binary exists in PATH.

## Overview

Uses uname and lowercases result; override via INSTALL_LIB_OS_OVERRIDE for testing.

## Index

* [@install.os::name](#installosname)
* [@install.os::require_cmd](#installosrequirecmd)
* [@install.os::has_cmd](#installoshascmd)

### @install.os::name

Uses uname and lowercases result; override via INSTALL_LIB_OS_OVERRIDE for testing.

#### Example

```bash
os="$(@install.os::name)"
```

#### Variables set

* **INSTALL_LIB_OS_OVERRIDE** (string): Override detected OS value (optional).

#### Exit codes

* **0**: on detection; non-zero if uname fails.

#### Output on stdout

* OS name.

### @install.os::require_cmd

#### Example

```bash
@install.os::require_cmd git
```

#### Arguments

* **$1** (string): Command name to require.

#### Exit codes

* **0**: when found; 127 when missing.

#### Output on stderr

* Error message when missing.

### @install.os::has_cmd

#### Example

```bash
if @install.os::has_cmd brew; then echo "brew present"; fi
```

#### Arguments

* **$1** (string): Command name to check.

#### Exit codes

* **0**: when found; 1 when not.

