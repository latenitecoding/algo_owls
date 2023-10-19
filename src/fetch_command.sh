ini_load .algo_owls.ini

solution="$(to_snake_case ${args[solution]})"

key="tests.$solution"
data_file="${ini[$key]}"
if [[ -n ${args[--addr]} ]]; then
    data_file="${args[--addr]}"
fi

if [[ -z $data_file ]]; then
    echo "algo_owls: ${args[solution]}: No known address" 1>&2
    echo "Try using: ./algo_owls config set $key=ADDRESS" 1>&2
    exit 1
fi

data_ext="${data_file##*.}"
target_file="$(fmt_dir ${ini[options.tests_dir]})$solution.$data_ext"

echo "curl $data_file --output $target_file"
curl $data_file --output $target_file

if [[ -n ${args[--no-unzip]} && ${args[--no-unzip]} -eq 1 ]]; then
    exit 0
fi

target_dir="$(fmt_dir ${ini[options.tests_dir]})$solution/"

if [[ $data_ext == "zip" ]]; then
    mkdir -p $target_dir
    echo "unzip $target_file -d $target_dir"
    unzip $target_file -d $target_dir
elif [[ $data_ext == "tgz" ]]; then
    mkdir -p $target_dir
    echo "tar xf $target_file --directory=$target_dir"
    tar xvf $target_file --directory=$target_dir
fi

echo "rm $target_file"
rm $target_file

if [[ -n ${args[--in-ext]} ]]; then
    if [[ -n ${args[--map-in]} || ${args[--in-ext]} != ${ini[options.in_ext]} ]]; then
        file_ext="$(dot_file_ext ${args[--in-ext]})"

        for in_file in $(find $target_dir -name "*$file_ext"); do
            out_ext="${ini[options.in_ext]}"
            if [[ -n ${args[--map-in]} ]]; then
                out_ext="${args[--map-in]}"
            fi
            out_ext="$(dot_file_ext $out_ext)"

            out_file="${in_file%.*}$out_ext"

            echo "mv $in_file $out_file"
            mv $in_file $out_file
        done
    fi
fi

if [[ -n ${args[--ans-ext]} ]]; then
    if [[ -n ${args[--map-ans]} || ${args[--ans-ext]} != ${ini[options.ans_ext]} ]]; then
        file_ext="$(dot_file_ext ${args[--ans-ext]})"

        for ans_file in $(find $target_dir -name "*$file_ext"); do
            out_ext="${ini[options.ans_ext]}"
            if [[ -n ${args[--map-ans]} ]]; then
                out_ext="${args[--map-ans]}"
            fi
            out_ext="$(dot_file_ext $out_ext)"

            out_file="${ans_file%.*}$out_ext"

            echo "mv $ans_file $out_file"
            mv $ans_file $out_file
        done
    fi
fi
