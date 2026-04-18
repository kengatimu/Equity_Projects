#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpAgentCommMaster.com 
#  Description     :
#  Date            : 06-01-2022
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             06-01-2021      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Please do not change without CR and businsess change
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo $FIN_BANK_ID
hname=${HOSTNAME}
echo $hname
upldir="/finreports/AGENT_COMM_UPL/54"
datadir="/finreports/AGENT_COMM_UPL/54/DATA"
logdir="/finreports/AGENT_COMM_UPL/54/LOG"
bkpdir="/finreports/AGENT_COMM_UPL/54/DATA/BKP"
cd $upldir
AgnttrFile="AGNTCOMM_"`date +%d%m%Y`".csv"
AGNTTRFile="AGNTCOMM_"`date +%d%m%Y`".CSV"
HsnptrFile="HSNPCOMM_"`date +%d%m%Y`".csv"
HSNPTRFile="HSNPCOMM_"`date +%d%m%Y`".CSV"
InuatrFile="INUACOMM_"`date +%d%m%Y`".csv"
INUATRFile="INUACOMM_"`date +%d%m%Y`".CSV"
WithtrFile="WITHTAX_"`date +%d%m%Y`".csv"
WITHTRFile="WITHTAX_"`date +%d%m%Y`".CSV"
ctlPth=`echo $CTL_PATH`
usr="CDCI54"
ubankid=`echo $FIN_BANK_ID`
mcid=`uname -n`
echo ${mcid}
test -d ${datadir}
if [ $? -ne 0 ]
then
    echo "Agent Comm data directory not exists" 
fi
test -d ${bkpdir}
if [ $? -ne 0 ]
then
    echo "Agent Comm data backup directory not exists" 
fi
##for fil in `ls | egrep -e ".csv"`
for fil in `ls | egrep -e ".csv"` `ls | egrep -e ".CSV" `
do
echo ${fil}
if [ -f "$fil" ]; then
#{
    	echo "$fil exists."
	if [[ ! -s $fil ]] ; then
	#{
		  echo $fil is empty
	#}
	else
	#{
		if [ "$AgnttrFile" == "$fil" ] || [ "$AGNTTRFile" == "$fil" ]
		then
		#{
			ModuleCode="AGENTCOMM"
			echo "agent comm tran yes" 
			batchId="AGENTCOMM_"`date +%m%d%Y%H%M%S`
			mv ${fil} ${datadir}/${fil}
			logfile=${logdir}/${batchId}"_F.log"
			badfile=${logdir}/${batchId}"_F.bad"
			sed s/upluser/${usr}/g ${ctlPth}vpAgntCommTran.ctl > vpAgntCommTran1.ctl 
			sed s/uplbankid/${ubankid}/g vpAgntCommTran1.ctl > vpAgntCommTran2.ctl 
			sed s/uplbaid/${batchId}/g vpAgntCommTran2.ctl > vpAgntCommTran3.ctl 
			sed s/uplfilname/${fil}/g vpAgntCommTran3.ctl > vpAgntCommTran4.ctl
			sed s/machineid/${mcid}/g vpAgntCommTran4.ctl > vpAgntCommTran5.ctl
			sed s/modulecode/${ModuleCode}/g vpAgntCommTran5.ctl > vpAgntComTran.ctl
			filPth=${datadir}/${fil}
			perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
			$ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpAgntComTran.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
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
			rm -f vpAgntCommTran1.ctl vpAgntCommTran2.ctl vpAgntCommTran3.ctl vpAgntCommTran4.ctl vpAgntCommTran5.ctl vp.log vpAgntComTran.ctl 
			mv ${datadir}/${fil} ${bkpdir}/${fil}
			`execom vpAgentCommTran.com ${batchId} ${ModuleCode}`
			exit 
		#}
		elif [ "$HsnptrFile" == "$fil" ] || [ "$HSNPTRFile" == "$fil" ]
                then
                #{
                        ModuleCode="HSNPCOMM"
                        echo "HSNP comm tran yes"
                        batchId="HSNPCOMM_"`date +%m%d%Y%H%M%S`
                        mv ${fil} ${datadir}/${fil}
                        logfile=${logdir}/${batchId}"_F.log"
                        badfile=${logdir}/${batchId}"_F.bad"
                        sed s/upluser/${usr}/g ${ctlPth}vpAgntCommTran.ctl > vpAgntCommTran1.ctl
                        sed s/uplbankid/${ubankid}/g vpAgntCommTran1.ctl > vpAgntCommTran2.ctl
                        sed s/uplbaid/${batchId}/g vpAgntCommTran2.ctl > vpAgntCommTran3.ctl
                        sed s/uplfilname/${fil}/g vpAgntCommTran3.ctl > vpAgntCommTran4.ctl
                        sed s/machineid/${mcid}/g vpAgntCommTran4.ctl > vpAgntCommTran5.ctl
                        sed s/modulecode/${ModuleCode}/g vpAgntCommTran5.ctl > vpAgntComTran.ctl
                        filPth=${datadir}/${fil}
                        perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                        $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpAgntComTran.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
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
                        rm -f vpAgntCommTran1.ctl vpAgntCommTran2.ctl vpAgntCommTran3.ctl vpAgntCommTran4.ctl vpAgntCommTran5.ctl vp.log vpAgntComTran.ctl
                        mv ${datadir}/${fil} ${bkpdir}/${fil}
			`execom vpAgentCommTran.com ${batchId} ${ModuleCode}`
			exit

                #}
		elif [ "$InuatrFile" == "$fil" ] || [ "$INUATRFile" == "$fil" ]
		then
		#{
                        ModuleCode="INUACOMM"
                        echo "INUA comm tran yes"
                        batchId="INUACOMM_"`date +%m%d%Y%H%M%S`
                        mv ${fil} ${datadir}/${fil}
                        logfile=${logdir}/${batchId}"_F.log"
                        badfile=${logdir}/${batchId}"_F.bad"
                        sed s/upluser/${usr}/g ${ctlPth}vpAgntCommTran.ctl > vpAgntCommTran1.ctl
                        sed s/uplbankid/${ubankid}/g vpAgntCommTran1.ctl > vpAgntCommTran2.ctl
                        sed s/uplbaid/${batchId}/g vpAgntCommTran2.ctl > vpAgntCommTran3.ctl
                        sed s/uplfilname/${fil}/g vpAgntCommTran3.ctl > vpAgntCommTran4.ctl
                        sed s/machineid/${mcid}/g vpAgntCommTran4.ctl > vpAgntCommTran5.ctl
                        sed s/modulecode/${ModuleCode}/g vpAgntCommTran5.ctl > vpAgntComTran.ctl
                        filPth=${datadir}/${fil}
                        perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                        $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpAgntComTran.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
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
                        rm -f vpAgntCommTran1.ctl vpAgntCommTran2.ctl vpAgntCommTran3.ctl vpAgntCommTran4.ctl vpAgntCommTran5.ctl vp.log vpAgntComTran.ctl
                        mv ${datadir}/${fil} ${bkpdir}/${fil}
			`execom vpAgentCommTran.com ${batchId} ${ModuleCode}`
			exit

		#}
		elif [ "$WithtrFile" == "$fil" ] || [ "$WITHTRFile" == "$fil" ]
		then
		#{
			abatchId="AGTS-"`date +%d%m%Y%H%M%S`
			echo "set head off;">${abatchId}.sql
			echo "set trimspool on;">>${abatchId}.sql
			echo "set trimout on;">>${abatchId}.sql
			echo "set pages 0;">>${abatchId}.sql
			echo "set feedback off;">>${abatchId}.sql
			echo "set linesize 32767;">>${abatchId}.sql
			echo "set echo off;">>${abatchId}.sql
			echo "set long 90000;">>${abatchId}.sql
			echo "spool ${abatchId}.DAT;">>${abatchId}.sql
			echo "select module_code||'|'||PROCESS_TRAN_ID||'|'||sum(tran_amt)||'|'||(select distinct pstd_flg from tbaadm.dtd where bank_id='54' and tran_id=process_tran_id and tran_date=(select db_stat_date from tbaadm.gct where bank_id='54' and del_flg='N'))as pstdyn from custom.cust_agentcomm_master_tbl where bank_id='54'  and machine_name is not null and trunc(upld_date)=(select db_stat_date from tbaadm.gct where bank_id='54' and del_flg='N') and module_code='AGENTCOMM' and PROCESS_TRAN_ID is not null and PROCESS_TRAN_ID in (select tran_id from tbaadm.dtd where bank_id='54' and tran_id=process_tran_id and tran_date=(select db_stat_date from tbaadm.gct where bank_id='54' and del_flg='N') and pstd_flg='Y' and del_flg='N') group by module_code,PROCESS_TRAN_ID
