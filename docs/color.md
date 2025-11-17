# install-lib color

Use accent color wrapper (blue default).

## Overview

Color support detection and wrapping helpers for install-lib.

## Index

* [@install.color::wrap](#installcolorwrap)
* [@install.color::bold](#installcolorbold)
* [@install.color::dim](#installcolordim)
* [@install.color::italic](#installcoloritalic)
* [@install.color::underline](#installcolorunderline)
* [@install.color::blink](#installcolorblink)
* [@install.color::reverse](#installcolorreverse)
* [@install.color::hidden](#installcolorhidden)
* [@install.color::strikethrough](#installcolorstrikethrough)
* [@install.color::fg::black](#installcolorfgblack)
* [@install.color::fg::red](#installcolorfgred)
* [@install.color::fg::green](#installcolorfggreen)
* [@install.color::fg::yellow](#installcolorfgyellow)
* [@install.color::fg::blue](#installcolorfgblue)
* [@install.color::fg::magenta](#installcolorfgmagenta)
* [@install.color::fg::cyan](#installcolorfgcyan)
* [@install.color::fg::white](#installcolorfgwhite)
* [@install.color::bg::black](#installcolorbgblack)
* [@install.color::bg::red](#installcolorbgred)
* [@install.color::bg::green](#installcolorbggreen)
* [@install.color::bg::yellow](#installcolorbgyellow)
* [@install.color::bg::blue](#installcolorbgblue)
* [@install.color::bg::magenta](#installcolorbgmagenta)
* [@install.color::bg::cyan](#installcolorbgcyan)
* [@install.color::bg::white](#installcolorbgwhite)
* [@install.color::fg::bright_black](#installcolorfgbrightblack)
* [@install.color::fg::bright_red](#installcolorfgbrightred)
* [@install.color::fg::bright_green](#installcolorfgbrightgreen)
* [@install.color::fg::bright_yellow](#installcolorfgbrightyellow)
* [@install.color::fg::bright_blue](#installcolorfgbrightblue)
* [@install.color::fg::bright_magenta](#installcolorfgbrightmagenta)
* [@install.color::fg::bright_cyan](#installcolorfgbrightcyan)
* [@install.color::fg::bright_white](#installcolorfgbrightwhite)
* [@install.color::bg::bright_black](#installcolorbgbrightblack)
* [@install.color::bg::bright_red](#installcolorbgbrightred)
* [@install.color::bg::bright_green](#installcolorbgbrightgreen)
* [@install.color::bg::bright_yellow](#installcolorbgbrightyellow)
* [@install.color::bg::bright_blue](#installcolorbgbrightblue)
* [@install.color::bg::bright_magenta](#installcolorbgbrightmagenta)
* [@install.color::bg::bright_cyan](#installcolorbgbrightcyan)
* [@install.color::bg::bright_white](#installcolorbgbrightwhite)
* [@install.color::accent](#installcoloraccent)

### @install.color::wrap

Adds reset code and preserves trailing newlines.

#### Example

```bash
@install.color::wrap "$INSTALL_LIB_COLOR_FG_GREEN" "ok"  # prints green ok
```

#### Arguments

* **$1** (string): ANSI color code.
* **...** (string): Text to wrap (variadic).

#### Exit codes

* Always 0.

#### Output on stdout

* Decorated text.

#### Output on stderr

* None.

### @install.color::bold

#### Example

```bash
@install.color::bold "Title"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::dim

#### Example

```bash
@install.color::dim "Note"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::italic

#### Example

```bash
@install.color::italic "Emphasis"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::underline

#### Example

```bash
@install.color::underline "Link"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::blink

#### Example

```bash
@install.color::blink "Alert"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::reverse

#### Example

```bash
@install.color::reverse "Invert"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::hidden

#### Example

```bash
@install.color::hidden "secret"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::strikethrough

#### Example

```bash
@install.color::strikethrough "old"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::black

#### Example

```bash
@install.color::fg::black "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::red

#### Example

```bash
@install.color::fg::red "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::green

#### Example

```bash
@install.color::fg::green "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::yellow

#### Example

```bash
@install.color::fg::yellow "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::blue

#### Example

```bash
@install.color::fg::blue "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::magenta

#### Example

```bash
@install.color::fg::magenta "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::cyan

#### Example

```bash
@install.color::fg::cyan "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::white

#### Example

```bash
@install.color::fg::white "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::black

#### Example

```bash
@install.color::bg::black "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::red

#### Example

```bash
@install.color::bg::red "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::green

#### Example

```bash
@install.color::bg::green "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::yellow

#### Example

```bash
@install.color::bg::yellow "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::blue

#### Example

```bash
@install.color::bg::blue "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::magenta

#### Example

```bash
@install.color::bg::magenta "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::cyan

#### Example

```bash
@install.color::bg::cyan "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::white

#### Example

```bash
@install.color::bg::white "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::bright_black

#### Example

```bash
@install.color::fg::bright_black "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::bright_red

#### Example

```bash
@install.color::fg::bright_red "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::bright_green

#### Example

```bash
@install.color::fg::bright_green "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::bright_yellow

#### Example

```bash
@install.color::fg::bright_yellow "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::bright_blue

#### Example

```bash
@install.color::fg::bright_blue "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::bright_magenta

#### Example

```bash
@install.color::fg::bright_magenta "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::bright_cyan

#### Example

```bash
@install.color::fg::bright_cyan "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::fg::bright_white

#### Example

```bash
@install.color::fg::bright_white "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::bright_black

#### Example

```bash
@install.color::bg::bright_black "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::bright_red

#### Example

```bash
@install.color::bg::bright_red "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::bright_green

#### Example

```bash
@install.color::bg::bright_green "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::bright_yellow

#### Example

```bash
@install.color::bg::bright_yellow "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::bright_blue

#### Example

```bash
@install.color::bg::bright_blue "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::bright_magenta

#### Example

```bash
@install.color::bg::bright_magenta "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::bright_cyan

#### Example

```bash
@install.color::bg::bright_cyan "text"
```

#### Exit codes

* Always 0.

#### See also

* [@install.color::wrap](#installcolorwrap)

### @install.color::bg::bright_white

#### Example

```bash
@install.color::bg::bright_white "example"
```

#### Exit codes

* Always 0.

### @install.color::accent

#### Example

```bash
@install.color::accent "heading"
```

#### Exit codes

* Always 0.

#### Output on stdout

* Decorated text.

#### See also

* [@install.color::wrap](#installcolorwrap)

