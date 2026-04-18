#-------------------------------------------------------------------------------------
#    Name               : chqmndp001.com
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
spbx4001 CUSTOM.GETCHQDETAILDWNLD_${bankId}.GETCHQDETAILDWNLD ${sqlParam} > ${lstFile1}
if [ -s "${lstFile1}" ]
then
	cp ${lstFile1} ${rptpath}/${lstFile1}
	exebatch babx4040 ${B2K_SESSION_ID} ${rptpath}/${lstFile1} "CHEQUE DETAIL SBA DOWNLOAD" "MANAGER" "1" "N"
fi

spbx4001 CUSTOM.GETCHQDETAILDWNLDCAA_${bankId}.GETCHQDETAILDWNLDCAA ${sqlParam} > ${lstFile2}
if [ -s "${lstFile2}" ]
then
	cp ${lstFile2} ${rptpath}/${lstFile2}
	exebatch babx4040 ${B2K_SESSION_ID} ${rptpath}/${lstFile2} "CHEQUE DETAIL CAA DOWNLOAD" "MANAGER" "1" "N"
fi

