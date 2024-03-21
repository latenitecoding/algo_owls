handle_file_ext() {
    local settings_ext="${ini[settings.file_ext]}"
    local args_ext="${args[--ext]}"
    local args_no_ext="${args[--no-ext]}"

    if [[ -n $args_no_ext && $args_no_ext -eq 1 ]]; then
        echo ""
        return
    fi

    local file_ext="$settings_ext"
    if [[ -z $settings_ext || $settings_ext == false ]]; then
        file_ext=""
    fi

    if [[ -n $args_ext ]]; then
        file_ext="$args_ext"
    fi

    if [[ -z $file_ext ]]; then
        echo ""
        return
    fi

    echo "$(dot_file_ext $file_ext)"
    return
}
