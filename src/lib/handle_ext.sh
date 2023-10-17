handle_ext() {
    local SETTINGS_EXT="${ini[settings.file_ext]}"
    local SETTINGS_NO_EXT="${ini[settings.no_ext]}"
    local ARGS_EXT="${args[--ext]}"
    local ARGS_NO_EXT="${args[--no_ext]}"

    if [[ -n $ARGS_NO_EXT && $ARGS_NO_EXT -eq 1 ]]; then
        echo ""
        return
    fi

    local EXT="$SETTINGS_EXT"

    if [[ -n $SETTINGS_NO_EXT && $SETTINGS_NO_EXT == true ]]; then
        EXT=""
    fi

    if [[ -n $ARGS_EXT ]]; then
        EXT="$ARGS_EXT"
    fi

    if [[ -n $EXT && ${EXT:0:1} != "." ]]; then
        EXT=".$EXT"
    fi

    echo "$EXT"
    return
}
