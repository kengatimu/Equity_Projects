#=================================================================================================================*
# Name                          :   cmbillsupldmn001.com
# Date                          :   17-02-2013
# Description                   :   This com is used to generate the txt file .
# Author                        :   Chethan.S
# Reference                     :
# Modification History  :
#  <Serial No.>  <Date>         <AuthorName>            <Description>
#--------------------------------------------------------------------------
#   1           17-02-2013      Chethan.S               Original version
#=================================================================================================================*
set -vx
fileName="cmbillsupld${$}.txt"
rptFileName="cmbillsupld${$}"
datFile="test${$}.dat"
tempFile="tempcmbill${$}.txt"
errFile="Error${$}.log"
SuccessFile="SuccessFile_${$}.rpt"
ErrorFile="ErrorFile_${$}.rpt"
tmpsqlfile="tmpsql${$}.sql"
tranRmks=`echo ${tranRmks} |sed -e "s/ /|/g"`

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
bauu9151 cmbillsupldmn001.sql $fileName ${bankId} ${crncyCode} ${onsUser} ${acctNumTran} ${SuccessFile} ${ErrorFile}
cp ${fileName} ${rptpath}/${fileName}
cp ${SuccessFile} ${rptpath}/${SuccessFile}
cp ${ErrorFile} ${rptpath}/${ErrorFile}


noOfPages=`grep -c "^L" ${fileName}`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "${rptpath}/${fileName}" "TTUM Files" "MANAGER" "${noOfPages}" N

noOfPages=`grep -c "^L" "${SuccessFile}"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "${rptpath}/${SuccessFile}" "SUCCESS POSTAGE/ATM STATEMENT" "MANAGER" "${noOfPages}" N

noOfPages=`grep -c "^L" "${ErrorFile}"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "${rptpath}/${ErrorFile}" "ERROR POSTAGE/ATM STATEMENT" "MANAGER" "${noOfPages}" N

#-- generate the file which TTUM eaccept for upload
mrbx4004 $B2K_SESSION_ID cmbillsupldmn001.mrt $fileName $rptFileName

if [ $? -ne 0 ]
then
    echo " MRT to generate the report which need to be pass to TTUM exe failed." >> $errFile
fi

cp ${rptpath}/${rptFileName}.rpt ${upldpath}/${rptFileName}.rpt

sed 's/\~/ /g' ${rptpath}/${rptFileName}.rpt > $tempFile

cp $tempFile ${upldpath}/${rptFileName}.rpt

#modified by Anuya
echo "$rptFileName.rpt ${postFlg} ${renameFlg}
MANAGER CI $rptFileName.rpt ${postFlg} ${tranRmks} ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile cmbillsupldmn001.dat
mcbx4024 $B2K_SESSION_ID < cmbillsupldmn001.dat
echo `head -1 TRAN_INFO.dat` >> cmbillsupldmn001.txt

if [ $? -ne 0 ]
then
    echo "TTUM exe execution failed." >> $errFile
fi

a=`head -1 TRAN_INFO.dat`


if test "$a" != "" 
then 
echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > ${tmpsqlfile}
echo " tran_id = '"$a"'" >> ${tmpsqlfile}
echo " WHERE upld_file_name = '"${fileName}"'" >> ${tmpsqlfile}
echo " AND bank_id = '"${bankId}"'" >> ${tmpsqlfile}
echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"${fileName}"'" >> ${tmpsqlfile}
echo " AND bank_id = '"${bankId}"')" >> ${tmpsqlfile}
echo "/" >> ${tmpsqlfile}
echo "COMMIT" >> ${tmpsqlfile}
echo "/" >> ${tmpsqlfile}
else
echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > ${tmpsqlfile}
echo " tran_id = '"$a"'" >> ${tmpsqlfile}
echo " WHERE upld_file_name = '"${fileName}"'" >> ${tmpsqlfile}
echo " AND bank_id = '"${bankId}"'" >> ${tmpsqlfile}
echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"${fileName}"'" >> ${tmpsqlfile}
echo " AND bank_id = '"${bankId}"')" >> ${tmpsqlfile}
echo "/" >> ${tmpsqlfile}
echo "COMMIT" >> ${tmpsqlfile}
echo "/" >> ${tmpsqlfile}
fi

bauu9151 ${tmpsqlfile}

if [ ${renameFlg} == "Y" ]
then
	mv ${fileNamePath} ${fileNamePath}.done
fi

#Deleting file after processing
rm -f ${fileName}
rm -f ${SuccessFile}
rm -f ${ErrorFile}
rm -f ${tempFile}
rm -f ${tmpsqlfile}

exit 0

