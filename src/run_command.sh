ini_load .algo_owls.ini

if [[ -z ${args[--no-build]} || ${args[--no-build]} -eq 0 ]]; then
    if [[ ${ini[settings.auto_build]} == true ]]; then
        ./algo_owls build ${args[solution]}
    elif [[ -n ${args[--build]} && ${args[--build]} -eq 1 ]]; then
        ./algo_owls build ${args[solution]}
    fi
fi

file_ext="$(handle_file_ext)"

solution_file="${args[solution]}"
if [[ -n $file_ext && -n ${args[--ext]} ]]; then
    solution_file="$solution_file$file_ext"
elif [[ -z ${args[--no-ext]} || ${args[--no-ext]} -eq 0 ]]; then
    if [[ ${ini[run.file_ext]} != false ]]; then
        file_ext="$(dot_file_ext ${ini[run.file_ext]})"
    fi
    if [[ -n $file_ext && ${ini[run.no_ext]} == false ]]; then
        solution_file="$solution_file$file_ext"
    fi
fi

if [[ -n ${args[--use-source]} && ${args[--use-source]} -eq 1 ]]; then
    target_file="$(find ${ini[options.solutions_dir]} -name $solution_file)"
else
    target_file="$(find ${ini[options.target_dir]} -name $solution_file)"
fi

if [[ -z $target_file ]]; then
    echo "algo_owls: $solution_file: No such file" 1>&2
    echo "Try using: ./algo_owls init ${args[solution]}" 1>&2
    exit 1
fi

run_cmd="${ini[run.cmd]}"
if [[ -n ${args[--run-cmd]} ]]; then
    run_cmd="${args[--run-cmd]}"
fi

if [[ -n ${args[--run-flags]} ]]; then
    run_cmd="$run_cmd ${args[--run-flags]}"
else
    for key in "${!ini[@]}"; do
        if [[ $key == run_flags.* ]]; then
            run_cmd="$run_cmd ${ini[$key]}"
        fi
    done
fi

if [[ -n ${args[--run-sources]} ]]; then
    run_sources="${args[--run-sources]}"
    if [[ -n ${args[--local]} && ${args[--local]} -eq 1 ]]; then
        target_dir="${target_file%/*}"
        run_sources="${run_sources//.../$target_dir}"
    elif [[ -n ${args[--use-source]} && ${args[--use-source]} -eq 1 ]]; then
        target_dir="${target_file%/*}"
        run_sources="${run_sources//.../$target_dir}"
    fi
    run_cmd="$run_cmd $run_sources"
fi

for key in "${!ini[@]}"; do
    if [[ $key == options.* ]]; then
        run_cmd="${run_cmd//$key/${ini[$key]}}"
    fi
done

if [[ ${ini[run.local]} == true ]]; then
    target_dir="${target_file%/*}"
    run_cmd="${run_cmd//.../$target_dir}"
elif [[ ${ini[run.use_source]} == true ]]; then
    target_dir="${target_file%/*}"
    run_cmd="${run_cmd//.../$target_dir}"
fi

if [[ -n ${args[--name-only]} && ${args[--name-only]} -eq 1 ]]; then
    target_file="${args[solution]}"
elif [[ ${ini[run.name_only]} == true ]]; then
    target_file="${args[solution]}"
fi

run_cmd="$run_cmd $target_file"

if [[ -z ${args[--quiet]} || ${args[--quiet]} -eq 0 ]]; then
    echo $run_cmd
fi

eval $run_cmd
