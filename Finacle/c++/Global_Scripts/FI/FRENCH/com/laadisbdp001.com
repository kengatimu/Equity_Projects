#=================================================================================================================*
# Name                          :   laadisbdp001.com 
# Date                          :   05-08-2013
# Description                   :   This com is used to send tranid from file to script
# Author                        :   Bharath Reddy
# Reference                     :
# Modification History  :
#  <Serial No.>  <Date>         <AuthorName>            <Description>
#--------------------------------------------------------------------------
#   1           05-08-2013      Bharath Reddy           Original version
#=================================================================================================================*
tranId=`cat LADTmpTran.txt`
x="\""
echo "CUST.LADISB.chrgId=$x$tranId$x" > $1
rm -f LADTmpTran.txt
