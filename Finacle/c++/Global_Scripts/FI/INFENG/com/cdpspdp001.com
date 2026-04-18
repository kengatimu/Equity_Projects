set -vx

execom hpsp.com ${B2K_SESSION_ID} ${datFile} "P"

echo $?

