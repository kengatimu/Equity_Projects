#---------------------------------------------------------------------------------
#--    File Name                  : CCardSettle.com
#--    Date                       : 01.03.2013
#--    Author                     : Gokulkrishna
#--    Assumptions                : NIL
#--    Modification History    :
#--    <Serial No.>    <Date>        <Author Name>                <Description>
#--       1.          01.03.2013     Gokulkrishna                  Original Version
#-----------------------------------------------------------------------------------
set -vx
tempFile="tempFile${$}.txt"
datFile="test${$}.dat"
tempFile="tempFile${$}.txt"
remarks=`echo ${remarks} |sed -e "s/ /|/g"`

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

#----------------------------------------------------------------------------------------
#       SQL Execution
#----------------------------------------------------------------------------------------
sqlldr ${USER_PASS} control= "${CTL_PATH}CCardSettle.ctl" data= "${txtFile}"

bauu9151 CCardSettleProc.sql \'${sqlInput}\' ${bankId}
if [ $? -ne 0 ]
then
	echo "CCardSettleProc.sql execution failed !" >ErrorCCards.txt
	exit 1
fi


bauu9151 CCardSettle.sql \'${sqlInput}\' ${bankId} ${rowCode} ${file}
if [ $? -ne 0 ]
then
	echo " CCardSettle.sql SQL execution failed !" >> ErrorCCards.txt
	exit 1
fi


mrbx4004 $B2K_SESSION_ID CCardSettle.mrt ${file} ${file}

if [ $? -ne 0 ]
then
        echo "CCardSettle.mrt SQL execution failed !" >> ErrorCCards.txt
        exit 1
fi

cp ${rptpath}/${file}.rpt ${upldpath}/${file}.rpt

sed 's/\~/ /g' ${rptpath}/${file}.rpt > $tempFile

cp $tempFile ${upldpath}/${file}.rpt

#modified by anuya to make the file compatible to 10.2.18
echo "${file}.rpt ${pstdFlg} ${renameFlg}
MANAGER CI ${file}.rpt ${pstdFlg} ${remarks} ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile ccardsettle01.dat
mcbx4024 $B2K_SESSION_ID < ccardsettle01.dat
echo `head -1 TRAN_INFO.dat` >> ccardsettle01.txt

a=`head -1 TRAN_INFO.dat`

if [ ${renameFlg} == "Y" ]
then
        mv ${renameFile} ${renameFile}.done
fi

cp ${processFile} ${rptpath}/${processFile}

if [ -s "${processFile}" ]
then
        babx4040 ${B2K_SESSION_ID} ${rptpath}/${processFile}  "CCARD SETTELMENT UPLOAD" "MANAGER" "1" "N"
fi

exit 0
