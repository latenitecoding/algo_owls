ini_load .algo_owls.ini

eval "keys=(${args[key]})"

for idx in "${!keys[@]}"; do
    key="${keys[idx]}"
    unset "ini[$key]"
done

ini_save .algo_owls.ini