order by module_code;  " >> ${abatchId}.sql
			echo "spool off;">>${abatchId}.sql
			exebatch bauu9151 ${abatchId}.sql
			rm -f ${abatchId}.sql
			sleep 1
			noOfLine=`cat ${abatchId}.DAT|wc -l`
			if [ ${noOfLine} -ge 1 ]
			then
			#{

                        ModuleCode="WITHTAXCOMM"
                        echo "WITHTAX comm tran yes"
                        batchId="WITHTAXCOMM_"`date +%m%d%Y%H%M%S`
                        mv ${fil} ${datadir}/${fil}
                        logfile=${logdir}/${batchId}"_F.log"
                        badfile=${logdir}/${batchId}"_F.bad"
                        sed s/upluser/${usr}/g ${ctlPth}vpAgntCommTran.ctl > vpAgntCommTran1.ctl
                        sed s/uplbankid/${ubankid}/g vpAgntCommTran1.ctl > vpAgntCommTran2.ctl
                        sed s/uplbaid/${batchId}/g vpAgntCommTran2.ctl > vpAgntCommTran3.ctl
                        sed s/uplfilname/${fil}/g vpAgntCommTran3.ctl > vpAgntCommTran4.ctl
                        sed s/machineid/${mcid}/g vpAgntCommTran4.ctl > vpAgntCommTran5.ctl
                        sed s/modulecode/${ModuleCode}/g vpAgntCommTran5.ctl > vpAgntComTran.ctl
                        filPth=${datadir}/${fil}
                        perl -p -i -e 's/\r\n$/\n/g'  ${filPth}
                        $ORACLE_HOME/bin/sqlldr ${USER_PASS} control="vpAgntComTran.ctl" data=${filPth} LOG=${logfile} BAD=${badfile}
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
                        rm -f vpAgntCommTran1.ctl vpAgntCommTran2.ctl vpAgntCommTran3.ctl vpAgntCommTran4.ctl vpAgntCommTran5.ctl vp.log vpAgntComTran.ctl
                        mv ${datadir}/${fil} ${bkpdir}/${fil}
			`execom vpAgentCommTran.com ${batchId} ${ModuleCode}`
			exit
			#}
			else
			#{
				rm -f ${abatchId}.DAT
			#}
			fi
		#}
		else
		#{
			echo "no"
		#}
		fi
	#}
	fi
else 
    echo "$fil does not exist."
#}
fi
done
exit 0
