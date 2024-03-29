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
    echo "Try using: ./algo_owls init ${args[soluton]}" 1>&2
    exit 1
fi

if [[ -z ${args[--no-fmt]} || ${args[--no-fmt]} -eq 0 ]]; then
    if [[ ${ini[settings.auto_fmt]} == true ]]; then
        ./algo_owls fmt ${args[solution]}
    elif [[ -n ${args[--fmt]} && ${args[--fmt]} -eq 1 ]]; then
        ./algo_owls fmt ${args[solution]}
    fi
fi

echo "git add $target_file"
git add $target_file

commit_message="completes ${args[solution]}"
if [[ -n ${args[--message]} ]]; then
    commit_message="${args[--message]}"
fi

echo "git commit -m \"$commit_message\""
git commit -m "$commit_message"

branch="${ini[git.branch]}"
if [[ -n ${args[--branch]} ]]; then
    branch="${args[--branch]}"
fi

remote="${ini[git.remote]}"
if [[ -n ${args[--remote]} ]]; then
    remote="${args[--remote]}"
fi

echo "git push $remote $branch"
git push $remote $branch
