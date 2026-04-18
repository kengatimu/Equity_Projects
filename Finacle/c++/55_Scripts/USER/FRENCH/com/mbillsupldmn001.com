#=================================================================================================================*
# Name                          :   mbillsupldmn001.com
# Date                          :   17-02-2013
# Description                   :   This com is used to generate the txt file .
# Author                        :   Chethan.S
# Reference                     :
# Modification History  :
#  <Serial No.>  <Date>         <AuthorName>            <Description>
#--------------------------------------------------------------------------
#   1           17-02-2013      Chethan.S               Original version
#	2.0			27-10-2013		Bharath				Upload initiated in background
#=================================================================================================================*
set -vx
fileName="mbillsupld${$}.txt"
rptFileName="mbillsupld${$}"
datFile="test${$}.dat"
tempFile="tempmbil${$}.txt"
SuccessFile="SuccessFile_${$}.rpt"
ErrorFile="ErrorFile_${$}.rpt"
tmpsqlfile="tmpsql${$}.sql"
tranRmks=`echo ${tranRmks} |sed -e "s/ /|/g"`

#-----------------------------------------------------------------------------------
#------Checking if directory is present and creating directory
#-----------------------------------------------------------------------------------
userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"
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
$TBA_E/bauu9151 mbillsupldmn001.sql $fileName ${bankId} ${crncyCode} ${onsUser} ${acctNumbTran} ${SuccessFile} ${ErrorFile}
cp ${fileName} $FIN_REPORTS_DIR/${userid}/${fileName}
cp ${SuccessFile} $FIN_REPORTS_DIR/${userid}/${SuccessFile}
cp ${ErrorFile} $FIN_REPORTS_DIR/${userid}/${ErrorFile}

noOfPages=`grep -c "^L" "$fileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$FIN_REPORTS_DIR/${userid}/$fileName" "TTUM FILE BILL PAY" "MANAGER" "${noOfPages}" N

noOfPages=`grep -c "^L" "${SuccessFile}"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$FIN_REPORTS_DIR/${userid}/${SuccessFile}" "SUCCESS BILL PAY" "MANAGER" "${noOfPages}" N

noOfPages=`grep -c "^L" "${ErrorFile}"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$FIN_REPORTS_DIR/${userid}/${ErrorFile}" "ERROR BILL PAY" "MANAGER" "${noOfPages}" N

#-- generate the file which TTUM accept for upload
mrbx4004 $B2K_SESSION_ID mbillsupldmn001.mrt $fileName $rptFileName

cp $FIN_REPORTS_DIR/${userid}/${rptFileName}.rpt ${upldpath}/${rptFileName}.rpt

sed 's/\~/ /g' $FIN_REPORTS_DIR/${userid}/${rptFileName}.rpt > $tempFile

cp $tempFile ${upldpath}/${rptFileName}.rpt


#modified by anuya to make the file compatible to 10.2.18
echo "${rptFileName}.rpt ${pstdFlg} ${renameFlg}
MANAGER CI ${rptFileName}.rpt ${pstdFlg} ${tranRmks} ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile mbillupld.dat
mcbx4024 $B2K_SESSION_ID < mbillupld.dat
echo `head -1 TRAN_INFO.dat` >> mbillupld.txt

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
