ini_load .algo_owls.ini

file_ext="$(handle_file_ext)"

solution_file="${args[solution]}"
if [[ "${solution_file##*.}" = "${solution_file%.*}" ]]; then
    # the solution file has no extension
    if [[ -n $file_ext ]]; then
        solution_file="$solution_file$file_ext"
    fi
elif [[ -n $file_ext ]]; then
    solution_file="${solution_file%.*}$file_ext"
else
    solution_file="${solution_file%.*}"
fi

if test -f $solution_file; then
    target_file=$solution_file
else
    target_file="$(find ${ini[options.solutions_dir]} -name $(to_name $solution_file))"
fi

if [[ -z $target_file ]]; then
    echo "algo_owls: $solution_file: No such file" 1>&2
    echo "Try using: ./algo_owls init ${args[solution]}" 1>&2
    exit 1
fi

build_cmd="${ini[build.cmd]}"
if [[ -n ${args[--build-cmd]} ]]; then
    build_cmd="${args[--build-cmd]}"
fi

if [[ -n ${args[--build-flags]} ]]; then
    build_cmd="$build_cmd ${args[--build-flags]}"
else
    for key in "${!ini[@]}"; do
        if [[ $key == build_flags.* ]]; then
            build_cmd="$build_cmd ${ini[$key]}"
        fi
    done
fi

if [[ -n ${args[--build-out]} ]]; then
    build_cmd="$build_cmd ${args[--build-out]}"
fi

if [[ -n ${args[--build-sources]} ]]; then
    build_sources="${args[--build-sources]}"
    if [[ -n ${args[--use-source]} && ${args[--use-source]} -eq 1 ]]; then
        target_dir="${target_file%/*}"
        build_sources="${build_sources//.../$target_dir}"
    elif [[ -n ${args[--use-name]} && ${args[--use-name]} -eq 1 ]]; then
        target_name="${target_file##*/}"
        target_name="${target_name%.*}"
        build_sources="${build_sources//.../$target_name}"
    fi
    build_cmd="$build_cmd $build_sources"
fi

for key in "${!ini[@]}"; do
    if [[ $key == options.* ]]; then
        build_cmd="${build_cmd//$key/${ini[$key]}}"
    fi
done

if [[ -z ${args[--build-sources]} && ${ini[build.use_source]} == true ]]; then
    target_dir="${target_file%/*}"
    build_cmd="${build_cmd//.../$target_dir}"
elif [[ -z ${args[--build-sources]} && ${ini[build.use_name]} == true ]]; then
    target_name="${target_file##*/}"
    target_name="${target_name%.*}"
    build_cmd="${build_cmd//.../$target_name}"
fi

build_cmd="$build_cmd $target_file"

if [[ -z ${args[--quiet]} || ${args[--quiet]} -eq 0 ]]; then
    echo $build_cmd
fi

if [[ -n ${args[--time]} && ${args[--time]} -eq 1 ]]; then
    time $build_cmd
else
    eval $build_cmd
fi
