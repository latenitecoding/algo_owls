ini_load .algo_owls.ini

file_ext="$(handle_file_ext)"

solution_file="${args[solution]}"
if [[ -n $file_ext && -n ${args[--ext]} ]]; then
    solution_file="$solution_file$file_ext"
elif [[ -z ${args[--no_ext]} || ${args[--no_ext]} -eq 0 ]]; then
    if [[ -n ${ini[build.file_ext]} ]]; then
        file_ext="${ini[build.file_ext]}"
        if [[ -n $file_ext && ${file_ext:0:1} != "." ]]; then
            file_ext=".$file_ext"
        fi
    fi
    if [[ -n $file_ext && ${ini[build.no_ext]} == false ]]; then
        solution_file="$solution_file$file_ext"
    fi
fi

target_file="$(find ${ini[options.solutions_dir]} -name $solution_file)"

if [[ -z $target_file ]]; then
    echo "algo_owls: $solution_file: No such file or directory" 1>&2
    target_file="${ini[options.solutions_dir]}/${args[solution]}"
    echo "Try using: ./algo_owls init $target_file" 1>&2
    exit 1
fi

build_cmd="${ini[build.cmd]}"
if [[ -n ${args[--build_cmd]} ]]; then
    build_cmd="${args[--build_cmd]}"
fi

if [[ -n ${args[--build_flags]} ]]; then
    build_cmd="$build_cmd ${args[--build_flags]}"
else
    for key in "${!ini[@]}"; do
        if [[ $key == build_flags.* ]]; then
            build_cmd="$build_cmd ${ini[$key]}"
        fi
    done
fi

if [[ -n ${args[--build_out]} ]]; then
    build_cmd="$build_cmd ${args[--build_out]}"
fi

if [[ -n ${args[--build_sources]} ]]; then
    build_sources="${args[--build_sources]}"
    if [[ -n ${args[--local]} && ${args[--local]} -eq 1 ]]; then
        target_dir="${target_file%/*}"
        build_sources="${build_sources//.../$target_dir}"
    fi
    build_cmd="$build_cmd $build_sources"
fi

for key in "${!ini[@]}"; do
    if [[ $key == options.* ]]; then
        build_cmd="${build_cmd//$key/${ini[$key]}}"
    fi
done

build_cmd="$build_cmd $target_file"

eval $build_cmd
