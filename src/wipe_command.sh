ini_load .algo_owls.ini

if [[ -z ${args[--tests]} || ${args[--tests]} -eq 0 ]]; then
    if [[ $(ls ${ini[options.target_dir]}) ]]; then
        echo "rm -r $(fmt_dir ${ini[options.target_dir]})*"
        rm -r $(fmt_dir ${ini[options.target_dir]})*
    fi
fi

if [[ -n ${args[--tests]} && ${args[--tests]} -eq 1 ]]; then
    if [[ $(ls ${ini[options.tests_dir]}) ]]; then
        echo "rm -r $(fmt_dir ${ini[options.tests_dir]})*"
        rm -r $(fmt_dir ${ini[options.tests_dir]})*
    fi
elif [[ -n ${args[--all]} && ${args[--all]} -eq 1 ]]; then
    if [[ $(ls ${ini[options.tests_dir]}) ]]; then
        echo "rm -r $(fmt_dir ${ini[options.tests_dir]})*"
        rm -r $(fmt_dir ${ini[options.tests_dir]})*
    fi
fi
