fmt_dir() {
    target_dir="$1"

    if [[ ${target_dir:0:2} == "./" ]]; then
        target_dir="${target_dir:2}"
    fi

    if [[ ${target_dir: -1} != "/" ]]; then
        target_dir="$target_dir/"
    fi

    echo "$target_dir"
    return
}
