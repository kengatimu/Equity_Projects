#############################################################################################
# Source Name          : custEITRep_cr00719mn001.com
# Date                 : 21-10-2012
# Description          : This is a com for the report
# Input Values         : inputStr
# Output Values        : PDF file
# Called Script        : custEITRep_cr00719mn002.scr
# Calling Script       : NA
# Author               : Parikshith V
# Bank                 : EQUITY BANK
# Modification History :
# <Version No.>    <Date>     <Author Name>         <Description>
#   1            21-10-2012   Parikshith V	Original Version
#############################################################################################
. `execom commfunc.com`
set -vx

inputStr=$1
inputStr=$inputStr"!"$$

reportFile="eitbatch_$$.txt"

#******************************************************************************************
#   SQL Execution
#******************************************************************************************
    exebatch spbx4001 CUSTOM.c_eit_fetch_pack.c_eit_fetch_proc $inputStr >> $reportFile
    if [ $? -ne 0 ]
    then
        exit 1
    fi
#******************************************************************************************

#******************************************************************************************
#Pushing The Report To Backround Menu
#******************************************************************************************
  exebatch babx4040 $B2K_SESSION_ID $reportFile "EITI Batch Execution Report" "MANAGER" 1 N
  if [ $? -ne 0 ]
  then
    exit 1
  fi
#*******************************************************************************************
  exit 0
