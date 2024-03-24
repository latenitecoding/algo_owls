ini_load .algo_owls.ini

if [[ -z ${args[--no-build]} || ${args[--no-build]} -eq 0 ]]; then
    build_args=""
    if [[ -n ${args[--quiet]} && ${args[--quiet]} -eq 1 ]]; then
        build_args="$build_args --quiet"
    fi
    if [[ -n ${args[--time]} && ${args[--time]} -eq 1 ]]; then
        build_args="$build_args --time"
    fi

    if [[ ${ini[settings.auto_build]} == true ]]; then
        ./algo_owls build ${args[solution]} $build_args
    elif [[ -n ${args[--build]} && ${args[--build]} -eq 1 ]]; then
        ./algo_owls build ${args[solution]} $build_args
    fi
fi

file_ext="$(handle_file_ext)"

solution_file="${args[solution]}"
if [[ "${solution_file##*.}" = "${solution_file%.*}" ]]; then
    # the solution file has no extension
    if [[ -z ${args[--no-ext]} || ${args[--no-ext]} -eq 0 ]]; then
        if [[ -n $file_ext && -n ${args[--ext]} && ${args[--ext]} -eq 1 ]]; then
            solution_file="$solution_file$file_ext"
        elif [[ -n ${ini[run.file_ext]} && ${ini[run.file_ext]} != false ]]; then
            file_ext="$(dot_file_ext ${ini[run.file_ext]})"
            if [[ -n $file_ext ]]; then
                solution_file="$solution_file$file_ext"
            fi
        fi
    fi
elif [[ -n ${args[--no-ext]} && ${args[--no-ext]} -eq 1 ]]; then
    solution_file="${solution_file%.*}"
elif [[ -n $file_ext && -n ${args[--ext]} ]]; then
    solution_file="${solution_file%.*}$file_ext"
elif [[ -z ${ini[run.file_ext]} || ${ini[run.file_ext]} == false ]]; then
    solution_file="${solution_file%.*}"
elif [[ -n ${ini[run.file_ext]} && ${ini[run.file_ext]} != false ]]; then
    file_ext="$(dot_file_ext ${ini[run.file_ext]})"
    if [[ -n $file_ext ]]; then
        solution_file="$solution_file$file_ext"
    else 
        solution_file="${solution_file%.*}"
    fi
elif [[ -n $file_ext ]]; then
    solution_file="$solution_file$file_ext"
else
    solution_file="${solution_file%.*}"
fi

if test -f $solution_file; then
    if [[ -n ${args[--use-source]} && ${args[--use-source]} -eq 1 ]]; then
        target_file=$solution_file
    elif [[ ${ini[run.use_source]} == true ]]; then
        target_file=$solution_file
    else
        target_file="$(find ${ini[options.target_dir]} -name $(to_name $filename))"
    fi
elif [[ -n ${args[--use-source]} && ${args[--use-source]} -eq 1 ]]; then
    target_file="$(find ${ini[options.solutions_dir]} -name $(to_name $solution_file))"
elif [[ ${ini[run.use_source]} == true ]]; then
    target_file="$(find ${ini[options.solutions_dir]} -name $(to_name $solution_file))"
else
    target_file="$(find ${ini[options.target_dir]} -name $(to_name $solution_file))"
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

exe_run=false
if [[ -z $run_cmd || $run_cmd == false || "$run_cmd" = "." || "$run_cmd" = "./" ]]; then
    run_cmd=""
    exe_run=true
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
    if [[ -n ${args[--use_target]} && ${args[--use_target]} -eq 1 ]]; then
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

if [[ ${ini[run.use_target]} == true ]]; then
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

if [[ $exe_run == true ]]; then
    run_cmd="$target_file$run_cmd"
else
    run_cmd="$run_cmd $target_file"
fi

if [[ -z ${args[--quiet]} || ${args[--quiet]} -eq 0 ]]; then
    echo $run_cmd
fi

if [[ -n ${args[--time]} && ${args[--time]} -eq 1 ]]; then
    time $run_cmd
else
    eval $run_cmd
fi
