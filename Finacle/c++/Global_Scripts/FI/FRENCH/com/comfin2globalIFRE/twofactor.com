. `execom commfunc.com`
set -vx
input="$1"
input="$2"
 
 bauu9151 CREATE_TWOFACTOR.sql "$1" "$2"

exit 0