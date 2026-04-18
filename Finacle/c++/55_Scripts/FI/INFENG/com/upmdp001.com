#======================================================================================================================*
# Source Name           :   upmdp001.com
# Author                :   Venkatesh
# Description           :   This COM file is used for generation of report for Temp Role ID Role back
# <Serial No.>  <Date>              <Author Name>                              <Description>
# 0.1           11-06-2013            Venkatesh                               Original Version
#=======================================================================================================================*
rptType="$1"
lstFileName="$2"
reportFileName="$3"
if [ "$1" = "Success" ]
then
jrtFileName="upmdp001.jasper"
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

