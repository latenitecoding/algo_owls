dot_file_ext() {
    file_ext="$1"

    if [[ -n $file_ext && ${file_ext:0:1} != "." ]]; then
        file_ext=".$file_ext"
    fi

    echo "$file_ext"
    return
}
