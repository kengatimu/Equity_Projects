#################################################################################
# Source Name               : cmsupdp001.com 
# Date                      : 20-09-2013
# Description               : cms Rectification 
# Author                    : 
##################################################################################

exebatch bauu9151 cmsupdp001.sql ${1} ${2}
if [ $? -ne 0 ]
then
    echo "SQL procedure execution failed for Transaction Report !"
    exit 1
fi

exit 0

