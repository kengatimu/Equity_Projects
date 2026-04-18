#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpAgentCommTran.com 
#  Description     :
#  Date            : 08-08-2021
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             08-08-2021      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set -vx
cd /finacle/EQPROD/BackEnd/Finacle/FC/app/CDCI_LOGS/CDCI54
BatId=${1}
modulecode=${2}
bankId=`echo $FIN_BANK_ID`
usr="CDCI54"
	echo "set head off;">${BatId}_T.sql
	echo "set trimspool on;">>${BatId}_T.sql
	echo "set trimout on;">>${BatId}_T.sql
	echo "set pages 0;">>${BatId}_T.sql
	echo "set feedback off;">>${BatId}_T.sql
	echo "set linesize 32767;">>${BatId}_T.sql
	echo "set echo off;">>${BatId}_T.sql
	echo "set long 90000;">>${BatId}_T.sql
	echo "spool ${BatId}.DAT;">>${BatId}_T.sql
	echo "select rpad(NVL(ACCT_NUMBER,' '),16,' ')||rpad((select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER),3,' ')||rpad(NVL(nvl((select sol_id from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER),'000'),' '),8,' ')|| rpad(NVL(PART_TRAN_TYPE,' '),1,' ')|| lpad(NVL(abs((TRAN_AMT)),0),17,' ')|| rpad(NVL(TRAN_PARTICULAR,' '),30,' ')|| rpad(NVL(' ',' '),5,' ')||rpad(NVL(' ',' '),20,' ')|| rpad(NVL(' ',' '),5,' ')|| rpad(NVL(' ',' '),10,' ')||rpad(NVL(' ',' '),6,' ')|| rpad(NVL(' ',' '),16,' ')|| " >> ${BatId}_T.sql 
	echo " rpad(NVL(' ',' '),1,' ')||(case when (select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER) <> TRAN_CRNCY then lpad(NVL(abs((TRAN_AMT)),0),17,' ') else rpad(NVL(' ',' '),17,' ') end) ||(case when (select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER) <> TRAN_CRNCY then rpad(TRAN_CRNCY,3,' ') else rpad(NVL(' ',' '),3,' ') end) ||(case when (select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER) <> TRAN_CRNCY then  rpad(NVL('MEAN',' '),5,' ') else rpad(NVL(' ',' '),5,' ')end) || " >> ${BatId}_T.sql
	echo "(case when (select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER) <> TRAN_CRNCY then nvl((select rpad(NVL(VAR_CRNCY_UNITS,''),15,' ') from tbaadm.rtl where bank_id='${bankId}' and fxd_crncy_code=TRAN_CRNCY and var_crncy_code=(select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER) and ratecode='MEAN' and entity_cre_flg='Y' and del_flg='N' and RTLIST_NUM in (select max(RTLIST_NUM) from tbaadm.rtl where bank_id='${bankId}' and fxd_crncy_code=TRAN_CRNCY and var_crncy_code=(select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER) and ratecode='MEAN' and entity_cre_flg='Y' and del_flg='N')),"  >> ${BatId}_T.sql
	echo "(select rpad(NVL(VAR_CRNCY_UNITS,''),15,' ') from tbaadm.rtl where bank_id='${bankId}' and fxd_crncy_code=(select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER) and var_crncy_code=TRAN_CRNCY and ratecode='MEAN' and entity_cre_flg='Y' and del_flg='N' and RTLIST_NUM in (select max(RTLIST_NUM) from tbaadm.rtl where bank_id='${bankId}' and fxd_crncy_code=(select acct_crncy_code from tbaadm.gam where bank_id='${bankId}' and foracid=ACCT_NUMBER) and var_crncy_code=TRAN_CRNCY and ratecode='MEAN' and entity_cre_flg='Y' and del_flg='N'))) else rpad(NVL('',' '),15,' ') end) || rpad(to_char(sysdate,'DD-MM-YYYY'),10,' ')|| " >> ${BatId}_T.sql 
	echo " rpad(NVL(' ',' '),10,' ')|| rpad(NVL(' ',' '),5,' ')|| rpad(NVL(' ',' '),6,' ')|| rpad(NVL(' ',' '),6,' ')|| rpad(NVL(' ',' '),2,' ')|| rpad(NVL(' ',' '),1,' ')|| rpad(NVL(' ',' '),12,' ')|| rpad(NVL(' ',' '),10,' ')|| rpad(NVL(' ',' '),20,' ')|| rpad(NVL(' ',' '),5,' ')|| rpad(NVL(' ',' '),30,' ')|| rpad(NVL(' ',' '),40,' ')|| rpad(NVL(' ',' '),40,' ')|| rpad(NVL(' ',' '),40,' ')|| rpad(NVL(' ',' '),40,' ')|| rpad(NVL(' ',' '),40,' ')|| rpad(NVL(' ',' '),17,' ')|| rpad(NVL(' ',' '),17,' ')|| rpad(NVL(' ',' '),17,' ')|| rpad(NVL(' ',' '),17,' ')|| rpad(NVL(' ',' '),17,' ')|| rpad(NVL(TRAN_PARTICULAR,' '),30,' ')|| rpad(NVL(' ',' '),16,' ')|| rpad(NVL(' ',' '),12,' ')|| rpad(NVL(' ',' '),10,' ')|| rpad(NVL(' ',' '),10,' ')|| rpad(NVL(' ',' '),9,' ')|| rpad(NVL(' ',' '),4,' ')|| rpad(NVL(' ',' '),256,' ')|| rpad(NVL(' ',' '),16,' ')|| rpad(NVL(' ',' '),5,' ')|| rpad(NVL(' ',' '),5,' ')|| rpad(NVL(' ',' '),5,' ')|| rpad(NVL(' ',' '),50,' ') from custom.cust_agentcomm_master_tbl where bank_id='${bankId}' and UPL_BATCH_ID='${BatId}' and module_code='${modulecode}' and PART_TRAN_TYPE in ('D','C') and PROCESS_STATUS='U' and entity_cre_flg='Y' and del_flg='N' and PROCESS_TRAN_ID is null and process_date is null;" >> ${BatId}_T.sql
	echo "spool off;">>${BatId}_T.sql
	sleep 5
	exebatch bauu9151 ${BatId}_T.sql
	if [ $? -ne 0 ]
	then
		echo "SQL execution failed !" > log.txt
		exit 1
	fi
	cp -f ${BatId}.DAT /finreports/FILE_UPLOAD/CDCI54/
	sleep 3
	drmsg="P"
