handle_file_ext() {
    local settings_ext="${ini[settings.file_ext]}"
    local settings_no_ext="${ini[settings.no_ext]}"
    local args_ext="${args[--ext]}"
    local args_no_ext="${args[--no-ext]}"

    if [[ -n $args_no_ext && $args_no_ext -eq 1 ]]; then
        echo ""
        return
    fi

    local file_ext="$settings_ext"
    if [[ -n $settings_no_ext && $settings_no_ext == true ]]; then
        file_ext=""
    fi
    if [[ -n $args_ext ]]; then
        file_ext="$args_ext"
    fi

    echo "$(dot_file_ext $file_ext)"
    return
}
