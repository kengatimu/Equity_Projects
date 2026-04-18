#################################################################################################
# NAME                  : IGLS_TtumExeExecdp002.com
# DATE                  : 24-06-2008                                                            #
# DESCRIPTION           : This script executes the mcbx4024 exe for TTUM upload IGLS		#
# AUTHOR                : Dileep
# CALLED SCRIPTS        :                                                                       #
# CALLING SCRIPTS       : IGLS_TtumExeExecmn001.scr                                              #
# BANK                  : Equity
#                                                                                               #
# Modification History:                                                                         #
# S.No.  Date         Name                     Description                                      #
# -----  ---------    ----------------------   -----------------------------                    #
# 1.0	03-11-2013	Dileep Rajan		TTUM uplaod from ICONNECT
#						(Modified for using the common path)		#
#################################################################################################
set -vx
sessionID=${1}
inputDat=${2}
inputFileName=${3}
batchPID=$$

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

cp ${inputFileName} ${upldpath}/

#sleep 20
cd ${FILE_OUTPUT_FLDR}

fname=`echo ${inputFileName} | rev | cut -d"/" -f1 | rev | cut -f1 -d"."`
echo $fname
#fname=`echo ${inputFileName} | cut -f1 -d'.'`
logFileName=${fname}_${batchPID}.log
outFileName=${fname}.out
LSTFileName=${fname}.LST

date  > ${logFileName}
echo "sessionID:"${sessionID} >> ${logFileName}
echo "inputDat:"${inputDat} >> ${logFileName}
echo "inputFileName:"${inputFileName} >> ${logFileName}
pwd  >> ${logFileName}
echo "IGLS_PPID:"${IGLS_PPID} >> ${logFileName}

## CALL MCBX
TBA_DEBUG=Y
export TBA_DEBUG
export LDR_CNTRL=MAXDATA=0x40000000 
mcbx4024 $B2K_SESSION_ID < ${inputDat}
exitssts=$?
unset LDR_CNTRL
echo ${exitssts}  >> ${logFileName}
if [ ${exitssts} -ne 0 ]
then
	echo "Batch call failed"  >> ${logFileName}
	exit 9
fi

if [ -f TMP${IGLS_PPID}.com ]
then
	chmod 755 TMP${IGLS_PPID}.com
	. TMP${IGLS_PPID}.com
else
	echo "System Mal function" >> ${logFileName}
        exit 9
fi

echo ${LSTFileName} >> ${logFileName}
if [ "X${LSTFileName}" = "X" ]
then
        echo "No LST file found" >> ${logFileName}
        exit 9
fi

##### CHANGE THE OUTPUT LST FILE FORMAT TO SYSTEM READABLE FORMAT
#cat ${LSTFileName} | cut -f1-6 -d '|' > TMP1_${batchPID}.TMP
#cat ${LSTFileName} | cut -f7 -d '|' | cut -c -101 > TMP2_${batchPID}.TMP
#cat TMP2_${batchPID}.TMP | cut -c -16  > TMP2_${batchPID}.1.TMP
#cat TMP2_${batchPID}.TMP | cut -c17-19 > TMP2_${batchPID}.2.TMP
#cat TMP2_${batchPID}.TMP | cut -c28-45 > TMP2_${batchPID}.3.TMP
#cat TMP2_${batchPID}.TMP | cut -c81-100 > TMP2_${batchPID}.5.TMP
#sed s/\ /0/g TMP2_${batchPID}.3.TMP > TMP2_${batchPID}.4.TMP
#pr -tm TMP2_${batchPID}.1.TMP TMP2_${batchPID}.2.TMP TMP2_${batchPID}.4.TMP TMP2_${batchPID}.5.TMP | awk '{print$1"|"$2"|"$3"|"$4}' > TMP3_${batchPID}.TMP
#pr -tm -w200 TMP2_${batchPID}.1.TMP TMP2_${batchPID}.2.TMP TMP2_${batchPID}.4.TMP TMP2_${batchPID}.5.TMP | awk '{print$1"|"$2"|"$3"|"$4}' > TMP3_${batchPID}.TMP
#pr -tm -s'|' TMP1_${batchPID}.TMP TMP3_${batchPID}.TMP  > ${outFileName}

#cp ${outFileName} ${FILE_OUTPUT_FLDR}/A${outFileName}
#exitssts=$?
#echo ${exitssts}  >> ${logFileName}
#if [ ${exitssts} -ne 0 ]

#then
#        echo "Copy Failed"  >> ${logFileName}
#        exit 9
#fi

#mv ${fname}* ${FILE_OUTPUT_FLDR}
#mv TMP.*${batchPID}* ${FILE_OUTPUT_FLDR}
#exitssts=$?
#echo ${exitssts}  >> ${logFileName}
#if [ ${exitssts} -ne 0 ]
#then
#        echo "Move Failed"  >> ${logFileName}
#fi

if [ N${TBA_DEBUG} = "N" ]
then
        #rm -rf TMP.*${batchPID}*
	#rm -rf TMP${IGLS_PPID}.com
	echo "TMP Files Removed" >> ${logFileName}
fi

echo 0


