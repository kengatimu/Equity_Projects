#------------------------------------------------------------------------------------------------------------------    
#	Name			: ebkSalProof.com
#	Description		: It will generate a bad and log file report
#	Date			: 13-03-2013
#	Author			: GOKULKRISHNA
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				13-03-2013		GOKULKRISHNA	Original Version
#	2.0				18-07-2013		BHARATH			Validation added for other currency accounts
#	3.0				27-10-2013		BHARATH			Initiating process in background
#--------------------------------------------------------------------------------------------------------------------
. `execom commfunc.com`
set -vx

userid=`pwd|awk -F "/" '{print $NF}'`
rptFile="$FIN_REPORTS_DIR/${userid}/${fileName}.lst"
log_file=${fileName}"_sal_process.log"
bad_file=$FIN_REPORTS_DIR/${userid}/${fileName}"_sal_process.bad"
tempFile="salupld_${$}.txt"

test -d $FIN_REPORTS_DIR/${userid}
if [ $? -ne 0 ]
then
    mkdir $FIN_REPORTS_DIR/${userid}
fi

#----------------------------------------------
# uploading flat file data to custom table
#----------------------------------------------
#TimeComp=`date| tr -s " " | cut -f4 -d" " |sed 's/://g' `
#DateComp=`date| tr -s " " | cut -f2,3 -d" " |sed 's/ //g' `

sed 's/$/|'${bankId}'/g' ${inputFilePath} > ${tempFile}

$ORACLE_HOME/bin/sqlldr ${USER_PASS} control= "${CTL_PATH}salary.ctl" data= "${tempFile}" LOG=${log_file} BAD=${bad_file}
if [ $? -ne 0 ]
then
	test -f ${bad_file}
	if [ $? -eq 0 ]
	then
		exebatch babx4040 ${B2K_SESSION_ID} ${bad_file}  "SALARY UPLOAD ERROR" "MANAGER" "1" "N"
		if [ $? -ne 0 ]
		then
			echo "Report Generated. To View/Print, Use HPR Menu." 
		fi
	fi
fi

#----------------------------------------------
# Processing and generating report
#----------------------------------------------
exebatch bauu9151 ebkSalProof_process.sql ${sqlInput} ${drAcctCrncy}
cp ${fileName}.lst ${rptFile}

exebatch babx4040 ${B2K_SESSION_ID} ${rptFile}  "SALARY STATUS" "MANAGER" "1" "N"
if [ $? -ne 0 ]
then
    echo "Report Generated. To View/Print, Use HPR Menu." 
fi

#----------------------------------------------
# Deleting file after processing
#----------------------------------------------
rm -f ${fileName}.lst
rm -f ${tempFile}
exit 0

