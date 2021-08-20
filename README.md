# linux-themer

A tool to customize the linux desktop environment

## About

This is a lightweight wrapper of the `gsettings` utility to quickly tweak linux desktop environment theme settings (e.g., icon themes).

### Motivation

Are you always changing your desktop's appearance based on your mood, experimenting with various designs, or a random need for something different? I created this tool to quickly change some of the more common desktop environment theme settings from the command line. For example, I may want to change themes based on the time of day or quickly toggle between light and dark themes. However, memorizing long `gsettings` schemas and keys is bothersome, hence, another motivation is to tweak theme settings without the long path and key names.

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

### Installation

```bash
$ git clone https://github.com/trevor-moon/linux-themer.git
$ cd linux-themer
$ sudo make install
```

### Uninstallation

```bash
$ sudo make uninstall
```

## Usage

```bash
Change desktop environment themes

Usage:
  themer COMMAND

Commands:
  -h, --help          Show this information and exit
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

One thing to note is that the `--schema` arg is an *optional* command. If not provided, the program uses the *DESKTOP_SESSION* variable to get the session's desktop environment. To view the current value, run

```bash
$ echo $DESKTOP_SESSION
```

The result is used to find an installed desktop schema before proceeding.

### Examples

Below are some examples, as well as the equivalent `gsettings` command.

1) Change the icon theme

   ```bash
   # gsettings --set org.cinnamon.desktop.interface icon-theme "Mint-X"
   $ themer --set icons "Mint-X"
   ```

2) Change the window border theme

   ```bash
   # gsettings --set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark"
   $ themer --set windows "Mint-Y-Dark"
   ```

3) Get the controls theme

   ```bash
   # gsettings --get org.cinnamon.desktop.interface gtk-theme
   $ themer --get controls
   ```

4) List available desktop themes

    ```bash
    $ themer --list-themes
    ```

## Contributing

For contributing to this project, see [CONTRIBUTING](Contributing.md).

## License

See [LICENSE](LICENSE) for more information

## Contact

Trevor Moon - trevor.r.moon@gmail.com
