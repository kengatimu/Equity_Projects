#------------------------------------------------------------------------------------------------------------------    
#	Name			: crmuplBatchMain.com
#	Description			: It will generate a bad and log file report
#	Date			: 02-02-2024
#	Author			: 
#	Input			: NA
#	Output			: NA
#	Srl. No			Date		Author			Description.   
#	-------			---------		-------			---------------			
#	1.0			02-02-2024			         Original Version
#--------------------------------------------------------------------------------------------------------------------
. `execom commfunc.com`
set -vx

crmuplLogFile='crmuplLogs_'${CrmuplRefNum}'.txt'

echo 'CRMUPL COM start' >> ${crmuplLogFile}
echo ${CrmuplRefNum} >> ${crmuplLogFile}
echo ${CrmuplEmpId} >> ${crmuplLogFile}
echo ${Crmuplworkfile} >> ${crmuplLogFile}
echo ${CrmuplRptFile} >> ${crmuplLogFile}
echo ${CrmuplFunc} >> ${crmuplLogFile}



if [ ${CrmuplFunc} == "U" ]
then
    echo 'Uploaded cif start' >> ${ccrrmLogFile}
	#Custom start here
	set -vx
	bankId=`echo $FIN_BANK_ID`
	echo $bankId
	#cd /equity_be/EQUAT/BackEnd/Finacle/FC/app/CDCI_LOGS/DK06181
	nopj="5"
	CcrrmRefNum="REF10035"

	sleep 1
	echo "set head off;">${CrmuplRefNum}mcal.sql
	echo "set trimspool on;">>${CrmuplRefNum}mcal.sql
	echo "set trimout on;">>${CrmuplRefNum}mcal.sql
	echo "set pages 0;">>${CrmuplRefNum}mcal.sql
	echo "set feedback off;">>${CrmuplRefNum}mcal.sql
	echo "set linesize 32767;">>${CrmuplRefNum}mcal.sql
	echo "set echo off;">>${CrmuplRefNum}mcal.sql
	echo "set long 90000;">>${CrmuplRefNum}mcal.sql
	echo "spool ${CrmuplRefNum}_mcal.DAT;">>${CrmuplRefNum}mcal.sql
	echo "select CIF_ID||'|'||CUST_TYPE||'|'||RM||'|'||RCRE_USER_ID from custom.CUSTOM_RM_UPDATE_CIF where   RCRE_USER_ID='${CrmuplEmpId}' and bank_id='${bankId}' and ref_code='${CrmuplRefNum}'; " >> ${CrmuplRefNum}mcal.sql  
	echo "spool off;">>${CrmuplRefNum}mcal.sql
	exebatch bauu9151 ${CrmuplRefNum}mcal.sql
	#rm -f ${CrmuplRefNum}mcal.sql
	sleep 1
	exebatch -i ${CrmuplRefNum}_mcal.DAT -n ${nopj} babx4061 $B2K_SESSION_ID crmupl_mod_Fi.scr ${CrmuplRefNum} ${CcrrmEmpId} ${Ccrrmworkfile} ${CrmuplRptFile} ${CcrrmFunc} @s
	
	exit 0

	#custom ends here

	#nohup exebatch babx4061 $B2K_SESSION_ID ccrrm_FI_Modf.scr ${CcrrmRefNum}  ${CcrrmEmpId}  ${Ccrrmworkfile}  ${CcrrmRptFile}  ${CcrrmFunc}  @s
	echo $UPLOAD_INPUT_FILE_PATH

	uploadfile=$UPLOAD_INPUT_FILE_PATH"/"${CrmuplEmpId}

	echo ${uploadfile} >> ${crmuplLogFile}

	test -d ${uploadfile} 
	if [ $? -ne 0 ]
	then
		mkdir ${uploadfile}
	fi

	CccrmFilepath=$ONS_LOG_DIR"/"${CrmuplEmpId}"/"${Crmuplworkfile}

	test -f ${CrmuplFilepath}

	if [ $? -eq 0 ]
	then
		mv ${CrmuplFilepath} ${uploadfile}
		echo 'Upload file moved successfully' >> ${crmuplLogFile}
	fi

	
elif [ ${CrmuplFunc} == "V" ]
then
	echo 'Verification cif start' >> ${crmuplLogFile}
	nohup exebatch babx4061 $B2K_SESSION_ID ccrrm_FI_Verify.scr ${CrmuplRefNum}  ${CrmuplEmpId}  ${CrmuplRptFile}  ${CrmuplFunc}  @s

	
	echo 'Verification Ends' >> ${crmuplLogFile}
	
	
else
	echo 'Empty function code' >> ${crmuplLogFile}
fi


exit 0
