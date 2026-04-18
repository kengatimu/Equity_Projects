#!/bin/sh
#----------------------------------------------------------------------------
# Name  : LMFTP.com
# # Description : This com script is used to copy the response file to e-Banking server
# Called File :  This com file will be called by Equity_LM_Main.scr
# Called By       :
# Inputs    :
#-------------------------------------------------------------------------------
# Com file to create session id and call script.
set -vx
echo "inside LMFTP com file to execute the Equity_LM_Main.scr"

cd ${LM_RES_PATH}
ftp -i -n ${LM_HOST} << EOF
user ${LM_USER} ${LM_PASSWORD}
cd ${LM_EBANK_PATH}
asc
mput TTUM_RESPONSE*.txt
quit
EOF

mv TTUM_RESPONSE*.txt ${LM_RES_BKUP_PATH}

