#======================================================================================================================*
# Source Name           :  psp.com 
# Author                :  Nithya Murugesan
# Description           :  This com file is used to get the report file name of HPSP
# <Serial No.>  <Date>              <Author Name>                              <Description>
# 0.1           22-07-2013           Nithya Murugesan                         Original Version          
#=======================================================================================================================*
#. `execom commfunc.com`
set -vx
reportFileName=$MRT_OUTPUT_FILENAME
lstFileName=$MRT_LST_FILENAME
Rpid=$1
echo $reportFileName >> $Rpid
chmod 777 psp.log
echo "Success"
exit 0
