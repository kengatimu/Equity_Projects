#-----------------------------------------------------------------------------------
#  Name            : ccrrm.com
#-----------------------------------------------------------------------------------
#  1.0             09-10-2023     JAMES GICHIRI          ORIGINAL VERSION
#-----------------------------------------------------------------------------------
. `execom commfunc.com`
set -vx

sessionid=${sessionid}
userid=${userid}
successfile=${successfile}

sleep 5

echo "Hellow testing" >> test.txt

exebatch babx4040 ${sessionid} ${successfile}  "CCRRM Modification Report" "MANAGER" "1" "N"

#rm -f $successfile

exit 0