echo "${BatId}.DAT $drmsg Y
MANAGER CI ${BatId}.DAT ${drmsg} ${BatId} Y Ttumupload.scr Ttumupload.mrt Ttumfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > ${BatId}_INP.DAT
mcbx4024 $B2K_SESSION_ID < ${BatId}_INP.DAT
echo `head -1 TRAN_INFO.dat` >> ${BatId}.txt
tid=`head -1 TRAN_INFO.dat`
echo "a is " $tid > log.txt
	if [ -z "$tid" ]
	then
		rm -f ${BatId}_T.sql ${BatId}.DAT ${BatId}_INP.DAT ${BatId}.txt 
		echo "tran not find"
	else
		echo "update custom.cust_agentcomm_master_tbl set PROCESS_TRAN_ID='${tid}',process_date=sysdate,process_desc='TRAN',lchg_user_id='${usr}',lchg_time=sysdate where bank_id='${bankId}' and upl_batch_id='${BatId}' and rcre_user_id='${usr}' and PROCESS_TRAN_ID is null;" >>${BatId}_status.sql
		echo "commit;">>${BatId}_status.sql
		exebatch bauu9151 ${BatId}_status.sql
		sleep 2
		rm -f ${BatId}_T.sql ${BatId}.DAT ${BatId}_INP.DAT ${BatId}.txt ${BatId}_status.sql
	fi
		rm -f ${BatId}_T.sql ${BatId}.DAT ${BatId}_INP.DAT ${BatId}.txt 
exit 0
