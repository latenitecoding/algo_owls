ini_load .algo_owls.ini

EXT="${ini[options.file_ext]}"
if [[ ! -z ${args[--ext]} ]]; then
    EXT="${args[--ext]}"
fi
if [[ ${EXT:0:1} != "." ]]; then
    EXT=".$EXT"
fi

SOLUTION="${args[solution]}"
if [[ -z ${args[--no_ext]} || ${args[--no_ext]} == 0 ]]; then
    SOLUTION="$SOLUTION$EXT"
fi

TARGET_FILE=$(find ${ini[options.solutions_dir]} -name $SOLUTION)

if [[ -z $TARGET_FILE ]]; then
    echo "algo_owls: $SOLUTION: No such file or directory" 1>&2
    echo "Try using: ./algo_owls init ${ini[options.solutions_dir]}$SOLUTION"
    exit 1
fi

if [[ ! -z ${args[--fmt]} && ${args[--fmt]} == 1 ]]; then
    FLAGS=""
    if [[ ! -z ${args[--ext]} ]]; then
        FLAGS="--ext ${args[--ext]}"
    fi
    if [[ ! -z ${args[--no_ext]} && ${args[--no_ext]} == 1 ]]; then
        FLAGS="--no_ext"
    fi
    if [[ -z $FLAGS ]]; then
        ./algo_owls fmt ${args[solution]}
    else
        ./algo_owls fmt ${args[solution]} $FLAGS
    fi
fi

git add $TARGET_FILE

MESSAGE="completes ${args[solution]}"
if [[ ! -z ${args[--message]} ]]; then
    MESSAGE="${args[--message]}"
fi

git commit -m $MESSAGE

BRANCH="${ini[options.branch]}"
if [[ ! -z ${args[--branch]} ]]; then
    BRANCH="${args[--branch]}"
fi

REMOTE="${ini[options.remote]}"
if [[ ! -z ${args[--remote]} ]]; then
    REMOTE="${args[--remote]}"
fi

git push $REMOTE $BRANCH
