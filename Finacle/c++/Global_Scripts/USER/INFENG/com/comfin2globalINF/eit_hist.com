#File to insert daily EIT records into custom table c_eit_hist for interest substantiation report used for reconciliation.
#Author: Srinivas
#Version History
#Ver. No.       Date            Modified By     Remarks
#  1            04-Jul-2013     Srinivas J       Created

. /etc/b2k/$FINACLE_INSTALL_ID/FINCORE/$FIN_BANK_ID/com/commonenv.com

dt=`date`
logfilename=$ONS_LOG_DIR/eit_hist_insert_`date -u +%d%m%Y%H%M%S`.log
echo "Execution started on:">>$logfilename
echo $dt>>$logfilename
bauu9151 NR_Insert_C_EIT_HIST.sql $FIN_BANK_ID ALL
stat=$?
echo $stat>>$logfilename
dt=`date`
echo "Execution ended on:">>$logfilename
echo $dt>>$logfilename
if [ $stat -eq 0 ]
then
echo "Execution Successful">>$logfilename
exit 0
else
echo "Failed to execute SQL">>$logfilename
  exit 1
fi

