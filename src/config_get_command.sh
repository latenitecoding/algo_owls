ini_load .algo_owls.ini

eval "keys=(${args[key]})"

for idx in "${!keys[@]}"; do
    key="${keys[idx]}"
    value="${ini[$key]}"

    if [[ -n $value ]]; then
        echo "$key = $value"
    else
        echo "algo_owls: $key: No such key" 1>&2
    fi
done
