#----------------------------------------------------------------------------------------- 
#       Author                  : Shishira 
#       Date                    : 11-03-2013
#       com Name                : oclgirptdp001.com
#       Input Parameters        : Sol Id,
#       Purpose Of this File    : 
#       Modification History    :
#       <Serial No.>      <Date>           <Author Name>           <Description>
#        	0.01       28-02-2012		Shishira  		Original 
#----------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------
#       MAIN SCRIPT
#----------------------------------------------------------------------------------------
	Report="Inhs Bankers chqs Clrg File"
	SqlFile=oclgirpt.sql
	LstFile="oclgirpt_$$.TXT"
	reportFileName="oclgibcqs_$1_$2.rpt"
	logfile="oclgirpt.log"
	solId=$1
	zoneDate=$2
	zoneCode=$3
	bankId=$4
#----------------------------------------------------------------------------------------
#       SQL Execution
#----------------------------------------------------------------------------------------
#	exebatch spbx4001 CUSTOM.OCLGIRPT_PACK_RD.OCLGIRPT_PROC_RD $solId $zoneDate $zoneCode $bankId > $LstFile
	spbx4001 CUSTOM.OCLGIRPT_PACK_RD.OCLGIRPT_PROC_RD $solId $zoneDate $zoneCode $bankId > $LstFile 
	if [ $? -ne 0 ]
	then
		echo "SQL execution failed !"
		exit 0
	fi

cat $LstFile > $reportFileName
#----------------------------------------------------------------------------------------
#Setting the path for file 
#----------------------------------------------------------------------------------------
	RptFile=/$LstFile
#----------------------------------------------------------------------------------------
#Pushing The Report To Backround Menu
#----------------------------------------------------------------------------------------
noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1` 

#exebatch babx4040 ${B2K_SESSION_ID} $reportFileName "$Report" "MANAGER" "$noOfPages" "N"
babx4040 ${B2K_SESSION_ID} $reportFileName "$Report" "MANAGER" "$noOfPages" "N"
		if [ $? -ne 0 ]
		then
			echo "Report Generated. To View/Print, Use HPR Menu." >>$logfile
		fi
rm -f $LstFile *lst *LST 
exit 0
