ini_load .algo_owls.ini

if [[ -z ${args[--no_build]} || ${args[--no_build]} -eq 0 ]]; then
    if [[ ${ini[settings.auto_build]} == true ]]; then
        ./algo_owls build ${args[solution]}
    elif [[ -n ${args[--build]} && ${args[--build]} -eq 1 ]]; then
        ./algo_owls build ${args[solution]}
    fi
fi

target_name="$(to_snake_case ${args[solution]})"
target_dir="$(find ${ini[options.tests_dir]} -type d -name $target_name)"

if [[ -z $target_dir ]]; then
    target_dir="$(fmt_dir ${ini[options.tests_dir]})**/$target_name/"
    echo "algo_owls: $target_dir: No such directory" 1>&2
    target_dir="$(fmt_dir ${ini[options.tests_dir]})$target_name"
    echo "Try using: mkdir -p $target_dir" 1>&2
    exit 1
fi

file_ext="$(handle_file_ext)"

run_cmd="./algo_owls run ${args[solution]} --quiet --no_build"
if [[ -n ${args[--ext]} ]]; then
    run_cmd="$run_cmd --ext ${args[--ext]}"
elif [[ -n ${args[--no_ext]} ]]; then
    run_cmd="$run_cmd --no_ext"
fi

in_ext="${ini[settings.in_ext]}"
if [[ -n ${args[--in_ext]} ]]; then
    in_ext="${args[--in_ext]}"
fi
in_ext="$(dot_file_ext $in_ext)"

ans_ext="${ini[settings.ans_ext]}"
if [[ -n ${args[--ans_ext]} ]]; then
    ans_ext="${args[--ans_ext]}"
fi
ans_ext="$(dot_file_ext $ans_ext)"

all_tests_pass=true
for in_file in $(find $target_dir -name "*$in_ext"); do
    ans_file="${in_file%.*}$ans_ext"
    if diff -u --suppress-common-lines --label $ans_file --label ${args[solution]} --strip-trailing-cr -d --speed-large-files --color $ans_file <((eval $run_cmd) < $in_file); then
        echo -e "\033[0;32m$in_file aye!\033[0m"
    else
        echo -e "\033[0;31m$in_file nay!\033[0m"
        all_tests_pass=false
        if [[ -z ${args[--all]} || ${args[--all]} -eq 0 ]]; then
            break
        fi
    fi
done

echo ""

if [[ $all_tests_pass == true ]]; then
    echo -e "\033[0;32m${args[solution]} passes!\033[0m"
else
    echo -e "\033[0;31m${args[solution]} vetoed!\033[0m"
fi
