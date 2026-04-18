###########################################################################
# Source Name                           : accvaliddp001.com
# Author                                : Vishal priyatham.G
# Date                                  : 08-10-2008
# Input Values                          : com file to run account closure in background
# Called Scripts                        : accvaliddp009.scr
# Calling Script                        : accvaliddp003.scr
# Output Values                         : None
##########################################################################
set -vx
echo $1>denom_logs
echo $2>>denom_logs
echo $sSetId>>denom_logs
echo $sTellerId>>denom_logs



Set_Id=`echo $sSetId`
Teller_Id=`echo $sTellerId`


#babx4061 $B2K_SESSION_ID $2 $sFileLoc $sEnvPath $sFilename $sMenuname
babx4553 < $2
if [ $? -ne 0 ]
then
        echo $? >>denom_logs
        echo "script called succesfully for Transaction Round Off  ">>denom1_logs
else
        echo "script calling failed">>denom1_logs
fi

#return $?
return 1
