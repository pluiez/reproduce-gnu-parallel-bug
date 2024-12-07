set -euo pipefail

usage() {
    echo "Usage: $0 <input> <n_tests>" >&2
    exit 1
}

[ $# -eq 2 ] || usage

input=$1
n_tests=$2

output=$input.test-parallel-cat
hash1=$(sha256sum "$input" | cut -d' ' -f1)

run_single_test() {
    local jobid=$1
    local input=$2
    local output=$3
    local hash1=$4

    output=$output.$jobid

    parallel -j64 -k --block -1 --pipepart -a $input "sleep 1; cat" > $output
    # use --cat also fails
    # parallel -j64 -k --block -1 --pipepart -a $input --cat "cat {}" > $output

    hash2=$(sha256sum $output | cut -d' ' -f1)
    if [[ $hash1 != $hash2 ]]; then
        echo
        echo -e "[Hash mismatch @ $jobid] input: hash=$hash1, path=$input; output: hash=$hash2, path=$output"
        exit 1
    else
        rm $output
    fi
}

export -f run_single_test

#parallel --progress  -j16 -k "run_single_test {} $input $output $hash1" ::: $(seq 1 $n_tests)
parallel  -j16 -k "run_single_test {} $input $output $hash1" ::: $(seq 1 $n_tests)
