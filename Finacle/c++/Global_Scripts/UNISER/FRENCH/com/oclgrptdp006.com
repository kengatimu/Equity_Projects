#----------------------------------------------------------------------------------------- 
#       Author                  : Shishira 
#       Date                    : 11-03-2013
#       com Name                : oclgrptdp006.com
#       Input Parameters        : Sol Id,zoneDate,zoneCode,bankId
#       Purpose Of this File    : 
#       Modification History    :
#       <Serial No.>      <Date>           <Author Name>           <Description>
#        	0.01       28-02-2012		Shishira  		Original 
#        	0.02       25-04-2013		Shishira  		Added Page No 
#        	0.03       12-06-2013		Shishira  		Added "No record found" msg
#----------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------
#       MAIN SCRIPT
#----------------------------------------------------------------------------------------
        Report="Inhouse Cheques Clearing File"
        SqlFile=oclgrptmn006.sql
        LstFile="oclgrpt2_$$.TXT"
        reportFileName="oclgbcqs2_$1_$2.rpt"
        logfile="oclgrpt2.log"
	solId=$1
	zoneDate=$2
	zoneCode=$3
	bankId=$4
#----------------------------------------------------------------------------------------
#       SQL Execution
#----------------------------------------------------------------------------------------
#	exebatch spbx4001 CUSTOM.OCLGRPT_Pack_10.OCLGRPT_PROC_10 $solId!$zoneDate!$zoneCode!$bankId > $LstFile
	spbx4001 CUSTOM.OCLGRPT2_PACK_10.OCLGRPT2_PROC_10 $solId!$zoneDate!$zoneCode!$bankId > $LstFile 
	if [ $? -ne 0 ]
	then
		echo "SQL execution failed !"
		exit 0
	fi
        if test ! -s "$LstFile"
        then
                echo "No Record Found" >$LstFile
        fi
#----------------------------------------------------------------------------------------
#       If No Record Found
#----------------------------------------------------------------------------------------
        if test ! -s "$LstFile"
        then
                echo No Record Found >> $LstFile
        fi

#----------------------------------------------------------------------------------------
#Setting the path for file 
#----------------------------------------------------------------------------------------
	RptFile=/$LstFile
cat $LstFile>$reportFileName
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

    rm -f $LstFile
exit 0
