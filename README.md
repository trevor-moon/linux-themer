# linux-themer

A tool to customize the linux desktop environment

## About

This is a lightweight wrapper of the `gsettings` utility to quickly tweak linux desktop environment theme settings (e.g., icon themes).

### Motivation

Are you always changing your desktop's appearance based on your mood, experimenting with various designs, or a random need for something different? ME TOO. I created this tool to quickly change some of the more common desktop environment theme settings. Ultimately, adjusting these settings from command line is useful when you want to toggle between light and dark themes or generate configuration files.

Another motivation for this utility is to tweak theme settings without the long path and key names needed in `gsettings` - the built-in utility for tweaking. A table of `gsetting` commands and their equivalent in `themer`  are shown below.

| Theme setting  | `gsetting` path key              | `themer`   |
|----------------|----------------------------------|------------|
| Icons          | `desktop.interface icon-theme`   | `icons`    |
| Controls       | `desktop.interface gtk-theme`    | `controls` |
| Window Borders | `desktop.wm.preferences theme`   | `windows`  |
| Desktop        | `theme name`                     | `desktop`  |
| Mouse pointer  | `desktop.interface cursor-theme` | `cursor`   |

See the [Usage](#usage) and [Examples](#examples) on how to use this utility.

## Getting started

### Installation

- Install *themer*

```bash
$ git clone https://github.com/trevor-moon/linux-themer.git
$ cd linux-themer
$ sudo install makefile
```

## Usage

```bash
Change desktop environment theme settings

Usage:
  themer [OPTIONS]

Commands:
  -h, --help      Show this information and exit
  --get           Get the theme setting value
  --set           Set the theme setting value
  --reset         Reset the theme settings value
  --list-icons    List installed icons
  --list-themes   List installed themes

Settings:
  icons           Icon theme
  controls        Control button theme
  windows         Window border theme
  desktop         Desktop theme
  cursor          Mouse pointer theme
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

## Contact

Trevor Moon - trevor.r.moon@gmail.com
