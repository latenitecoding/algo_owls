ini_load .algo_owls.ini

if [[ -z ${args[--no_build]} || ${args[--no_build]} -eq 0 ]]; then
    if [[ ${ini[settings.auto_build]} == true ]]; then
        ./algo_owls build ${args[solution]}
    elif [[ -n ${args[--build]} && ${args[--build]} -eq 1 ]]; then
        ./algo_owls build ${args[solution]}
    fi
fi

target_dir="$(find ${ini[options.tests_dir]} -type d -name ${args[solution]})"

if [[ -z $target_dir ]]; then
    target_dir="${ini[options.tests_dir]}/**/${args[solution]}/"
    echo "algo_owls: $target_dir: No such directory" 1>&2
    target_dir="${ini[options.tests_dir]}/${args[solution]}"
    echo "Try using: mkdir -p $target_dir" 1>&2
    exit 1
fi

file_ext="$(handle_file_ext)"

solution_file="${args[solution]}"
if [[ -n $file_ext ]]; then
    solution_file="$solution_file$file_ext"
fi

run_cmd="./algo_owls run ${args[solution]}"
if [[ -n ${args[--ext]} ]]; then
    run_cmd="$run_cmd --ext ${args[--ext]}"
fi

all_tests_pass=true
for in_file in $(find $target_dir -name "*.in"); do
    ans_file="${in_file%.*}.ans"
    if diff -u --suppress-common-lines --label $ans_file --label $solution_file --strip-trailing-cr -d --speed-large-files --color $ans_file <(eval $run_cmd < $in_file); then
        echo -e "\033[0;32m$in_file aye!\033[0m"
    else
        echo -e "\033[0;31m$in_file nay!\033[0m"
        all_tests_pass=false
    fi
done

echo ""

if [[ $all_tests_pass == true ]]; then
    echo -e "\033[0;32m$solution_file passes!\033[0m"
else
    echo -e "\033[0;31m$solution_file vetoed!\033[0m"
fi
