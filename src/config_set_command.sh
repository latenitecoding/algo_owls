ini_load .algo_owls.ini

eval "entries=(${args[entry]})"

for idx in "${!entries[@]}"; do
    entry="${entries[idx]}"
    key="${entry%%=*}"
    value="${entry#*=}"

    if [[ -n $value ]]; then
        ini["$key"]="$value"
    else
        echo "algo_owls: '' is not a valid value" 1>&2
    fi
done

ini_save .algo_owls.ini
