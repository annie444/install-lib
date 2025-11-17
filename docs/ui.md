# install-lib ui

Move cursor up N lines (default 1).

## Overview

Reads from stdin and normalizes yes/no responses; defaults to provided value.

## Index

* [@install.ui::prompt_yes_no](#installuipromptyesno)
* [@install.ui::prompt_enter](#installuipromptenter)
* [@install.ui::choose](#installuichoose)
* [@install.ui::section](#installuisection)
* [@install.ui::is_tty](#installuiistty)
* [@install.ui::has_tput](#installuihastput)
* [@install.ui::cursor_hide](#installuicursorhide)
* [@install.ui::cursor_show](#installuicursorshow)
* [@install.ui::clear_line](#installuiclearline)
* [@install.ui::clear_screen](#installuiclearscreen)
* [@install.ui::clear_lines](#installuiclearlines)
* [@install.ui::cursor_save](#installuicursorsave)
* [@install.ui::cursor_restore](#installuicursorrestore)
* [@install.ui::cursor_up](#installuicursorup)

### @install.ui::prompt_yes_no

Reads from stdin and normalizes yes/no responses; defaults to provided value.

#### Example

```bash
if @install.ui::prompt_yes_no "Continue?" y; then echo yes; fi
```

#### Arguments

* **$1** (string): Prompt text.
* **$2** (string): Optional default (y|n).

#### Exit codes

* **0**: for yes, 1 for no.

#### Input on stdin

* User response.

### @install.ui::prompt_enter

#### Example

```bash
@install.ui::prompt_enter "Next?"
```

#### Arguments

* **$1** (string): Prompt text (optional).

_Function has no arguments._

#### Exit codes

* **0**: after reading input; non-zero on read error.

#### Input on stdin

* Single keypress.

### @install.ui::choose

Accepts either value/label pairs or a simple list (value=label). Uses arrow keys or j/k to move.

#### Example

```bash
@install.ui::choose CHOICE "Pick" foo "Foo label" bar "Bar label"
```

#### Arguments

* **$1** (string): Variable name to export selection to.
* **$2** (string): Prompt to display.
* **...** (string): Value/option pairs or plain options.

#### Variables set

* **selected** (Selected): index (internal, unset before return).
* **selected_value** (Selected): value (internal, unset before return).
* **INSTALL_LIB_ICON_CHECK** (string): Icon prefix for the selected option (optional).

#### Exit codes

* **0**: on selection; 1 when no options.

#### Input on stdin

* Keypress navigation and Enter to select.

#### Output on stdout

* Menu rendering and selection announcement.

### @install.ui::section

#### Example

```bash
@install.ui::section "Setup"
```

#### Arguments

* **$1** (string): Title to print.

#### Exit codes

* Always 0.

#### Output on stdout

* Formatted section line.

### @install.ui::is_tty

#### Example

```bash
if @install.ui::is_tty; then echo tty; fi
```

#### Exit codes

* **0**: if tty; 1 otherwise.

### @install.ui::has_tput

#### Example

```bash
@install.ui::has_tput || echo "tput missing"
```

#### Exit codes

* **0**: if available; 1 otherwise.

### @install.ui::cursor_hide

#### Example

```bash
@install.ui::cursor_hide
```

#### Exit codes

* Always 0.

### @install.ui::cursor_show

#### Example

```bash
@install.ui::cursor_show
```

#### Exit codes

* Always 0.

### @install.ui::clear_line

#### Example

```bash
@install.ui::clear_line
```

#### Exit codes

* Always 0.

### @install.ui::clear_screen

#### Example

```bash
@install.ui::clear_screen
```

#### Exit codes

* Always 0.

### @install.ui::clear_lines

#### Example

```bash
@install.ui::clear_lines
```

#### Exit codes

* Always 0.

### @install.ui::cursor_save

#### Example

```bash
@install.ui::cursor_save
```

#### Exit codes

* Always 0.

### @install.ui::cursor_restore

#### Example

```bash
@install.ui::cursor_restore
```

#### Exit codes

* Always 0.

### @install.ui::cursor_up

#### Example

```bash
@install.ui::cursor_up 2
```

#### Arguments

* **$1** (number): Lines to move (optional).

#### Exit codes

* Always 0.

