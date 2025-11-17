# install-lib packages

Install packages using detected manager; warn if manager is unknown.

## Overview

Checks PATH for well-known package managers in priority order.

## Index

* [@install.pkg::detect_manager](#installpkgdetectmanager)
* [@install.pkg::ensure](#installpkgensure)

### @install.pkg::detect_manager

Checks PATH for well-known package managers in priority order.

#### Example

```bash
mgr="$(@install.pkg::detect_manager)"
```

#### Exit codes

* **0**: when detection completes.

#### Output on stdout

* Manager name or "unknown".

### @install.pkg::ensure

#### Example

```bash
@install.pkg::ensure git curl
```

#### Arguments

* **...** (string): Package names to ensure are installed.

#### Exit codes

* Pass-through of package manager; **0**: on success else manager exit.

#### Output on stderr

* Progress or warnings.

