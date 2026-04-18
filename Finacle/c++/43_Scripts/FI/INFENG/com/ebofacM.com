#------------------------------------------------------------------------------------------------
#  Name            : ebofacM.com 
#  Description     :
#  Date            : 30-03-2021
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             30-03-2021      Vino Palani          Original Version
#-----------------------------------------------------------------------------------------------
set -vx
#SERVERMODE=YES
#export SERVERMODE
#exebatch babx4044
#B2K_SESSION_ID=`cat tty.mn3`
#NOETOS=`cat anskey.mn1`
#export B2K_SESSION_ID
#export NOETOS
usr=${1}
ubankid=${2}
ctlPth=${3}
filPth=${4}
uPas=${5}
BatId=${6}
moduId=${7}
MainBId=${8}
batchId=`date +%m%d%Y%H%M%S`
test -d $FIN_REPORTS_DIR/${usr}
if [ $? -ne 0 ]
then
    mkdir $FIN_REPORTS_DIR/${usr}
fi
gpname=`basename ${filPth}`
logfile=${BatId}"_F.log"
badfile=$FIN_REPORTS_DIR/${usr}/${BatId}"_F.bad"
if [ "$7" = "OFAC-SDN" ]; then
sed s/upluser/${usr}/g ${ctlPth}ebofacSDN.ctl > ofacSDNRR.ctl
sed s/uplbankid/${ubankid}/g ofacSDNRR.ctl > ofacSDNRRR.ctl
sed s/uplbaid/${BatId}/g ofacSDNRRR.ctl > ebofacSDNRrR.ctl
perl -p -i -e 's/\r\n$/\n/g'  ${filPth} 
$ORACLE_HOME/bin/sqlldr ${uPas} control="ebofacSDNRrR.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
##echo $? >> vp.log
test -f ${badfile}
if [ $? -eq 0 ]
then
	##echo "in bad rpt " >>vp.log
	babx4040 "${B2K_SESSION_ID}" "${badfile}" "${BatId} Data Error" "MANAGER" 1 N
fi
test -f ${logfile}
if [ $? -eq 0 ]
then
	##echo "in log rpt " >>vp.log
	babx4040 "${B2K_SESSION_ID}" "${logfile}" "${BatId} Upload Log" "MANAGER" 1 N
fi
rm -f ofacSDNRR.ctl ofacSDNRRR.ctl ebofacSDNRrR.ctl 
fi
if [ "$7" = "OFAC-ADD" ]; then
sed s/upluser/${usr}/g ${ctlPth}ebofacADD.ctl > ofacADDRR.ctl
sed s/uplbankid/${ubankid}/g ofacADDRR.ctl > ofacADDRRR.ctl
sed s/uplbaid/${BatId}/g ofacADDRRR.ctl > ebofacADDRrR.ctl
perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
$ORACLE_HOME/bin/sqlldr ${uPas} control="ebofacADDRrR.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
##echo $? >> vp.log
test -f ${badfile}
if [ $? -eq 0 ]
then
        ##echo "in bad rpt " >>vp.log
        babx4040 "${B2K_SESSION_ID}" "${badfile}" "${BatId} Data Error" "MANAGER" 1 N
fi
test -f ${logfile}
if [ $? -eq 0 ]
then
        ##echo "in log rpt " >>vp.log
        babx4040 "${B2K_SESSION_ID}" "${logfile}" "${BatId} Upload Log" "MANAGER" 1 N
fi
rm -f ofacADDRR.ctl ofacADDRRR.ctl ebofacADDRrR.ctl
fi
if [ "$7" = "OFAC-ALT" ]; then
sed s/upluser/${usr}/g ${ctlPth}ebofacALT.ctl > ofacALTRR.ctl
sed s/uplbankid/${ubankid}/g ofacALTRR.ctl > ofacALTRRR.ctl
sed s/uplbaid/${BatId}/g ofacALTRRR.ctl > ebofacALTRrR.ctl
perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
$ORACLE_HOME/bin/sqlldr ${uPas} control="ebofacALTRrR.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
##echo $? >> vp.log
test -f ${badfile}
if [ $? -eq 0 ]
then
        ##echo "in bad rpt " >>vp.log
        babx4040 "${B2K_SESSION_ID}" "${badfile}" "${BatId} Data Error" "MANAGER" 1 N
fi
test -f ${logfile}
if [ $? -eq 0 ]
then
        ##echo "in log rpt " >>vp.log
        babx4040 "${B2K_SESSION_ID}" "${logfile}" "${BatId} Upload Log" "MANAGER" 1 N
fi
rm -f ofacALTRR.ctl ofacALTRRR.ctl ebofacALTRrR.ctl
fi
exit 0
