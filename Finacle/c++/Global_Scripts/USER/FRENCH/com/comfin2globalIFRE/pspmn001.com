#*********************************************************************
#       Author          : Bharath
#
#**********************************************************************
set -vx

#reportFileName="egokb${fromDate}-${toDate}.rpt"
reportFileName=$pspVal2
lstFileName=$pspVal1
#mrtFileName="pspfull1cust.mrt"
mrtFileName=${pspVal13}


ripFileName="psp${$}.rip"
datFileName="psp${$}.dat"
#userid=`pwd|awk -F "/" '{print $NF}'`
userid=${pspVal12}
rptpath="$FIN_REPORTS_DIR/${userid}/"

echo page_number=\"${pspVal3}\" > $datFileName
echo pr_station=\"${pspVal4}\" >> $datFileName
echo email_post_ind=\"${pspVal5}\" >> $datFileName
echo acDateRange=\"${pspVal6}\" >> $datFileName
echo ac_name=\"${pspVal7}\" >> $datFileName
echo ac_crncy_code=\"${pspVal8}\" >> $datFileName
echo p_code=\"${pspVal9}\" >> $datFileName
echo cit_desc=\"${pspVal10}\" >> $datFileName
echo preferEmailId=\"${pspVal11}\" >> $datFileName
echo cifaddr1=\"${pspVal14}\" >> $datFileName
echo acct_Num=\"${pspVal15}\" >> $datFileName
echo sch_desc=\"${pspVal16}\" >> $datFileName
${TBA_PROD_ROOT}/prodbase/INFENG/com/newrepos.com $ripFileName $datFileName
cp ${rptpath}$ripFileName $ripFileName

exebatch mrbx4004 $B2K_SESSION_ID  $mrtFileName ${lstFileName} $reportFileName $ripFileName
if [ $? -ne 0 ]
then
	echo "Report Generation Failed !"
	exit 2
else
	echo "Report generated. To See/Print the report go to BackGround Menu ."
fi

noOfPages=`grep -c "" "${rptpath}$reportFileName.rpt"`
noOfPages=`expr "${noOfPages}" + 1`
exebatch babx4040 "${B2K_SESSION_ID}" "${rptpath}$reportFileName.rpt" "Statement Of Accounts Report - Final" "MANAGER" "${noOfPages}" Y

if [ "x$TBA_DEBUG" = "x" ]
then
    rm -f $lstFileName
    rm -f $datFileName
    rm -f $ripFileName
fi

unset pspVal1
unset pspVal2
unset pspVal3
unset pspVal4
unset pspVal5
unset pspVal6
unset pspVal7
unset pspVal8
unset pspVal9
unset pspVal10
unset pspVal11
unset pspVal12
unset pspVal13
unset pspVal14
unset pspVal15
unset pspVal16
exit 0
