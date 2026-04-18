
#======================================================================
#   file        : dn.com
# 	Description : This com script writes temporary DAT file and passes
#				  the DAT file as input to the batch exe baor5043.

#----------------------------------------------------------
# create the temporary DAT file
#----------------------------------------------------------
touch temp_$$.DAT

#----------------------------------------------------------
# print the data into the file in the required format. The
# data to the DAT file are passed by the environment
# variables which are set in the script.
#---------------------------------------------------------

file=temp_$$.DAT
echo $ReportTo>>${file}
echo $SolId>>${file}
echo $CustId>>${file}
echo $GlSubHeadCode>>${file}
echo $SchmCode>>${file}
echo $CrncyCode>>${file}
echo $FromAcRange>>${file}
echo $ToAcRange>>${file}
echo $FromMatDate>>${file}
echo $ToMatDate>>${file}
echo $SafeCustody>>${file}
echo $AutoRenew>>${file}
echo $PricipalCust>>${file}
echo $MrtFileName>>${file}
echo $LienAc>>${file}
echo $DepositType>>${file}
echo $Test1>>${file}
echo $Test2>>${file}
echo $Test3>>${file}
echo $Test4>>${file}
echo $Test5>>${file}
echo $Test6>>${file}
echo $Test7>>${file}
echo $Test8>>${file}
echo $Test9>>${file}

#-----------------------------------------------------------------------------
# Execute the batch exe by passing $1 as the first argument ($1 is session id)
#-----------------------------------------------------------------------------

exebatch baor5043 $1 <${file}

#-----------------------------------------------------------------------------
# remove the temporary file
#-----------------------------------------------------------------------------
rm -f ${file}
exit

