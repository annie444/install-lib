# install-lib logging

Log an error and exit with the given code (default 1).

## Overview

Timestamped logging helpers and die wrapper for install-lib.

## Index

* [@install.log::cmd](#installlogcmd)
* [@install.log](#installlog)
* [@install.log::info](#installloginfo)
* [@install.log::warn](#installlogwarn)
* [@install.log::error](#installlogerror)
* [@install.log::debug](#installlogdebug)
* [@install.die](#installdie)

### @install.log::cmd

#### Example

```bash
echo "$(@install.log::cmd "ls" "-la")"
```

#### Arguments

* **$1** (string): Command name.
* **...** (string): Command arguments (optional).

#### Exit codes

* Always 0.

#### Output on stdout

* Colored command string.

### @install.log

Formats a timestamped line with level prefix and optional color to stderr.

#### Example

```bash
@install.log info "starting install"
```

#### Arguments

* **$1** (string): Log level (info|warn|error|debug).
* **...** (string): Message to log (variadic).

#### Variables set

* **INSTALL_LIB_COLOR_INFO** (string): ANSI color prefix for info messages (optional).
* **INSTALL_LIB_COLOR_WARN** (string): ANSI color prefix for warn messages (optional).
* **INSTALL_LIB_COLOR_ERROR** (string): ANSI color prefix for error messages (optional).
* **INSTALL_LIB_COLOR_DEBUG** (string): ANSI color prefix for debug messages (optional).
* **INSTALL_LIB_COLOR_RESET** (string): ANSI reset suffix (optional).

#### Exit codes

* Always 0.

#### Output on stderr

* Formatted log line.

### @install.log::info

#### Example

```bash
@install.log::info "Ready"
```

#### Exit codes

* Always 0.

#### See also

* [@install.log](#installlog)

### @install.log::warn

#### Example

```bash
@install.log::warn "Deprecated flag"
```

#### Exit codes

* Always 0.

#### See also

* [@install.log](#installlog)

### @install.log::error

#### Example

```bash
@install.log::error "Failed to fetch"
```

#### Exit codes

* Always 0.

#### See also

* [@install.log](#installlog)

### @install.log::debug

#### Example

```bash
@install.log::debug "args=$*"
```

#### Exit codes

* Always 0.

#### See also

* [@install.log](#installlog)

### @install.die

#### Example

```bash
@install.die 2 "missing dependency"
```

#### Arguments

* **$1** (number): Optional exit code.
* **...** (string): Error message to log (variadic).

#### Exit codes

* The provided exit code (default 1).

#### Output on stderr

* Error log line.

