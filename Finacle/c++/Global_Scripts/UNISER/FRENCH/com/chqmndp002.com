#-------------------------------------------------------------------------------------
#    Name               : chqmndp002.com
#    Description        :
#    Date               : 04-12-2013
#    Author             : Bharath
#    Input              : NA
#    Output             : NA
#    Called Script      : NA
#    Calling Script     : Bharath
#    Menu Option        : CCHQD
#    Srl. No            Date            Author          Description.
#    -------            ----            ------          ----------------
#    1.0                04-12-2013      Bharath          Original Version
#-------------------------------------------------------------------------------------
set -vx

#-----------------------------------------------------------------------------------
#------Checking if directory is present and creating directory
#-----------------------------------------------------------------------------------
userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"
rptpath="$FIN_REPORTS_DIR/${userid}"

test -d $FIN_REPORTS_DIR/${userid}
if [ $? -ne 0 ]
then
        mkdir $FIN_REPORTS_DIR/${userid}
fi

#---------------------------------------------------------------------------------
# Executing a package which fetches the required data and writes it to the file.
#---------------------------------------------------------------------------------
spbx4001 CUSTOM.GETCHQDETAILDUPDWNLD_${bankId}.GETCHQDETAILDUPDWNLD ${sqlParam} > ${lstFile}
if [ -s "${lstFile}" ]
then
	cp ${lstFile} ${rptpath}/${lstFile}
	exebatch babx4040 ${B2K_SESSION_ID} ${rptpath}/${lstFile} "CHEQUE DETAIL DOWNLOAD" "MANAGER" "1" "N"
fi

