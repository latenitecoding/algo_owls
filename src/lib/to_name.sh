to_name() {
    local args_no_ext="${args[--no-ext]}"

    local filepath="$1"
    local basename="${filepath##*/}"

    if [[ -n $args_no_ext && $args_no_ext -eq 1 ]]; then
        basename="${basename%.*}"
    fi

    echo "$basename"
    return
}
