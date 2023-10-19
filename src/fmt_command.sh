ini_load .algo_owls.ini

file_ext="$(handle_file_ext)"

solution_file="${args[solution]}"
if [[ -n $file_ext ]]; then
    solution_file="$solution_file$file_ext"
fi

target_file="$(find ${ini[options.solutions_dir]} -name $solution_file)"

if [[ -z $target_file ]]; then
    echo "algo_owls: $solution_file: No such file" 1>&2
    echo "Try using: ./algo_owls init ${args[solution]}" 1>&2
    exit 1
fi

fmt_cmd="${ini[fmt.cmd]}"
if [[ -n ${args[--fmt-cmd]} ]]; then
    fmt_cmd="${args[--fmt-cmd]}"
fi

if [[ -n ${args[--fmt-flags]} ]]; then
    fmt_cmd="$fmt_cmd ${args[--fmt-flags]}"
else
    for key in "${!ini[@]}"; do
        if [[ $key == fmt_flags.* ]]; then
            fmt_cmd="$fmt_cmd ${ini[$key]}"
        fi
    done
fi

for key in "${!ini[@]}"; do
    if [[ $key == options.* ]]; then
        fmt_cmd="${fmt_cmd//$key/${ini[$key]}}"
    fi
done

fmt_cmd="$fmt_cmd $target_file"

echo "$fmt_cmd"
eval $fmt_cmd
