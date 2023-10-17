ini_load .algo_owls.ini

key="tests.${args[solution]}"
data_file="${ini[$key]}"
if [[ -n ${args[--addr]} ]]; then
    data_file="${args[--addr]}"
fi

if [[ -z $data_file ]]; then
    echo "algo_owls: ${args[solution]}: No known address" 1>&2
    echo "Try using: ./algo_owls config set tests.${args[solution]}=ADDRESS" 1>&2
    exit 1
fi

data_ext="${data_file##*.}"
target_file="${ini[options.tests_dir]}/${args[solution]}.$data_ext"

echo "curl $data_file --output $target_file"
curl $data_file --output $target_file

if [[ -n ${args[--no_unzip]} && ${args[--no_unzip]} -eq 1 ]]; then
    exit 0
fi

target_dir="${ini[options.tests_dir]}/${args[solution]}/"

echo "unzip $target_file -d $target_dir"
unzip $target_file -d $target_dir

echo "rm $target_file"
rm $target_file

if [[ -n ${args[--in_ext]} ]]; then
    if [[ -n ${args[--map_in]} || ${args[--in_ext]} != ${ini[options.in_ext]} ]]; then
        file_ext="$(dot_file_ext ${args[--in_ext]})"

        for in_file in $(find $target_dir -name "*$file_ext"); do
            out_ext="${ini[options.in_ext]}"
            if [[ -n ${args[--map_in]} ]]; then
                out_ext="${args[--map_in]}"
            fi
            out_ext="$(dot_file_ext $out_ext)"

            out_file="${in_file%.*}$out_ext"

            echo "mv $in_file $out_file"
            mv $in_file $out_file
        done
    fi
fi

if [[ -n ${args[--ans_ext]} ]]; then
    if [[ -n ${args[--map_ans]} || ${args[--ans_ext]} != ${ini[options.ans_ext]} ]]; then
        file_ext="$(dot_file_ext ${args[--ans_ext]})"

        for ans_file in $(find $target_dir -name "*$file_ext"); do
            out_ext="${ini[options.ans_ext]}"
            if [[ -n ${args[--map_ans]} ]]; then
                out_ext="${args[--map_ans]}"
            fi
            out_ext="$(dot_file_ext $out_ext)"

            out_file="${ans_file%.*}$out_ext"

            echo "mv $ans_file $out_file"
            mv $ans_file $out_file
        done
    fi
fi
