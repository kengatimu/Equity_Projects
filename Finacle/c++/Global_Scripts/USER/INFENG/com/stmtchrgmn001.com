#=================================================================================================================*
# Name                          :   stmtchrgdp001.com
# Date                          :   25-02-2013
# Description                   :   This com is used to generate the txt file .
# Author                        :   Saurabh Sinha
# Reference                     :
# Modification History  :
#  <Serial No.>  <Date>         <AuthorName>            <Description>
#--------------------------------------------------------------------------
#   1           25-02-2013      Saurabh Sinha               Original version
#=================================================================================================================*
set -vx
fileName="stmtchrg${$}.txt"
rptFileName="stmtchrgRpt${$}"
datFile="stmtchrgDat${$}.dat"
tempFile="stmtchrgTemp${$}.txt"
updateUpldEqtTblFile="stmUpldEq${$}.sql"

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

#-- creating the spool file which need to passed to mrt
bauu9151 ${sqlFileName} ${bankId} $fileName ${acctNo1} ${amt} \'${tpatclr}\' ${homeCrncy} ${solId1} ${solId2}
tpatclr=`echo ${tpatclr} |sed -e "s/ /|/g"`

#-- generate the file which TTUM eaccept for upload
mrbx4004 $B2K_SESSION_ID stmtchrgmn001.mrt $fileName $rptFileName
cp ${rptpath}/${rptFileName}.rpt ${upldpath}/${rptFileName}.rpt

sed 's/\~/ /g' ${rptpath}/${rptFileName}.rpt > $tempFile

cp $tempFile ${upldpath}/${rptFileName}.rpt

if [ "${testFlg}" == "Y" ]
then
#modified by Anuya
echo "$rptFileName.rpt T Y
MANAGER BI $rptFileName.rpt T ${tpatclr} Y Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile stmtchrg.dat
mcbx4024 $B2K_SESSION_ID < stmtchrg.dat
echo `head -1 TRAN_INFO.dat` >> stmtchrg.txt
else
#modified by Anuya
echo "$rptFileName.rpt P Y
MANAGER BI $rptFileName.rpt P ${tpatclr} Y Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile stmtchrg.dat
mcbx4024 $B2K_SESSION_ID < stmtchrg.dat
echo `head -1 TRAN_INFO.dat` >> stmtchrg.txt

fi
a=`head -1 TRAN_INFO.dat`

if test "$a" != "" 
then 
echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > $updateUpldEqtTblFile
echo " tran_id = '"$a"'" >> $updateUpldEqtTblFile
echo " WHERE upld_file_name = '"${inpFileName}"'" >> $updateUpldEqtTblFile
echo " AND bank_id = '"${bankId}"'" >> $updateUpldEqtTblFile
echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"${inpFileName}"'" >> $updateUpldEqtTblFile
echo " AND bank_id = '"${bankId}"')" >> $updateUpldEqtTblFile
echo "/" >> $updateUpldEqtTblFile
echo "COMMIT" >> $updateUpldEqtTblFile
echo "/" >> $updateUpldEqtTblFile
else
echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " >$updateUpldEqtTblFile
echo " tran_id = '"$a"'" >> $updateUpldEqtTblFile
echo " WHERE upld_file_name = '"${inpFileName}"'" >> $updateUpldEqtTblFile
echo " AND bank_id = '"${bankId}"'" >> $updateUpldEqtTblFile
echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"${inpFileName}"'" >> $updateUpldEqtTblFile
echo " AND bank_id = '"${bankId}"')" >> $updateUpldEqtTblFile
echo "/" >> $updateUpldEqtTblFile
echo "COMMIT" >> $updateUpldEqtTblFile
echo "/" >> $updateUpldEqtTblFile
fi

bauu9151 ${updateUpldEqtTblFile}

if [ ${testFlg} == "N" ]
then
	mv ${fileNamePath} ${fileNamePath}.done
fi

if [ "x$TBA_DEBUG" = "x" ]
then
    rm -f $fileName
    rm -f $rptFileName
    rm -f $datFile
    rm -f $tempFile
    rm -f $updateUpldEqtTblFile
fi
exit 0
