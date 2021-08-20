#! /bin/bash
#
# Change desktop environment themes

help() {
    echo "Change desktop environment themes"
    echo
    echo "Usage:"
    echo "  themer COMMAND"
    echo
    echo "Commands:"
    echo "  -h, --help          Show this information and exit"
    echo "  --get <theme>       Get the theme value"
    echo "  --set <theme> <value> Set the theme value"
    echo "  --reset <theme>     Reset the theme value"
    echo "  --list-cursors      List installed cursors"
    echo "  --list-icons        List installed icons"
    echo "  --list-themes       List installed themes"
    echo
    echo "Themes:"
    echo "  icons               Icon theme"
    echo "  controls            Control button theme"
    echo "  windows             Window border theme"
    echo "  desktop             Desktop theme"
    echo "  cursor              Mouse pointer theme"
}

get_key_info() {
    case "$1" in
        icons)
            local key_path="desktop.interface"
            local key_name="icon-theme"
            ;;
        controls)
            local key_path="desktop.interface"
            local key_name="gtk-theme"
            ;;
        windows)
            local key_path="desktop.wm.preferences"
            local key_name="theme"
            ;;
        desktop)
            local key_path="theme"
            local key_name="name"
            ;;
        cursor)
            local key_path="desktop.interface"
            local key_name="cursor-theme"
            ;;
        *)
            echo "Unknown key '$1'"
            exit 1
            ;; 
    esac
    echo "$key_path $key_name"
}

parse_args() {
    while [ -n "$1" ]; do
        case "$1" in
            -h | --help)
                help
                exit
                ;;
            --get)
                key="$2"
                shift 2
                cmd="get"
                ;;
            --set)
                key="$2"
                key_val="$3"
                shift 3
                cmd="set"
                ;;
            --reset)
                key="$2"
                shift 2
                cmd="reset"
                ;;
            --list-cursors)
                print_cursors
                exit
                ;;
            --list-icons)
                print_icons
                exit
                ;;
            --list-themes)
                print_themes
                exit
                ;;
            *)
                echo "Unknown option '$1'"
                echo "See 'themer --help' for more information"
                exit
                ;;
        esac
    done
}

get_de() {
    if [ $XDG_CURRENT_DESKTOP ]; then
        local de=${XDG_CURRENT_DESKTOP/X\-}
    elif [ $DESKTOP_SESSION ]; then
        local de=$DESKTOP_SESSION
    fi
    echo "$(echo "$de" | tr '[:upper:]' '[:lower:]')"
}

get_schema_prefix() {
    local str=".desktop.interface"
    echo "$(gsettings list-schemas | grep -m 1 "$1$str$" | sed "s/$str//" )"
}

get_themes() {
    local themes=""
    for theme_dir in ${theme_dirs[@]}; do
        for dir in $(ls "$theme_dir"); do
            if is_theme_dir "$theme_dir/$dir"; then
                themes="$themes $dir"
            fi
        done
    done
    echo "$themes"
}

is_theme_dir() {
    [ -f "$1/index.theme" ]
}

get_icons() {
    local icons=""
    for icon_dir in ${icon_dirs[@]}; do
        for dir in $(ls "$icon_dir"); do
            if is_icon_dir "$icon_dir/$dir"; then
                icons="$icons $dir"
            fi
        done
    done
    echo "$icons"
}

is_icon_dir() {
    [ -f "$1/index.theme" ] && [ ! -d "$1/cursors" ]
}


is_cursor_dir() {
    [ -f "$1/index.theme" ] && [ -d "$1/cursors" ]
}

get_cursors() {
    local cursors=""
    for icon_dir in ${icon_dirs[@]}; do
        for dir in $(ls "$icon_dir"); do
            if is_cursor_dir "$icon_dir/$dir"; then
                cursors="$cursors $dir"
            fi
        done
    done
    echo "$cursors"
}

print_themes() {
    printf "%s\n" $(get_themes) | sort -u
}

print_icons() {
    printf "%s\n" $(get_icons) | sort -u
}

print_cursors() {
    printf "%s\n" $(get_cursors) | sort -u
}

main() {
    # installed theme directories
    theme_dirs=(
        /usr/share/themes
        ~/.themes
    )

    # installed icon/cursor directories
    icon_dirs=(
        /usr/share/icons
        ~/.icons
    )

    # parse arguments/options
    parse_args "$@"

    # get the desktop environment
    local de=$(get_de)

    # get the schema path prefix (e.g., org.cinnamon) from the desktop environment
    local schema_prefix=$(get_schema_prefix "$de")

    # get the full schema path
    local key_path key_name
    read key_path key_name < <(get_key_info "$key")
    local schema="$schema_prefix.$key_path"

    # run command to get/set/reset theme setting
    if [ $cmd == "get" ]; then
        gsettings get $schema $key_name
    elif [ $cmd == "set" ]; then
        gsettings set $schema $key_name $key_val
    elif [ $cmd == "reset" ]; then
        gsettings reset $schema $key_name
    fi
}

main "$@"
