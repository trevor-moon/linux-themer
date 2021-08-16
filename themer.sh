#! /bin/bash
#
# Change desktop environment theme settings

help() {
    echo "Change desktop environment theme settings"
    echo
    echo "Usage:"
    echo "  themer [--schema SCHEMADIR] COMMAND [ARGS]"
    echo
    echo "Commands:"
    echo "  -h, --help      Show this information and exit"
    echo "  --get           Get the theme setting value"
    echo "  --set           Set the theme setting value"
    echo "  --reset         Reset the theme settings value"
    echo "  --schema        Specify installed schema"
    echo "                  auto-detect uses 'DESKTOP_SESSION'"
    echo "  --list-schema   List installed desktop schema"
    echo "  --list-themes   List desktop themes"
    echo
    echo "Settings:"
    echo "  icons           Icon theme"
    echo "  controls        Control button theme"
    echo "  windows         Window border theme"
    echo "  desktop         Desktop theme"
    echo "  cursor          Mouse pointer theme"
}

# available themer settings
settings=(
    "icons"
    "controls"
    "windows"
    "desktop"
    "cursor"
)

theme_dirs=(
    ~/.themes/
    /usr/share/themes/
)

istheme() {
    for dir in ${theme_dirs[@]}; do
        if [ -d "$dir/$1" ]; then
            return 0
        fi
    done
    return 1
}

get_themes() {
    local themes
    for dir in ${theme_dirs[@]}; do
        themes="$themes $(ls $dir)"
    done
    echo "$themes"
}

list_themes() {
    for theme in $(get_themes); do
        echo $theme
    done
}

get_schemas() {
    echo $(gsettings list-schemas | grep "desktop.interface$" | awk -F ".desktop.interface" '{print $1}')
}

list_schemas() {
    for schema in $(get_schemas); do
        echo $schema
    done
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
            --schema)
                schema="$2"
                shift 2
                ;;
            --list-schema)
                list_schemas
                exit
                ;;
            --list-themes)
                list_themes
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

get_current_schema() {
    echo $(gsettings list-schemas | grep "$DESKTOP_SESSION$")
}

main() {
    # parse arguments/options
    parse_args "$@"

    # get current schema if not provided
    if [ -z $schema ]; then
        local schema=$(get_current_schema)
    fi

    # get gsetting key path and key name
    read key_path key_name < <(get_key_info "$key")

    # build gsetting command and run
    local str="$schema.$key_path $key_name"
    if [ $cmd == "get" ]; then
        gsettings get $str
    else
        gsettings set $str $key_val
    fi
}

main "$@"
