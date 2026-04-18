#------------------------------------------------------------------------------------------------------------------    
#	Name			: ccrrmbatchMain.com
#	Description		: It will generate a bad and log file report
#	Date			: 02-02-2024
#	Author			: JAMES GICHIRI
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				02-02-2024		JAMES GICHIRI	Original Version
#--------------------------------------------------------------------------------------------------------------------
. `execom commfunc.com`
set -vx

ccrrmLogFile='ccrrmLogs_'${CcrrmRefNum}'.txt'

echo 'CCRRM COM start' >> ${ccrrmLogFile}
echo ${CcrrmRefNum} >> ${ccrrmLogFile}
echo ${CcrrmEmpId} >> ${ccrrmLogFile}
echo ${Ccrrmworkfile} >> ${ccrrmLogFile}
echo ${CcrrmRptFile} >> ${ccrrmLogFile}
echo ${CcrrmFunc} >> ${ccrrmLogFile}

if [ ${CcrrmFunc} == "U" ]
then
    echo 'Uploaded cif start' >> ${ccrrmLogFile}
	nohup exebatch babx4061 $B2K_SESSION_ID ccrrm_FI_Modf.scr ${CcrrmRefNum}  ${CcrrmEmpId}  ${Ccrrmworkfile}  ${CcrrmRptFile}  ${CcrrmFunc}  @s
	echo $UPLOAD_INPUT_FILE_PATH

	uploadfile=$UPLOAD_INPUT_FILE_PATH"/"${CcrrmEmpId}

	echo ${uploadfile} >> ${ccrrmLogFile}

	test -d ${uploadfile} 
	if [ $? -ne 0 ]
	then
		mkdir ${uploadfile}
	fi

	CccrmFilepath=$ONS_LOG_DIR"/"${CcrrmEmpId}"/"${Ccrrmworkfile}

	test -f ${CccrmFilepath}

	if [ $? -eq 0 ]
	then
		mv ${CccrmFilepath} ${uploadfile}
		echo 'Upload file moved successfully' >> ${ccrrmLogFile}
	fi

	
elif [ ${CcrrmFunc} == "V" ]
then
	echo 'Verification cif start' >> ${ccrrmLogFile}
	nohup exebatch babx4061 $B2K_SESSION_ID ccrrm_FI_Verify.scr ${CcrrmRefNum}  ${CcrrmEmpId}  ${CcrrmRptFile}  ${CcrrmFunc}  @s

	
	echo 'Verification Ends' >> ${ccrrmLogFile}
	
	
else
	echo 'Empty function code' >> ${ccrrmLogFile}
fi


exit 0
