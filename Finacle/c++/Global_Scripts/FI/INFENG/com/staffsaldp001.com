#------------------------------------------------------------------------------------------------    
#    Name			 : staffsaldp001.com
#    Description     : 
#    Date            : 24-02-2013
#    Author          : Prakash
#    Input           : NA
#    Output			 : NA
#    Called Script	 : NA
#    Calling Script	 : NA
#    Menu Option	 : CSSALPP
#    Srl. No			Date			Author			Description.   
#    ------			----------			-------			---------------			
#    1.0			24-02-2013			Prakash			Original Version
#	 2.0            04-06-2013			Prakash			Bank Id added to dat file dyanamically.
#-----------------------------------------------------------------------------------------------
set -vx
reportFileName="StaffSal${$}"
lstFileName="StaffSal_${$}.lst"
errorFileName="salppErr_${$}.rpt"
mrtFileName="StaffSal.mrt"
tempfile="StaffSaltemp${$}.dat"

#-----------------------------------------------------------------------------------
#------Checking if directory is present and creating directory
#-----------------------------------------------------------------------------------
userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"
rptpath="$FIN_REPORTS_DIR/${userid}"
tempRptFile="tempRptFile${$}.txt"
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

#----------------------------------------------------------------------------------------
#       SQL Execution
#----------------------------------------------------------------------------------------
sed 's/$/|'${bankId}'/g' ${DATA_PATH}/${userid}/${upldFileName} > $tempfile

$ORACLE_HOME/bin/sqlldr ${USER_PASS} control= "${CTL_PATH}StaffSal.ctl" data=$tempfile 

$TBA_E/bauu9151 staffsaldp002.sql ${bankId} \'${remarks}\'  $lstFileName ${errorFileName} ${homeCrncy} 
if [ $? -ne 0 ]
then
	echo "SQL execution failed !"
	exit 1
fi

cp ${errorFileName} ${rptpath}/${errorFileName}

$TBA_E/mrbx4004 $B2K_SESSION_ID $mrtFileName $lstFileName $reportFileName

sed 's/\~/ /g' ${rptpath}/${reportFileName}.rpt > ${tempRptFile}
cp ${tempRptFile} ${rptpath}/${reportFileName}.rpt
cp ${rptpath}/${reportFileName}.rpt ${upldpath}/${reportFileName}.rpt

if [ $? -ne 0 ]
then
	echo "Report Generation Failed !"
	exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

if [ -s "${errorFileName}" ]
then
	noOfPages=`grep -c "^L" "$errorFileName"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 "${B2K_SESSION_ID}" "${rptpath}/$errorFileName" "Staff Salaries Upload Error File" "MANAGER" "${noOfPages}" N
fi

if [ -s "${rptpath}/${reportFileName}.rpt" ]
then
	noOfPages=`grep -c "^L" "${rptpath}/$reportFileName.rpt"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 "${B2K_SESSION_ID}" "${rptpath}/$reportFileName.rpt" "Staff Salaries Upload Text File  " "MANAGER" "${noOfPages}" N
fi

exit 0
#Deleting files after processing
rm -f $tempfile
rm -f $tempRptFile
rm -f $lstFileName
rm -f ${errorFileName}

if [ "x$TBA_DEBUG" = "x" ] 
then
	rm -f $tempfile
	rm -f $lstFileName
	exit 0
fi

exit 0
