#!/bin/bash
#
# Auto update themer version

main() {
    program="themer"
    script="$program.sh"
    new_version="$program $(git describe --abbrev=0 --tags)\""
    current_version=$(grep -oP "$program\sv.*" "$script")
    sed -i "s/$current_version/$new_version/" "$script"
}

main "$@"
