# install-lib run

Run a command with a TUI spinner when available, else plain output, summarizing result.

## Overview

Internal helper for environments without TUI support.

## Index

* [@install.run::step](#installrunstep)

### @install.run::step

Prints a step header, executes the command, streams output, and shows success/failure. Uses mkfifo+tput when available.

#### Example

```bash
@install.run::step "List home" ls -la "$HOME"
```

#### Arguments

* **$1** (string): Human-friendly description.
* **...** (string): Command and args to execute.

#### Variables set

* **INSTALL_LIB_RUN_FORCE_PLAIN** (boolean): Force plain mode when set.
* **INSTALL_LIB_RUN_TAIL_LINES** (number): Override number of tail lines in plain mode.
* **TMPDIR** (string): Base directory for temporary files (optional).
* **INSTALL_LIB_ICON_CHECK** (string): Success icon.
* **INSTALL_LIB_ICON_CROSS** (string): Failure icon.
* **INSTALL_LIB_COLOR_ACCENT** (string): Accent color code.
* **INSTALL_LIB_COLOR_SUCCESS** (string): Success color code.
* **INSTALL_LIB_COLOR_FAIL** (string): Failure color code.

#### Exit codes

* Command exit status passes through.

#### Output on stdout

* Step header, live output, and summary line.

#### Output on stderr

* Command stderr is merged into stdout in the log.

