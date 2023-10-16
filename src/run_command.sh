echo "# this file is located in 'src/run_command.sh'"
echo "# code for 'algo_owls run' goes here"
echo "# you can edit it freely and regenerate (it will not be overwritten)"
inspect_args

if [[ ! -z ${args[--build]} && ${args[--build]} == 1 ]]; then
    if [[ ! -z ${args[--ext]} ]]; then
        ./algo_owls build --ext ${args[--ext]} ${args[solution]}
    else
        ./algo_owls build ${args[solution]}
    fi
fi

EXT="$ALGO_EXT"
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

TARGET_DIR="$ALGO_TARGET"
if [[ ! -z ${args[--use_source]} && ${args[--use_source]} == 1 ]]; then
    TARGET_DIR="$ALGO_SOLUTIONS"
fi

TARGET_FILE=$(find $TARGET_DIR -name $SOLUTION)

if [[ -z $TARGET_FILE ]]; then
    echo "algo_owls: $SOLUTION: No such file or directory" 1>&2
    echo "Try using: ./algo_owls run --build $SOLUTION"
    exit 1
fi

RUN_FLAG="${ALGO_RUN_FLAG}"
if [[ ! -z ${args[--run_flag]} ]]; then
    RUN_FLAG="${args[--run_flag]}"
fi

RUN_CMD="${ALGO_RUN_CMD}"
if [[ ! -z ${args[--run_cmd]} ]]; then
    RUN_CMD="${args[--run_cmd]}"
fi
if [[ ! -z $RUN_FLAG ]]; then
    RUN_CMD="$RUN_CMD $RUN_FLAG $TARGET_DIR"
fi
RUN_CMD="$RUN_CMD $TARGET_FILE"

eval $RUN_CMD
