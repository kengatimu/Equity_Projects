#-------------------------------------------------------------------------------------    
#    Name				:slnpppagedp001.com 
#    Description     	: 
#    Date            	: 27-02-2013
#    Author          	: DhanaPrabhakaran
#    Input           	: NA
#    Output				: NA
#    Called Script 		: NA
#    Calling Script 	: getcparamvalue.scr
#    Menu Option		: CSLNPP
#    Srl. No			Date			Author			Description.   
#    -------			----			------			----------------
#    1.0				27-02-2013		 DhanaPrabhakaran 		Original Version
#------------------------------------------------------------------------------------- 
set -vx
reportFileName="StaffLn${$}"
lstFileName="StaffLnLst${$}.lst"
errorFileName="staffLnErr${$}.rpt"
mrtFileName="slnpppagedp001.mrt"
tempfile="tmp${$}.txt"
tempRptFile="tempRptFile${$}.txt"

#-----------------------------------------------------------------------------------
#------Checking if directory is present and creating directory
#-----------------------------------------------------------------------------------
userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"
rptpath="$FIN_REPORTS_DIR/${userid}"
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

$TBA_E/bauu9151 slnpppagedp002.sql ${bankId}

sed 's/$/|'${bankId}'/g' ${DATA_PATH}/${userid}/${upldFileName} > $tempfile

$ORACLE_HOME/bin/sqlldr ${USER_PASS} control=${CTL_PATH}StaffSal.ctl  data=$tempfile

$TBA_E/bauu9151 slnpppagedp001.sql ${bankId} ${lstFileName} \'${remarks}\' ${homeCrncy} ${errorFileName} 
cp ${errorFileName} ${rptpath}/${errorFileName}

chmod 777 $lstFileName
chmod 777 $errorFileName

$TBA_E/mrbx4004 $B2K_SESSION_ID $mrtFileName $lstFileName $reportFileName 

sed 's/\~/ /g' ${rptpath}/${reportFileName}.rpt > ${tempRptFile}
sed '1d' ${tempRptFile} > ${rptpath}/${reportFileName}.rpt 
#cp ${tempRptFile} ${rptpath}/${reportFileName}.rpt

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
    noOfPages=`grep -c "^L" "${errorFileName}"`
    noOfPages=`expr "${noOfPages}" + 1`
    babx4040 "${B2K_SESSION_ID}" "${rptpath}/${errorFileName}" "Staff Salaries Upload Error File" "MANAGER" "${noOfPages}" N
fi

if [ -s "${rptpath}/${reportFileName}.rpt" ]
then
	noOfPages=`grep -c "^L" "${reportFileName}.rpt"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 "${B2K_SESSION_ID}" "${rptpath}/${reportFileName}.rpt" "Staff Loan Recoveries Upload Text File  " "MANAGER" "${noOfPages}" N
fi

exit 0
if [ "x$TBA_DEBUG" = "x" ] 
then
    rm -f $lstFileName
	rm -f ${errorFileName}
	rm -f $tempfile
	rm -f $tempRptFile
fi

exit 0
