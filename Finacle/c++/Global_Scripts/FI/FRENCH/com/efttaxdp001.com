#*********************************************************************
#       Author          : Bharath
#
#**********************************************************************
set -vx
#reportFileName="Egoceftvat${fromDate}-${toDate}.rpt"
reportFileName="Egoceftvat-${toDate}"
lstFileName="eftvat${$}.lst"
ripFileName="eftvat${$}.rip"
mrtFileName="eftvat.mrt"
datFileName="eftvat${$}.dat"
userid=`pwd|awk -F "/" '{print $NF}'`
rptpath="$FIN_REPORTS_DIR/${userid}/"

echo ipSetId=\"${fromDate}\" > $datFileName
echo asonDate=\"${toDate}\" >> $datFileName

input=`echo $fromDate\!$toDate\!$field_3`

${TBA_PROD_ROOT}/prodbase/INFENG/com/newrepos.com $ripFileName $datFileName

#exebatch bauu9151 eftvat.sql "${fromDate}" "${toDate}" "${field_3}" 
exebatch bauu9151 eftvat.sql "${toDate}" "${bankId}" "${lstFileName}"
if [ $? -ne 0 ]
then
	echo "SQL procedure execution for eftvat.sql failed !"
	exit 1
fi

exebatch mrbx4004 $B2K_SESSION_ID  $mrtFileName ${lstFileName} $reportFileName $ripFileName
if [ $? -ne 0 ]
then
	echo "Report Generation Failed !"
	exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

mv ${rptpath}$reportFileName.rpt ${rptpath}$reportFileName.txt
noOfPages=`grep -c "^L" "${rptpath}$reportFileName.txt"`
noOfPages=`expr "${noOfPages}" + 1`
exebatch babx4040 "${B2K_SESSION_ID}" "${rptpath}$reportFileName.txt" "VATPAYE Tax Clearing File" "MANAGER" "${noOfPages}" Y

if [ "x$TBA_DEBUG" = "x" ]
then
	rm -f $lstFileName
	rm -f $datFileName
	rm -f $ripFileName
fi

exit 0
