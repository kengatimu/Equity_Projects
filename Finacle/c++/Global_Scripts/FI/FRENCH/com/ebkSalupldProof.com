#------------------------------------------------------------------------------------------------------------------    
#	Name			: SAL_LOAD_ERR.com
#	Description		: It will generate a bad and log file report
#	Date			: 13-03-2013
#	Author			: GOKULKRISHNA
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				13-03-2013		GOKULKRISHNA	Original Version
#	2.0				05-07-2013		BHARATH 		Added conditions for suspense accounts upload
#	3.0				18-07-2013		BHARATH 		Validation added for other currency accounts
#--------------------------------------------------------------------------------------------------------------------
. `execom commfunc.com`
set -vx

echo ${FIRE_MTT_BFTI_IN_FOREGROUND}
FIRE_MTT_BFTI_IN_FOREGROUND=N
echo ${FIRE_MTT_BFTI_IN_FOREGROUND}

echo $BABX4010_NUM_JOB "BABX4010_NUM_JOB"
echo $BABX4010_NUM_RECCOUNT "BABX4010_NUM_RECCOUNT"
BABX4010_NUM_JOB=4
BABX4010_NUM_RECCOUNT=15

echo $BABX4010_NUM_JOB "BABX4010_NUM_JOB"
echo $BABX4010_NUM_RECCOUNT "BABX4010_NUM_RECCOUNT"



fileName1=${empId}"_Sal_Chg_"${sysdate}".SUC"
fileName2=${empId}"_Sal_Upl_"${sysdate}".SUC"
fileName3=${empId}"_Sus_Cr_"${sysdate}".SUC"
fileName4=${empId}"_CURRERR.lst"
datFile="salUpld${$}.dat"
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

bauu9151 ebkSalProof_upload.sql ${sqlInput} 
#cp ${fileName1} ${upldpath}/${fileName1} 
sort ${fileName1} > ${upldpath}/${fileName1} 
#cp ${fileName2} ${upldpath}/${fileName2} 
sort ${fileName2} > ${upldpath}/${fileName2} 
#cp ${fileName3} ${upldpath}/${fileName3} 
sort ${fileName3} > ${upldpath}/${fileName3} 
#cp ${fileName4} $FIN_REPORTS_DIR/${userid}/${fileName4} 
sort ${fileName4} > $FIN_REPORTS_DIR/${userid}/${fileName4} 

echo "$fileName2 ${testFlg} ${renameFlg}
S ${empId} ${drAcctId} {~~~NULL!~~~} {~~~NULL!~~~} {~~~NULL!~~~} {~~~NULL!~~~} SALARY_REMITTANCE ${upldType} ${leanFlg} $fileName2 ${testFlg} ${renameFlg} 
 pg0_menu_ind empr_id dr_acct_num ref_num ref_tran_id ref_tran_date ref_part_tran_srl_num tran_rmks upld_type place_lien_flg file_name test_mode rename_file_name
" > $datFile
cp $datFile sal.dat
#${TBA_PROD_ROOT}/prodbase/INFENG/com/salupld.com $B2K_SESSION_ID ./$datFile S
exebatch mcbx6017 $B2K_SESSION_ID < sal.dat 
echo `head -1 TRAN_INFO.dat` > salUpld.txt


echo $BABX4010_NUM_JOB "BABX4010_NUM_JOB"
echo $BABX4010_NUM_RECCOUNT "BABX4010_NUM_RECCOUNT"
BABX4010_NUM_JOB=4
BABX4010_NUM_RECCOUNT=2

echo $BABX4010_NUM_JOB "BABX4010_NUM_JOB"
echo $BABX4010_NUM_RECCOUNT "BABX4010_NUM_RECCOUNT"




noOfLine=`cat ${fileName3}|wc -l`
if [ ${noOfLine} -gt 1 ]
then
        echo "$fileName3 ${postFlg} ${renameFlg}
        MANAGER ${tranSub} $fileName3 ${postFlg} Remittance_Suspence ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
         report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
        " > $datFile
        cp $datFile salsup.dat
        mcbx4024 $B2K_SESSION_ID < salsup.dat
        echo `head -1 TRAN_INFO.dat` >> salUpld.txt
else
        echo "Suspence Account transaction file is empty."
fi

echo "$fileName1 ${postFlg} ${renameFlg}
MANAGER ${tranSub} $fileName1 ${postFlg} Remittance_commission ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile salchg.dat
mcbx4024 $B2K_SESSION_ID < salchg.dat
echo `head -1 TRAN_INFO.dat` >> salUpld.txt
if [ ${renameFlg} == "Y" ]
then
        mv ${upldFilePath} ${upldFilePath}.done
fi

if [ -s "${fileName4}" ]
then
	exebatch babx4040 ${B2K_SESSION_ID} $FIN_REPORTS_DIR/${userid}/${fileName4}  "SALARY UPLOAD FAILED RECORDS" "MANAGER" "1" "N"
fi

exit 0
#Deleting files after processing
rm -f ${fileName1} 
#rm -f ${fileName2} 
rm -f ${fileName3} 
rm -f ${fileName4} 
exit 0
