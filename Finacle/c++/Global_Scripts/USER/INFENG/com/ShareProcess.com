#---------------------------------------------------------------------------------
#--    File Name                  : ShareProcess.com
#--    Date                       : 06.03.2013
#--    Author                     : Gokulkrishna
#--    Assumptions                : NIL
#--    Modification History    :
#--    <Serial No.>    <Date>        <Author Name>                <Description>
#--       1.          06.03.2013     Gokulkrishna                 Original Version
#--       2.          08.07.2013     Bharath Reddy                Changed lst,report filename from static to dynamic
#		3.0			27-10-2013		Bharath				Upload initiated in background
#-----------------------------------------------------------------------------------
set -vx
tempFile="tempFile${$}.txt"
datFile="test${$}.dat"
reportFileName="SharesUpload${$}"
lstFileName="SharesUpload${$}.lst"
ripFileName="SharesUpload${$}.rip"
mrtFileName="ShareTrading.mrt"
datFileName="SharesUpload${$}.dat"
sucessFile="${fileName}SuccessReport.txt"
errorFile="${fileName}ErrorReport.txt"
promptSale="${fileName}Propmtsales.txt"
normalSale="${fileName}Normalsales.txt"
userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"

#----------------------------------------------------------------
#------Checking if upload directory exists and creating directory
#----------------------------------------------------------------
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

bauu9151 ShareUpload.sql ${fileName} ${bankId} ${brcode1} ${acctNo1} ${bacid} ${bacid2} ${acctNo2} ${brcode3} ${acctNo3} ${brcode4} ${brcode5} ${acctNo4} ${homeCrncy} ${lstFileName}
chmod 777 ${lstFileName}

mrbx4004 $B2K_SESSION_ID $mrtFileName $lstFileName $reportFileName 
sed 's/\~/ /g' ${FIN_REPORTS_DIR}/${userid}/${reportFileName}.rpt > $tempFile
cp $tempFile ${FIN_REPORTS_DIR}/${userid}/${reportFileName}.rpt
cp ${FIN_REPORTS_DIR}/${userid}/${reportFileName}.rpt ${upldpath}/${reportFileName}.rpt
cp ${sucessFile} ${FIN_REPORTS_DIR}/${userid}/${sucessFile}
cp ${errorFile} ${FIN_REPORTS_DIR}/${userid}/${errorFile}
cp ${promptSale} ${FIN_REPORTS_DIR}/${userid}/${promptSale}
cp ${promptSale} ${upldpath}/${promptSale}
cp ${normalSale} ${FIN_REPORTS_DIR}/${userid}/${normalSale}
cp ${normalSale} ${upldpath}/${normalSale}

#modified by anuya to make the file compatible to 10.2.18
echo "${reportFileName}.rpt ${pstdFlg} ${renameFlg}
MANAGER CI $reportFileName.rpt ${pstdFlg} $reportFileName.rpt ${renameFlg} Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile shareProcessing.dat
mcbx4024 $B2K_SESSION_ID < shareProcessing.dat
echo `head -1 TRAN_INFO.dat` >> shareProcessing.txt
a=`head -1 TRAN_INFO.dat`
if [ ${renameFlg} == "Y" ]
then
        mv ${upldPath}${fileName} ${upldPath}${fileName}.done
fi

noOfLine=`cat ${errorFile}|wc -l`
if [ ${noOfLine} -gt 1 ] 
then
	noOfPages=`grep -c "^L" "${errorFile}"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 ${B2K_SESSION_ID} ${FIN_REPORTS_DIR}/${userid}/${errorFile} "Share Trading Error Report" "MANAGER" "$noOfPages" "N"
	if [ $? -ne 0 ]
	then
		echo "Report Generated. To View/Print, Use HPR Menu."
	fi
fi

noOfLine=`cat ${sucessFile}|wc -l`
if [ ${noOfLine} -gt 1 ] 
then
	noOfPages=`grep -c "^L" "${sucessFile}"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 ${B2K_SESSION_ID} ${FIN_REPORTS_DIR}/${userid}/${sucessFile} "Share Trading Success Report" "MANAGER" "$noOfPages" "N"
	if [ $? -ne 0 ]
	then
		echo "Report Generated. To View/Print, Use HPR Menu."
	fi
fi

if [ -s ${promptSale} ] 
then
	noOfPages=`grep -c "^L" "${promptSale}"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 ${B2K_SESSION_ID} ${FIN_REPORTS_DIR}/${userid}/${promptSale} "Prompt Sale Report" "MANAGER" "$noOfPages" "N"
	if [ $? -ne 0 ]
	then
		echo "Report Generated. To View/Print, Use HPR Menu."
	fi
fi

if [ -s ${normalSale} ] 
then
	noOfPages=`grep -c "^L" "${normalSale}"`
	noOfPages=`expr "${noOfPages}" + 1`
	babx4040 ${B2K_SESSION_ID} ${FIN_REPORTS_DIR}/${userid}/${normalSale} "Normal Sale Report" "MANAGER" "$noOfPages" "N"
	if [ $? -ne 0 ]
	then
		echo "Report Generated. To View/Print, Use HPR Menu."
	fi
fi

exit 0
#----------------------------------------------------------------
#--------Deleting file after processing
#----------------------------------------------------------------
rm -f ${sucessFile} 
rm -f ${errorFile} 
rm -f ${promptSale} 
rm -f ${normalSale} 
#rm -f ${tempFile}
#rm -f ${lstFileName}

exit 0

