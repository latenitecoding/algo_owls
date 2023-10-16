EXT="$ALGO_EXT"
if [[ ! -z ${args[--ext]} ]]; then
    EXT="${args[--ext]}"
fi
if [[ ${EXT:0:1} != "." ]]; then
    EXT=".$EXT"
fi

TEMPLATE="${args[--template]}$EXT"
SOLUTION="$ALGO_SOLUTIONS/${args[solution]}$EXT"

if [[ ! -z ${args[--touch]} && ${args[--touch]} == 1 ]]; then
    mkdir -p ${SOLUTION%/*}
    touch $SOLUTION
    exit 0
fi

if [[ -z $TEMPLATE ]]; then
    echo "algo_owls: Cannot use '' as a template file" 1>&2
    echo "Try using: ./algo_owls init --touch $SOLUTION"
    exit 1
fi

if [[ ! -f $TEMPLATE ]]; then
    echo "algo_owls: $TEMPLATE: No such file or directory" 1>&2
    echo "Try using: ./algo_owls init --touch $SOLUTION"
    exit 1
fi

mkdir -p ${SOLUTION%/*}
cp $TEMPLATE $SOLUTION
