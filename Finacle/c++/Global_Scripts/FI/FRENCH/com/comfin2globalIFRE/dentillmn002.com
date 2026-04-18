#----------------------------------------------------------------------------------------------------
# Source Name                   : dentillmn002.com
# Author                        : Sandeep Patil
# Date                          : 28-JUL-2010
# Called Scripts                : dentillmn001.scr
# Calling Script                : NA
# Bank                          : STANDARD BANK
# Module                        : DENOM
# Menu Name                     : HDENTILL
# Modification History          :
#       <Sr. No.>       <Date>          <Author>                <Description>
#       0.1             28-JUL-2010     Sandeep Patil           Draft Version
#----------------------------------------------------------------------------------------------------

. `execom commfunc.com`
set -vx
#******************************************************************************************
#******************************************************************************************
#   MAIN SCRIPT
#******************************************************************************************
solid=$1
headersolid=$2
CRNCY_CODE=$3
BANK_ID=$4
report=DENVAULT
Report="Vault Position Inquiry"
RptFile=$headersolid"_"$report"$$"
RptFile1=$headersolid"_"$report"$$.PDF"
MrtFile=dentillmn002.jasper
LstFile=$headersolid"_"$report"$$.lst"
#******************************************************************************************
#   SQL Execution
#******************************************************************************************
    exebatch spbx4001 custom.FIN_DENVAULT_PACK.FIN_DENVAULT_PROC "$solid" "$headersolid" "$CRNCY_CODE" "$BANK_ID"> $LstFile
	if test ! -s "$LstFile"
    then
                echo $LstFile does not exist or is empty.
                echo "||||||||$solid|$soldesc" >$LstFile
    fi
    if [ $? -ne 0 ]
    then
        echo "SQL  execution failed !"
		exit 0
    fi    
#******************************************************************************
    FINRPT_SERVER_NAME=FINRPTSRVR
    export FINRPT_SERVER_NAME
    FINRPT_CLIENT_SOCKARRAY_SIZE=10
    export FINRPT_CLIENT_SOCKARRAY_SIZE
 #     mrbx4004 $B2K_SESSION_ID $MrtFile $LstFile $RptFile1 -f 1YYYY1
#	mrbx4004 $B2K_SESSION_ID $MrtFile $LstFile $RptFile1 -f 1YNNN1
      mrbx4004 $B2K_SESSION_ID $MrtFile $LstFile $RptFile 
    if [ $? -ne 0 ]
    then
        echo "Report Generation  Failed !"
		exit 0
    else
#***************************************************************************
#***************************************************************************
#Pushing The Report To Backround Menu
#******************************************************************************
#       no_of_page_break=`cat ${1}|grep '^L'|wc -l`
#       no_of_pages=`expr ${no_of_page_break} + 1`

        exebatch babx4040 "${B2K_SESSION_ID}" "$RptFile1" "$Report" "MANAGER" "1" N
        if [ $? -ne 0 ]
        then
            echo "Report Generated. To View/Print, Use HPR Menu."
            rm -f $LstFile  $DatFile $RipFile
        fi
    fi
#**************************************************************************
exit 0

