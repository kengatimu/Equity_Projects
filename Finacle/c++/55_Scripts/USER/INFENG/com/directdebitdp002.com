set -vx
fileName1=${onsUser}"_APPLIED_"${sysdate}".SUC"
fileName2=${onsUser}"_UNAPPLIED_"${sysdate}".SUC"
fileName3=${onsUser}"_Charge_"${sysdate}".SUC"
#rptName1=$9
datFile="DDUMTest${$}.dat"
tmpsqlfile="tmpsql${$}.sql"

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


bauu9151 directdebitmn001.sql \'${sqlInput}\' ${onsUser} 
if [ $? -ne 0 ]
then
        echo "SQL execution failed !" > DDUMTest.txt
        exit 1
fi

if [ -s "${lstFileName}" ]
then
	cp ${lstFileName} ${rptpath}/${lstFileName}
	noOfPages=`grep -c "" "${rptpath}/${lstFileName}"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 "${B2K_SESSION_ID}" "${rptpath}/${lstFileName}" "DDUM List File" "MANAGER" "${noOfPages}" N
fi

cp ${fileName1} ${upldpath}/${fileName1}
cp ${fileName2} ${upldpath}/${fileName2}
cp ${fileName3} ${upldpath}/${fileName3}

noOfLine=`cat ${fileName1}|wc -l`
if [ ${noOfLine} -gt 1 ]
then
echo "$fileName1 ${pstdFlg} ${renameFlg}
MANAGER ${tranSubType} $fileName1 ${pstdFlg} Direct_Applied ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile Direct_Applied.dat
mcbx4024 $B2K_SESSION_ID < Direct_Applied.dat
echo `head -1 TRAN_INFO.dat` >> Direct_Applied.txt
a=`head -1 TRAN_INFO.dat`
	echo "a is " $a > DDUMTest.test
fi

noOfLine=`cat ${fileName2}|wc -l`
if [ ${noOfLine} -gt 1 ]
then
echo "$fileName2 ${pstdFlg} ${renameFlg}
MANAGER ${tranSubType} $fileName2 ${pstdFlg} Direct_Unapplied ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile Direct_Unapplied.dat
mcbx4024 $B2K_SESSION_ID < Direct_Unapplied.dat
echo `head -1 TRAN_INFO.dat` >> Direct_Unapplied.txt
b=`head -1 TRAN_INFO.dat`
	echo "b is " $b >> DDUMTest.test
fi

noOfLine=`cat ${fileName3}|wc -l`
if [ ${noOfLine} -gt 1 ]
then
echo "$fileName3 ${pstdFlg} ${renameFlg}
MANAGER ${tranSubType} $fileName3 ${pstdFlg} Direct_Charges ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile Direct_Charges.dat
mcbx4024 $B2K_SESSION_ID < Direct_Charges.dat
echo `head -1 TRAN_INFO.dat` >> Direct_Charges.txt
c=`head -1 TRAN_INFO.dat`
	echo "c is " $c >> DDUMTest.test
fi

if [ ${renameFlg} == "Y" ]
then
	mv ${filePath} ${filePath}.done
fi

if test "$a" != ""
then
echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > ${tmpsqlfile}
echo " tran_id = '"$a"|"$b"|"$c"'" >> ${tmpsqlfile}
echo " WHERE upld_file_name = '"${onsUser}"'" >> ${tmpsqlfile}
echo " AND bank_id = '"${bankId}"'" >> ${tmpsqlfile}
echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"${onsUser}"'" >> ${tmpsqlfile}
echo " AND bank_id = '"${bankId}"')" >> ${tmpsqlfile}
echo "/" >> ${tmpsqlfile}
echo "COMMIT" >> ${tmpsqlfile}
echo "/" >> ${tmpsqlfile}
else
echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > ${tmpsqlfile}
echo " tran_id = '"$a|"$b"|"$c""'" >> ${tmpsqlfile}
echo " WHERE upld_file_name = '"${onsUser}"'" >> ${tmpsqlfile}
echo " AND bank_id = '"${bankId}"'" >> ${tmpsqlfile}
echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"${onsUser}"'" >> ${tmpsqlfile}
echo " AND bank_id = '"${bankId}"')" >> ${tmpsqlfile}
echo "/" >> ${tmpsqlfile}
echo "COMMIT" >> ${tmpsqlfile}
echo "/" >> ${tmpsqlfile}
fi

bauu9151 ${tmpsqlfile}

exit 0
#Deleting files after processing
rm -f ${fileName1} 
rm -f ${fileName2} 
rm -f ${fileName3} 
rm -f ${tmpsqlfile}

exit 0

