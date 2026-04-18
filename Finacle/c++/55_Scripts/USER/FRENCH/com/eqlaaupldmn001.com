#=================================================================================================================*
# Name                          :   eqlaaupldmn001.com
# Date                          :   23-02-2013
# Description                   :   This com is used to generate the txt file .
# Author                        :   Samrat Saha
# Reference                     :
# Modification History  :
#  <Serial No.>  <Date>         <AuthorName>            <Description>
#--------------------------------------------------------------------------
#   1           23-02-2013      Samrat Saha               Original version
#	2			03-06-2013		Samrat Saha				  Added code to make data file to dot done	
#	3			27-10-2013		Bharath				Upload initiated in background
#=================================================================================================================*
. `execom commfunc.com`
set -vx

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

fileName="eqlaaupld${$}.txt"
fileName1="eqlaaupld${$}_lacol1.txt"
fileName2="eqlaaupld${$}_lacol2.txt"
rptFileName="eqlaaupld${$}.out"
rptFileName1="eqlaaupld${$}_lacol1.out"
datFile="test${$}.dat"
datFile1="test${$}1.dat"
tempFile="tempFile${$}.txt"
tempFile1="tempFile${$}_lacol1.txt"
testsql="testsql${$}.sql"
reportFileName1="`echo ${fileName} | cut -d '.' -f 1`${sysdate}.TXT"

#----------------------------------------------------- 
#--creating the spool file which need to passed to mrt
#----------------------------------------------------- 
#bauu9151 eqlaaupldmn001.sql $fileName ${bankId} ${crncyCode} ${onsUser} ${testFlg} $reportFileName1
bauu9151 eqlaaupldmn001.sql $fileName ${bankId} ${crncyCode} ${onsUser} ${testFlg} $reportFileName1 $fileName1 $fileName2

cp ${reportFileName1} $FIN_REPORTS_DIR/${userid}/${reportFileName1}

lacolOffacct=`cat $fileName2`

#--------------------------------------------------------
# To Pass the Report to HPR
#-------------------------------------------------------

noOfPages=`grep -c "^L" "$reportFileName1"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$FIN_REPORTS_DIR/${userid}/${reportFileName1}" "EQ Upload Report" "MANAGER" "${noOfPages}" N

#----------------------------------------------------- 
#-- generate the file which TTUM accept for upload
#----------------------------------------------------- 

mrbx4004 $B2K_SESSION_ID eqlaaupldmn001.mrt $fileName $rptFileName


cp ${FIN_REPORTS_DIR}/${userid}/${rptFileName}.rpt ${upldpath}/${rptFileName}.rpt

sed 's/\~/ /g' ${upldpath}/${rptFileName}.rpt > ${tempFile}
cp ${tempFile} ${rptFileName}.rpt
cp ${tempFile} ${upldpath}/${rptFileName}.rpt

#----------------------------------------------------- 
#-- generate the file which HLACOLUP accept for upload
#----------------------------------------------------- 

mrbx4004 $B2K_SESSION_ID eqlaaupldmn002.mrt $fileName1 $rptFileName1

cp ${FIN_REPORTS_DIR}/${userid}/${rptFileName1}.rpt ${upldpath}/${rptFileName1}.rpt

sed 's/\~/ /g' ${upldpath}/${rptFileName1}.rpt > ${tempFile1}
cp ${tempFile1} ${rptFileName1}.rpt
cp ${tempFile1} ${upldpath}/${rptFileName1}.rpt


if [ "${testFlg}" == "Y" ]
then
echo "${rptFileName}.rpt T Y
MANAGER CI ${rptFileName}.rpt T ${rmks} Y Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
#$TBA_E/mcbx4024 $B2K_SESSION_ID < ./$datFile
cp $datFile eqlaupld.dat
mcbx4024 $B2K_SESSION_ID < eqlaupld.dat
#for uploading the HLACOLUP file
echo "${rptFileName1}.rpt N N
L $lacolOffacct ${rptFileName1}.rpt Y Y
 pg0_menu_ind dr_acct_num file_name test_mode rename_file_name" > $datFile1
cp $datFile1 eqlaupld1.dat
mcbx6018 $B2K_SESSION_ID < eqlaupld1.dat
else
echo "${rptFileName}.rpt P Y
MANAGER CI ${rptFileName}.rpt P ${rmks} Y Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
"> $datFile
#$TBA_E/mcbx4024 $B2K_SESSION_ID < ./$datFile
cp $datFile eqlaupld.dat
mcbx4024 $B2K_SESSION_ID < eqlaupld.dat
#for uploading the HLACOLUP file
echo "${rptFileName1}.rpt N N
L $lacolOffacct ${rptFileName1}.rpt N Y
 pg0_menu_ind dr_acct_num file_name test_mode rename_file_name" > $datFile1
cp $datFile1 eqlaupld1.dat
mcbx6018 $B2K_SESSION_ID < eqlaupld1.dat
fi
a=`head -1 TRAN_INFO.dat`

echo $a > tempTranTest.txt

#bauu9151 eqlaauplddp001.sql $a $5 $2 

if test "$a" != "" 
then 
    echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > $testsql
    echo " tran_id = '"$a"'" >> $testsql
    echo " WHERE upld_file_name = '"${fileName}"'" >> $testsql
    echo " AND bank_id = '"${bankId}"'" >> $testsql
    echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"${fileName}"'" >> $testsql
    echo " AND bank_id = '"${bankId}"')" >> $testsql
    echo "/" >> $testsql
    echo "COMMIT" >> $testsql
    echo "/" >> $testsql
else
    echo "UPDATE CUSTOM.C_UPLD_EQT_TBL SET STATUS = 'S',status_desc = 'Transaction posted successfully', " > $testsql
    echo " tran_id = '"$a"'" >> $testsql
    echo " WHERE upld_file_name = '"${fileName}"'" >> $testsql
    echo " AND bank_id = '"${bankId}"'" >> $testsql
    echo " AND upld_srl_num = ( SELECT MAX(upld_srl_num) FROM CUSTOM.C_UPLD_EQT_TBL WHERE upld_file_name = '"${fileName}"'" >> $testsql
    echo " AND bank_id = '"${bankId}"')" >> $testsql
    echo "/" >> $testsql
    echo "COMMIT" >> $testsql
    echo "/" >> $testsql
fi

chmod 777 $testsql

bauu9151 $PWD/$testsql

if [ ${renameFlg} == "Y" ]
then
	mv ${inputFilePath} ${inputFilePath}.done
fi

#Deleting after processing
rm -f ${reportFileName1}
rm -f ${tempFile}
rm -f ${testsql}

exit 0
CUST.EQUPLD.fileExist=""
