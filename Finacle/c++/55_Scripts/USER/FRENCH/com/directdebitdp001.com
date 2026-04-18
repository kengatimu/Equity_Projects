set -vx
#-----------------------------------------------------------------------------------
#------Checking if directory is present and creating directory
#-----------------------------------------------------------------------------------
userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"
rptpath="$FIN_REPORTS_DIR/${userid}"
test -d ${upldpath}
if [ $? -ne 0 ]
then
        mkdir ${upldpath}
fi

test -d $FIN_REPORTS_DIR/${userid}
if [ $? -ne 0 ]
then
        mkdir $FIN_REPORTS_DIR/${userid}
fi

reportFileName="${userId}_${$}.lst"

bauu9151 directdebitmn002.sql '${sqlInput}' ${bankId} $reportFileName
if [ $? -ne 0 ]
then
        echo "SQL execution failed !"
        exit 1
fi

cp $reportFileName ${rptpath}/$reportFileName

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "${rptpath}/$reportFileName" "DDUM" "MANAGER" "${noOfPages}" N

exit 0
#deleting file after processing
rm -f $reportFileName

