######################################################################################################################
# Source Name						: oclgchqupldvalmn001.com									
# Date								: 03-03-2013 									
# Description						: This script is for validation of zone code and file name.
# Author     						: Manoj								
# Bank								: Equity Bank,KENYA							
# Modification History				:				
#		< Version No.> 		<Date>		<Author Name> 		<Description>									
#		 0.1			03-03-2013 		Manoj			Original Version									
#		 0.2			27-10-2013		Bharath		Upload initiated in background
########################################################################################################################
set -vx
#-----------------------------------------------------------------------------------
#------Checking if directory is present and creating directory
#-----------------------------------------------------------------------------------
userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"
rptpath="$FIN_REPORTS_DIR/${userid}"
test -d ${upldpath}
if [ $? -ne 0 ]
then
	mkdir ${upldpath}
fi

test -d $FIN_REPORTS_DIR/${userid}
if [ $? -ne 0 ]
then
	mkdir $FIN_REPORTS_DIR/${userid}
fi

cp ${DATA_PATH}/${userid}/${inFileName} ${upldpath}/${inFileName}

echo "Manager ${inZoneCode} ${inZoneDate} ${inFileName} {~~~NULL!~~~} {~~~NULL!~~~} {~~~NULL!~~~} {~~~NULL!~~~} USD {~~~NULL!~~~}" > chqupld.dat

$TBA_E/mcbx4012 ${B2K_SESSION_ID} < ./chqupld.dat

mv -f ${DATA_PATH}/${userid}/${inFileName} ${FILE_BAK_PATH}/${inFileName}

#-----------------------------------------------------------------------------------
#Deleting file after processing
#-----------------------------------------------------------------------------------
rm -f chqupld.dat

