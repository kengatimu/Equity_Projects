#---------------------------------------------------------------------------------
#--    File Name                  : ShareUpload.com
#--    Date                       : 06.03.2013
#--    Author                     : Gokulkrishna
#--    Assumptions                : NIL
#--    Modification History    :
#--    <Serial No.>    <Date>        <Author Name>                <Description>
#--       1.          06.03.2013     Gokulkrishna                 Original Version
#--       2.          08.07.2013     Bharath Reddy                Removed commented lines and hardcodeings
#-----------------------------------------------------------------------------------

bauu9151 ShareTrading1.sql $2
if [ $? -ne 0 ]
then
	echo "SQL execution failed !"
	exit 1
fi

#----------------------------------------------------------------------------------------
#       SQL Execution
#----------------------------------------------------------------------------------------
$ORACLE_HOME/bin/sqlldr $3 control= "$4ShareTrading.ctl" data= "$5"

#Deleting file after processing
rm -f $5

exit 0

