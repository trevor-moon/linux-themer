# linux-themer

A tool to customize the linux desktop environment

- [linux-themer](#linux-themer)
  - [About](#about)
    - [Why themer?](#why-themer)
    - [Motivation](#motivation)
  - [Getting started](#getting-started)
    - [Install](#install)
    - [Uninstall](#uninstall)
  - [Usage](#usage)
    - [Examples](#examples)
  - [Contributing](#contributing)
  - [License](#license)
  - [Contact](#contact)

## About

This is a lightweight wrapper of the `gsettings` utility to quickly tweak linux desktop environment theme settings (e.g., icon themes).

### Why themer?

- No need to memorize long path and key names
- Quick access to common desktop environment settings
- Auto-detection of running desktop environment

### Motivation

Are you always changing your desktop's appearance based on your mood, experimenting with various designs, or a random need for something different? I created this tool to quickly change some of the more common desktop environment theme settings from the command line. For example, changing themes based on the time of day or quickly toggle between light and dark themes should be easy and intuitive. However, memorizing long `gsettings` schemas and keys is bothersome. So, *themer* was created to be a wrapper to easily tweak theme settings without the long path and key names.

A table of `gsetting` commands and their equivalent in `themer`  are shown below.

| Theme          | `gsetting` key schema    | `gsetting` key | `themer` key |
|----------------|--------------------------|----------------|--------------|
| Icons          | `desktop.interface`      | `icon-theme`   | `icons`      |
| Controls       | `desktop.interface`      | `gtk-theme`    | `controls`   |
| Window Borders | `desktop.wm.preferences` | `theme`        | `windows`    |
| Desktop        | `theme`                  | `name`         | `desktop`    |
| Mouse pointer  | `desktop.interface`      | `cursor-theme` | `cursor`     |

See the [Usage](#usage) and [Examples](#examples) on how to use.

## Getting started

### Install

```bash
$ git clone https://github.com/trevor-moon/linux-themer.git
$ cd linux-themer
$ sudo make install
```

### Uninstall

```bash
$ sudo make uninstall
```

## Usage

```bash
Change desktop environment themes

Usage:
  themer.sh COMMAND

Commands:
  -h, --help          Show this information and exit
  -v, --version       Show version information and exit
  --get <theme>       Get the theme value
  --set <theme> <value> Set the theme value
  --reset <theme>     Reset the theme value
  --list-cursors      List installed cursors
  --list-icons        List installed icons
  --list-themes       List installed themes

Themes:
  icons               Icon theme
  controls            Control button theme
  windows             Window border theme
  desktop             Desktop theme
  cursor              Mouse pointer theme
```

### Examples

Below are some examples, as well as the equivalent `gsettings` command.

1) Change the icon theme

   ```bash
   # gsettings --set org.cinnamon.desktop.interface icon-theme "Mint-X"
   $ themer.sh --set icons "Mint-X"
   ```

2) Change the window border theme

   ```bash
   # gsettings --set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark"
   $ themer.sh --set windows "Mint-Y-Dark"
   ```

3) Get the controls theme

   ```bash
   # gsettings --get org.cinnamon.desktop.interface gtk-theme
   $ themer.sh --get controls
   ```

4) List available desktop themes

    ```bash
    $ themer.sh --list-themes
    ```

## Contributing

For contributing to this project, see [CONTRIBUTING][contributing].

## License

See [LICENSE][license] for more information.

## Contact

Trevor Moon - trevor.r.moon@gmail.com

<!-- links -->
[contributing]: CONTRIBUTING.md
[license]: src/LICENSE
