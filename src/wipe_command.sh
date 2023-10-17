ini_load .algo_owls.ini

if [[ -z ${args[--tests]} || ${args[--tests]} -eq 0 ]]; then
    rm -r ${ini[options.target_dir]}/*
fi

if [[ -n ${args[--tests]} && ${args[--tests]} -eq 1 ]]; then
    rm -r ${ini[options.tests_dir]}/*
elif [[ -n ${args[--all]} && ${args[--all]} -eq 1 ]]; then
    rm -r ${ini[options.tests_dir]}/*
fi
