#---------------------------------------------------------------------------------
#--    File Name                  : ECRProcess.com
#--    Date                       : 07.03.2013
#--    Author                     : Prakash
#--    Assumptions                : NIL
#--    Modification History		:
#--    <Serial No.>    <Date>        <Author Name>                <Description>
#--       1.          07.03.2013     Prakash                  Original Version
#			2			27-10-2013		Bharath				Upload initiated in background
#-----------------------------------------------------------------------------------
set -vx
reportFileName1="${fileName}SuccessReport${$}.txt"
reportFileName2="${fileName}ErrorReport${$}.txt"
reportFileName3="ECRUpload${$}.lst"
reportFileName="ECRUpload${$}"
lstFileName="ECRUpload${$}.lst"
mrtFileName="ShareTrading.mrt"
datFileName="ECRUpload${$}.dat"
tempFile="tempfile${$}.txt"
rmks=`echo ${rmks} |sed -e "s/ /|/g"`

#-----------------------------------------------------------------------------------
#------Checking if directory is present and creating directory
#-----------------------------------------------------------------------------------
userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"
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

bauu9151 ECRUpload.sql ${fileName} ${bankId} ${homeCrncy} ${acctNo} ${solId} ${lstFileName} ${reportFileName1} ${reportFileName2}
if [ $? -ne 0 ]
then
        echo "SQL execution failed !"
        exit 1
fi

cp ${reportFileName1} $FIN_REPORTS_DIR/${userid}/${reportFileName1}
cp ${reportFileName2} $FIN_REPORTS_DIR/${userid}/${reportFileName2}
cp ${reportFileName3} $FIN_REPORTS_DIR/${userid}/${reportFileName3}

mrbx4004 ${B2K_SESSION_ID} ${mrtFileName} ${lstFileName} ${reportFileName}

cp $FIN_REPORTS_DIR/${userid}/${reportFileName}.rpt ${upldpath}/${reportFileName}.rpt

sed 's/\~/ /g' $FIN_REPORTS_DIR/${userid}/${reportFileName}.rpt > ${tempFile}

cp ${tempFile} ${upldpath}/${reportFileName}.rpt

if [ -s "${reportFileName1}" ]
then
	noOfPages=`grep -c "^L" "${reportFileName1}"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 "${B2K_SESSION_ID}" "$FIN_REPORTS_DIR/${userid}/${reportFileName1}" "SHARES TRADING Success Report" "MANAGER" "${noOfPages}" N
fi

if [ -s "${reportFileName2}" ]
then
	noOfPages=`grep -c "^L" "${reportFileName2}"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 "${B2K_SESSION_ID}" "$FIN_REPORTS_DIR/${userid}/${reportFileName2}" "SHARES TRADING Error Report" "MANAGER" "${noOfPages}" N
fi

if [ -s "${reportFileName3}" ]
then
	noOfPages=`grep -c "^L" "${reportFileName3}"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 "${B2K_SESSION_ID}" "$FIN_REPORTS_DIR/${userid}/${reportFileName3}" "SHARES TRADING TRANSACTION TTUM UPLOAD " "MANAGER" "${noOfPages}" N
fi

#modified by anuya to make the file compatible to 10.2.18
echo "${reportFileName}.rpt ${ttumsal} ${renameFlg}
MANAGER ${tranSub} ${reportFileName}.rpt ${ttumsal} ${rmks} ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile ecrprocessing.dat
mcbx4024 $B2K_SESSION_ID < ecrprocessing.dat
echo `head -1 TRAN_INFO.dat` >> ecrprocessing.txt
a=`head -1 TRAN_INFO.dat`

if [ ${renameFlg} == "Y" ]
then
	mv ${fileNamePath} ${fileNamePath}.done
fi

if [ "x$TBA_DEBUG" = "x" ] 
then
  	rm -f $lstFileName
	rm -f $datFileName
	rm -f $tempFile
	rm -f ${reportFileName1} 
	rm -f ${reportFileName2} 
	rm -f ${reportFileName3} 
fi

exit 0
