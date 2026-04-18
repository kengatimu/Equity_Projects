set -vx
. /etc/b2k/EQPROD/FINCORE/54/com/commonenv.com
exebatch babx4061 $B2K_SESSION_ID  FinacleHealthAlert.scr
if [ $? -ne 0 ]
then
    echo "Script execution failed!"
    exit 1
fi
exit 0
