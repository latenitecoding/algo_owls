ini_load .algo_owls.ini

solutions_dir="$(fmt_dir ${ini[options.solutions_dir]})"

solution_file="${args[solution]}"
if [[ $solution_file != $solutions_dir* ]]; then
    solution_file="$solutions_dir$solution_file"
fi

file_ext="$(handle_file_ext)"
if [[ -n $file_ext ]]; then
    solution_file="$solution_file$file_ext"
fi

if [[ -z ${args[--overwrite]} || ${args[--overwrite]} -eq 0 ]]; then
    if [[ -f $solution_file ]]; then
        echo "algo_owls: $solution_file: File already exists" 1>&2
        echo "Try using: ./algo_owls init --overwrite ${args[solution]}" 1>&2
        exit 1
    fi
fi

if [[ -n ${args[--touch]} && ${args[--touch]} -eq 1 ]]; then
    echo "touch $solution_file"
    mkdir -p ${solution_file%/*}
    touch $solution_file
    exit 0
fi

template_file="${ini[options.template_file]}"
if [[ -n ${args[--template]} ]]; then
    template_file="${args[--template]}"
fi
if [[ -n $file_ext ]]; then
    template_file="$template_file$file_ext"
fi

if [[ -z $template_file ]]; then
    echo "algo_owls: Cannot use '' as a template file" 1>&2
    echo "Try using: ./algo_owls init --touch ${args[solution]}" 1>&2
    exit 1
fi

if [[ ! -f $template_file ]]; then
    echo "algo_owls: $template_file: No such file" 1>&2
    echo "Try using: ./algo_owls init --touch ${args[solution]}" 1>&2
    exit 1
fi

echo "cp $template_file $solution_file"
mkdir -p ${solution_file%/*}
cp $template_file $solution_file
