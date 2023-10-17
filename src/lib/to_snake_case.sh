to_snake_case() {
    snake_case="$(echo $1 | sed -r 's/([a-z0-9])([A-Z])/\1_\L\2/g' | sed -e 's/\(.*\)/\L\1/')"
    echo $snake_case
    return
}
