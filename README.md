# linux-themer

A tool to customize the linux desktop environment

## About

Are you always changing your desktop's appearance based on your mood, experiment, or a random need for something different? ME TOO. I created this tool to quickly change some of the more common desktop environment theme settings. Moreover, adjusting these settings from command line is useful when you want to toggle between light and dark themes.

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

## Usage

```bash
Change desktop environment theme settings

Usage:
themer [--schema SCHEMADIR] COMMAND [ARGS]

Commands:
-h, --help      Show this information and exit
--get           Get the theme setting value
--set           Set the theme setting value
--reset         Reset the theme settings value
--schema        Installed schema
--list-schema   List installed desktop schema
--list-themes   List desktop themes

Settings:
icons           Icon theme
controls        Control button theme
windows         Window border theme
desktop         Desktop theme
cursor          Mouse pointer theme
```

### Examples

Below are some examples, as well as the equivalent `gsettings` command.

1) Change the icon theme

   ```bash
   # gsettings --set org.cinnamon.desktop.interface icon-theme "Mint-X"
   themer --set icons "Mint-X"
   ```

2) Change the window border theme

   ```bash
   # gsettings --set org.cinnamon.desktop.wm.preferences theme "Mint-Y-Dark"
   themer --set windows "Mint-Y-Dark"
   ```

3) Get the controls theme

   ```bash
   # gsettings --get org.cinnamon.desktop.interface gtk-theme
   themer --get controls
   ```

4) List available desktop themes

    ```bash
    themer --list-themes
    ```

## Contributing

## License

## Contact

Trevor Moon - trevor.r.moon@gmail.com
