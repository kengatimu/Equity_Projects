#======================================================================================================================*
# Source Name           :  psp.com 
# Author                :  Nithya Murugesan
# Description           :  This com file is used to get the report file name of HPSP
# <Serial No.>  <Date>              <Author Name>                              <Description>
# 0.1           22-07-2013           Nithya Murugesan                         Original Version          
#=======================================================================================================================*
#. `execom commfunc.com`
set -vx
Rpid=$1
ls -ltr $2/T*LST |tail -n 1| awk '{print $9}' >> $Rpid 
chmod 777 $Rpid
echo "Success"
exit 0
