. `execom commfunc.com`
set -vx
input="$1"

bauu9151 SPJseq.sql "$1"

exit 0
