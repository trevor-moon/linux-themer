#! /bin/bash
#
# Change desktop environment theme settings

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
    echo "                  auto-detect uses '$DESKTOP_SESSION'"
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

istheme() {
    for dir in ${theme_dirs[@]}; do
        if [ -d "$dir/$1" ]; then
            return 0
        fi
    done

    return 1
}

list_themes() {
    for dir in ${theme_dirs[@]}; do
        ls -1 $dir
    done
}

list_schemas() {
    printf "%s\n" $(gsettings list-schemas | grep "desktop.interface$" | awk -F ".desktop.interface" '{print $1}')
}

main() {
    while [[ -n "$1" ]]; do
        case "$1" in
            -h | --help)
                help
                exit
                ;;
            --get | --reset)
                setting="$2"
                shift 2
                cmd="get"
                # return
                ;;
            --set)
                setting="$2"
                setting_val="$3"
                shift 3
                cmd="set"
                # return
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

    # find schema path
    local schema_path=$(gsettings list-schemas | grep "$DESKTOP_SESSION$")

    # find key path and key name
    local key_path
    local key_name
    read key_path key_name < <(get_key_info "$setting")

    # print to screen
    echo "schema path: $schema_path"
    echo "key path: $key_path"
    echo "key name: $key_name"
    
    # get full path and key info
    local stuff="$schema_path.$key_path $key_name"
    echo "path and key: $stuff"

    # get 'get' or 'set' command
    if [ $cmd == "get" ]; then
        gsettings get $stuff
    else
        gsettings set $stuff $setting_val
    fi
}

get_key_info() {
    case "$setting" in
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
    esac
    echo "$key_path $key_name"
}

# print_settings() {
#     echo "Settings:"
#     echo "  icons           Icon theme"
#     echo "  controls        Control button theme"
#     echo "  windows         Window border theme"
#     echo "  desktop         Desktop theme"
#     echo "  cursor          Mouse pointer theme"
# }

# parse_options() {
#     while [[ -n "$1" ]]; do
#         case "$1" in
#             -h | --help)
#                 help
#                 exit
#                 ;;
#             --get | --reset)
#                 setting="$2"
#                 shift 2
#                 # return
#                 ;;
#             --set)
#                 setting="$2"
#                 setting_val="$3"
#                 shift 3
#                 # return
#                 ;;
#             --schema)
#                 schema="$2"
#                 shift 2
#                 ;;
#             --list-schema)
#                 printf "%s\n" $(gsettings list-schemas | grep "desktop.interface")
#                 exit
#                 ;;
#             *)
#                 echo "Unknown option '$1'"
#                 echo "See 'themer --help' for more information"
#                 exit
#                 ;;
#         esac
#     done
# }

# set_key_value() {
#     gsettings set $(get_key_path "$schema" "$setting") $(get_key_name "$setting") "$setting_val"
# }

# get_key_value() {
#     gsettings get $(get_key_path "$schema" "$setting") $(get_key_name "$setting")
# }

# get_key_name() {
#     case "$1" in
#         icons)      local key="icon-theme";;
#         controls)   local key="gtk-theme";;
#         windows)    local key="theme";;
#         desktop)    local key="name";;
#         cursor)     local key="cursor-theme";;
#     esac
#     echo "$key"
# }

# get_key_path() {
#     case "$1" in
#         icons)      local path="desktop.interface";;
#         controls)   local path="desktop.interface";;
#         windows)    local path="desktop.wm.preferences";;
#         desktop)    local path="theme";;
#         cursor)     local path="desktop.interface";;
#     esac

#     local schema_path=$(get_schema_path "$schema")

#     echo "$path"
# }

# get_schema_path() {
#     local schem=$(gsettings list-schemas | grep "$DESKTOP_SESSION$")
#     if 
# }

# get_schema_key_path() {
#     local key_path=$(get_key_path "$2")
#     local schemadir=$(get_schema_path "$1")
#     echo "$schemadir.$key_path"
# }

# get_key_value() {
#     local value=$(gsettings get $(get_schema_key_path "$schema" "$key") $key)
#     echo "$value"
# }

# set_key_value() {
#     gsettings set $(get_schema_key_path "$schema" "$key") $value
# }

# main() {
#     parse_options "$@"
# }

# # main() {
# #     # parse_options "$@"

# #     parse_args "$@"
# #     if [ $cmd == "get" ]; then
# #         echo "getting value"
# #         local path=$(get_schema_key_path "$schema" "$key")
# #         local key_name=$(get_key_name "$key")
# #         local value=$(gsettings get $path $key_name)
# #         echo "$value"
# #     elif [ $cmd == "set" ]; then
# #         echo "setting value"
# #     fi
# # }

main "$@"
