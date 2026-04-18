#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpc2breRecon.com 
#  Description     :
#  Date            : 24-08-2021
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             24-08-2021      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo $FIN_BANK_ID
ubankid=`echo $FIN_BANK_ID`
upldir="/finreports/TRAN_RECON/${ubankid}"
datadir="/finreports/TRAN_RECON/${ubankid}/DATA"
logdir="/finreports/TRAN_RECON/${ubankid}/LOG"
bkpdir="/finreports/TRAN_RECON/${ubankid}/DATA/BKP"
cd $upldir
ctlPth=`echo $CTL_PATH`
usr="APPLMGR"
ubankid=`echo $FIN_BANK_ID`
test -d ${datadir}
if [ $? -ne 0 ]
then
    echo "Recon data directory not exists" 
fi
test -d ${bkpdir}
if [ $? -ne 0 ]
then
    echo "Recon data backup directory not exists" 
fi
for fil in `ls | egrep -e ".csv"`
do
echo ${fil}
echo ${trFile}
if [ -f "$fil" ]; then
#{
    	echo "$fil exists."
	if [[ ! -s $fil ]] ; then
	#{
		  echo $fil is empty
	#}
	else
	#{
			echo "c2bre yes" 
			batchId="C2BRE_"`date +%m%d%Y%H%M%S`
			mv ${fil} ${datadir}/${fil}
			logfile=${logdir}/${batchId}"_F.log"
			badfile=${logdir}/${batchId}"_F.bad"
			sed s/uplfilname/${fil}/g ${ctlPth}vpc2breRecon.ctl > vpc2breRecon1.ctl 
			sed s/uplbankid/${ubankid}/g vpc2breRecon1.ctl > vpc2breRecon2.ctl 
			sed s/uplbaid/${batchId}/g vpc2breRecon2.ctl > vpc2breRecon3.ctl 
			filPth=${datadir}/${fil}
			perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
			$ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpc2breRecon3.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
			echo $? >> vp.log
			test -f ${badfile}
			if [ $? -eq 0 ]
			then
				echo "in bad rpt " >>vp.log
			fi
			test -f ${logfile}
			if [ $? -eq 0 ]
			then
				echo "in log rpt " >>vp.log
			fi
			rm -f vpc2breRecon1.ctl vpc2breRecon2.ctl vpc2breRecon3.ctl 
			mv ${datadir}/${fil} ${bkpdir}/${fil}
			`execom vpc2brerun.com ${fil} ${batchId} ${ubankid}` 
	#}
	fi
else 
    echo "$fil does not exist."
#}
fi
done
exit 0
