#----------------------------------------------------------------------------
# Name  : EQLM.com
# # Description : This com script is used to call the Equity_LM_Main.scr file
# Called File :  This com file will be called by check01.com to create session id
# Called By       :
# Inputs    :
#-------------------------------------------------------------------------------

set -vx
#. /finacle/V707/app/b2k/ebfin/com/commonenv.com
#echo "inside check com file to execute the Equity_LM_Main.scr" >> /finusers/webadm/ebankadm/bway_logs/logs/Croncheck.log 
#execom exectrusteduser.com
#. /finacle/V707/app/b2k/ebfin/com/commonenv.com

inTmpDir=${INP_TEMP_DIR_PATH}
SCRIPT_NAME="Equity_LM_Main.scr"

# Create a Finacle session
#exebatch /finacle/V707/app/cust/INFENG/exe/babx4044
#export B2K_SESSION_ID=`cat tty.mn3`
#export NOETOS=`cat anskey.mn1`

echo $B2K_SESSION_ID 

echo "befor calling" 

ls -lrt $inTmpDir  |awk '{ print $9 }' >> cust_$$.lst 
fSize=$(ls -lrt cust_$$.lst |awk '{ print $5 }')
fileName=`ls ${inTmpDir}|head -1`
if [ $fSize -ne 0 ]
then
	#exebatch -i cust_$$.lst -n 5 EQLMsub.com  @s
	babx4061 $B2K_SESSION_ID Equity_LM_Main.scr "${fileName}"
	if [ $? -ne 0 ]
	then
		echo "SQL  execution failed !"
		exit
	fi
fi

if [ $? -ne 0 ]
then
        echo "Script call Failed !"
        exit 0
fi

echo "afterr calling" 

exit $?

