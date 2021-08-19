#! /bin/bash
#
# Change desktop environment theme settings

help() {
    echo "Change desktop environment theme settings"
    echo
    echo "Usage:"
    echo "  themer [OPTIONS]"
    echo
    echo "Commands:"
    echo "  -h, --help      Show this information and exit"
    echo "  --get           Get the theme setting value"
    echo "  --set           Set the theme setting value"
    echo "  --reset         Reset the theme settings value"
    echo "  --list-themes   List installed themes"
    echo
    echo "Settings:"
    echo "  icons           Icon theme"
    echo "  controls        Control button theme"
    echo "  windows         Window border theme"
    echo "  desktop         Desktop theme"
    echo "  cursor          Mouse pointer theme"
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

print_themes() {
    printf "%s\n" $(get_themes) | sort -u
}

# parse main progam arguments
parse_args() {
    while [[ -n "$1" ]]; do
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

# get installed icons
get_icons() {
    local icon_themes=""
    for icon_dir in ${icon_dirs[@]}; do
        for dir in $(ls "$icon_dir"); do
            if is_icon_dir "$icon_dir/$dir"; then
                icon_themes="$icon_themes $dir"
            fi
        done
    done
    echo "$icon_themes"
}

# is installed icon directory
is_icon_dir() {
    [[ -f "$1/index.theme" ]]
}

# get installed themes
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

# is installed theme
is_theme() {
    echo "$( echo $(get_themes) | grep -w "$1")"
}

# check for installed theme directories
is_theme_dir() {
    [[ -f "$1/index.theme" ]]
}

# get desktop environment
get_de() {
    if [[ $XDG_CURRENT_DESKTOP ]]; then
        local de=${XDG_CURRENT_DESKTOP/X\-}
    elif [[ $DESKTOP_SESSION ]]; then
        local de=$DESKTOP_SESSION
    fi
    echo "$(echo "$de" | tr '[:upper:]' '[:lower:]')"
}

# get desktop environment schema prefix (e.g., org.cinnamon)
get_schema_prefix() {
    local str=".desktop.interface"
    echo "$(gsettings list-schemas | grep -m 1 "$1$str$" | sed "s/$str//" )"
}

main() {
    theme_dirs=(
        /usr/share/themes
        ~/.themes
    )

    icon_dirs=(
        /usr/share/icons
        ~/.icons
    )

    # parse arguments/options
    parse_args "$@"

    # get the desktop environment
    local de=$(get_de)

    # get the schema path prefix from the desktop environment
    local schema_prefix=$(get_schema_prefix "$de")

    # get the full schema path
    local key_path key_name
    read key_path key_name < <(get_key_info "$key")
    local schema="$schema_prefix.$key_path"

    # run command to get/set theme setting
    if [[ $cmd == "get" ]]; then
        gsettings get $schema $key_name
    elif [[ $cmd == "set" ]]; then
        gsettings set $schema $key_name $key_val
    elif [[ $cmd == "reset" ]]; then
        gsettings reset $schema $key_name
    fi
}

main "$@"
