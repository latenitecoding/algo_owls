ini_load .algo_owls.ini

for key in $(ini_keys); do
    if [[ -n ${args[--include-tests]} && ${args[--include-tests]} -eq 1 ]]; then
        echo "$key=${ini[$key]}"
    elif [[ $key != tests.* ]]; then
        echo "$key=${ini[$key]}"
    fi
done
