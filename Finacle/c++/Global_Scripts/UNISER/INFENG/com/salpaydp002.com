#---------------------------------------------------------------------------------
#--    File Name                  : salpaydp002.com
#--    Date                       : 15.03.2013
#--    Author                     : Prakash
#--    Assumptions                : NIL
#--    Modification History		:
#--    <Serial No.>    <Date>        <Author Name>                <Description>
#--       1.          15.03.2013     Prakash                  Original Version
#-----------------------------------------------------------------------------------
set -vx
chgrcode = $1
trandate = $2
tranid = $3
eventid = $4
echo $1 $2 $3 $4
exebatch babx4061 ${B2K_SESSION_ID} salpaydp002.scr $1 $2 $3 $4 
#exebatch babx4061 ${B2K_SESSION_ID} salpaydp002.scr ${chgrcode} ${trandate} ${tranid} ${eventid} 

ListFile1="sucess.lst"
ListFile2="failure.lst"
ListFile3="L1.lst"
ListFile4="L2.lst"
OutputReport1="SALAPYSUCESS${$}.RPT"
OutputReport2="SALAPYFAILS${$}.RPT"

#-----------------------------------------------------------------------------
# Generation report through mrt execution
#-----------------------------------------------------------------------------

sed '1d' $ListFile1 >$ListFile3

sed '1d' $ListFile2 >$ListFile4

mrbx4001 salpaydp003.mrt $ListFile3 $OutputReport1 

mrbx4001 salpaydp003.mrt $ListFile4 $OutputReport2 

#-----------------------------------------------------------------------------
# Sending report to FIN_REPORTS_DIR 
#-----------------------------------------------------------------------------
userid=`pwd|awk -F "/" '{print $NF}'`

test -d $FIN_REPORTS_DIR/${userid}
if [ $? -ne 0 ]
then
        mkdir $FIN_REPORTS_DIR/${userid}
fi

cp ${OutputReport1} $FIN_REPORTS_DIR/${userid}/${OutputReport1}
cp ${OutputReport2} $FIN_REPORTS_DIR/${userid}/${OutputReport2}


#-----------------------------------------------------------------------------
# Pushing report to PR menu option
#-----------------------------------------------------------------------------

babx4040 $B2K_SESSION_ID $FIN_REPORTS_DIR/${userid}/${OutputReport1} "SALPAY SUCESS REPORT" "MANAGER" '1' 'N'


babx4040 $B2K_SESSION_ID $FIN_REPORTS_DIR/${userid}/${OutputReport2} "SALPAY FAILURE REPORT" "MANAGER" '1' 'N'

#-----------------------------------------------------------------------------
# Deleting Temporary files
#-----------------------------------------------------------------------------
if [ "x$TBA_DEBUG" = "x" ]
then
       rm -f $ListFile1
       rm -f $ListFile2
       rm -f $ListFile3
       rm -f $ListFile4
#       rm -f $OutputReport1
#       rm -f $OutputReport2
fi

exit 0
