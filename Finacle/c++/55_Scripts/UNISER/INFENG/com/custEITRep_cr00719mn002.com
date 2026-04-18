#############################################################################################
# Source Name          : custEITRep_cr00719mn002.com
# Date                 : 21-10-2012
# Description          : This is a com for the report
# Input Values         : reportFile,jasperFile,lstFile,pdfFile,reportTitle,procName,owner,inputStr
# Output Values        : PDF file
# Called Script        : intrptmn001.scr
# Calling Script       : NA
# Author               : Parikshith V
# Bank                 : EQUITY BANK
# Modification History :
# <Version No.>    <Date>     <Author Name>         <Description>
#   1            21-10-2012   Parikshith V	Original Version
#############################################################################################
. `execom commfunc.com`
set -vx
reportTitle="Customer Interest Report"
jasperFile="FIN_GL_CUSTEITRPT.jasper"
reportFile="CUSTEITRPT_$$"
pdfFile="CUSTEITRPT_$$.XLS"
owner="MANAGER"
inputStr=$inputStr

lstFile="CUSTEITRPT_$$.lst"

#******************************************************************************************
#   SQL Execution
#******************************************************************************************
    exebatch spbx4001 CUSTOM.intrpt_report_pack.intrpt_report_proc $inputStr > $lstFile
    if [ $? -ne 0 ]
    then
        exit 1
    fi


#******************************************************************************************
#   Generate Report
#******************************************************************************************
    exebatch mrbx4004 $B2K_SESSION_ID $jasperFile $lstFile $reportFile
    if [ $? -ne 0 ]
    then
        exit 1
    fi

#******************************************************************************************

#******************************************************************************************
#Pushing The Report To Backround Menu
#******************************************************************************************
  exebatch babx4040 $B2K_SESSION_ID $pdfFile "$reportTitle" $owner 1 N
  if [ $? -ne 0 ]
  then
    exit 1
  fi
#*******************************************************************************************
  exit 0
