EXT="$ALGO_EXT"
if [[ ! -z ${args[--ext]} ]]; then
    EXT="${args[--ext]}"
fi
if [[ ${EXT:0:1} != "." ]]; then
    EXT=".$EXT"
fi

SOLUTION="${args[solution]}$EXT"

TARGET_FILE=$(find $ALGO_SOLUTIONS -name $SOLUTION)

if [[ -z $TARGET_FILE ]]; then
    echo "algo_owls: $SOLUTION: No such file or directory" 1>&2
    echo "Try using: ./algo_owls init $ALGO_SOLUTIONS/$SOLUTION"
    exit 1
fi

BUILD_CMD="${ALGO_BUILD_CMD}"
if [[ ! -z ${args[--build_cmd]} ]]; then
    BUILD_CMD="${args[--build_cmd]}"
fi
if [[ ! -z ${args[--build_flag]} ]]; then
    BUILD_CMD="$BUILD_CMD ${args[--build_flag]} \$ALGO_TARGET"
fi
BUILD_CMD="$BUILD_CMD $TARGET_FILE"

eval $BUILD_CMD
