. `execom commfunc.com`
set -vx
input="$1"

 bauu9151 CREATE_TWOFACTOR2.sql "$1"

exit 0