#======================================================================================================================*
# Source Name           :   islbaldp001.com
# Author                :   Priyanka 
# Description           :   This COM file is used for generation of report for Islamic GL transaction
# <Serial No.>  <Date>              <Author Name>                              <Description>
# 0.1           24-06-2013            Priyanka                               Original Version
#=======================================================================================================================*
rptType="$1"
lstFileName="$2"
reportFileName="$3"
if [ "$1" = "Success" ]
then
jrtFileName="islbaldp001.jasper"

fi

exebatch mrbx4004   $B2K_SESSION_ID $jrtFileName $lstFileName $reportFileName
if [ $? -ne 0 ]
then
      echo "SQL Procedure  hcaprpt001.hcaprpt001 failed!"
      exit 1
fi

cp $reportFileName*PDF $4
noOfPages=`grep -c "^L" "$reportFileName".PDF`
noOfPages=`expr "${noOfPages}" + 1`

exebatch babx4040 "${B2K_SESSION_ID}" "$reportFileName.PDF" "$5" "MANAGER" "${noOfPages}" N

exit 0
