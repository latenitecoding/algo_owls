ini_load .algo_owls.ini

file_ext="$(handle_file_ext)"

solution_file="${ini[options.solutions_dir]}/${args[solution]}"
if [[ -n $file_ext ]]; then
    solution_file="$solution_file$file_ext"
fi

if [[ -n ${args[--touch]} && ${args[--touch]} -eq 1 ]]; then
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
    echo "Try using: ./algo_owls init --touch $solution_file" 1>&2
    exit 1
fi

if [[ ! -f $template_file ]]; then
    echo "algo_owls: $template_file: No such file or directory" 1>&2
    echo "Try using: ./algo_owls init --touch $solution_file" 1>&2
    exit 1
fi

mkdir -p ${solution_file%/*}
cp $template_file $solution_file
