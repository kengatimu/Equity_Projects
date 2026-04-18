#------------------------------------------------------------------------------------------------------------------    
#	Name			: cchqidp001.com
#	Description		: This com file is used to generate report
#	Date			: 17-12-2013
#	Author			: Bharath
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				17-12-2013		BHARATH			Original Version
#--------------------------------------------------------------------------------------------------------------------
. `execom commfunc.com`
set -vx

userid=`pwd|awk -F "/" '{print $NF}'`
fileName="cchqi${$}.rpt"
rptFile="${FIN_REPORTS_DIR}/${userid}"

test -d $FIN_REPORTS_DIR/${userid}
if [ $? -ne 0 ]
then
    mkdir $FIN_REPORTS_DIR/${userid}
fi

echo $date

echo $date
if test "$date" != "NA"
then

	exebatch bauu9151 cchqidp001.sql \'${solid}\' \'${date}\' \'${foracid}\' \'${status}\' ${bankId} ${fileName}
else

	exebatch bauu9151 cchqidp002.sql \'${solid}\' \'${date}\' \'${foracid}\' \'${status}\' ${bankId} ${fileName}
fi

if [ $? -eq 0 ]
then
	test -s ${fileName}
	if [ $? -eq 0 ]
	then
		cp ${fileName} ${rptFile}/${fileName}
		exebatch babx4040 ${B2K_SESSION_ID} ${fileName}  "Cheque Book Inquiry Report" "MANAGER" "1" "N"
		if [ $? -ne 0 ]
		then
			echo "Report Generation Failed." 
		fi
	fi
fi

exit 0
#----------------------------------------------
# Deleting temporary file after processing
#----------------------------------------------
rm -f ${fileName}
