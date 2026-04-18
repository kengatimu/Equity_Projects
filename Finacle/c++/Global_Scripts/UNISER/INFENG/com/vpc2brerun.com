#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpc2brerun.com
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Description     : PARALLELIZATION
#  Date            : 07-11-2022
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             10-11-2022      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set -vx
bankId=`echo $FIN_BANK_ID`
cd /finacle/EQPROD/BackEnd/Finacle/FC/app/CDCI_LOGS/CDCI${bankId}
ifilename=${1}
ibankid=${3}
batchId=${2}
nopj="1"
echo "update custom.cust_mpesa_recon_tbl set min_date=(select min(entry_date) from tbaadm.dtd where bank_id='${ibankid}' and acid='VZ86824' ) where file_name ='${ifilename}' and upl_batch_id='${batchId}'; " >${batchId}update.sql
echo "commit;">>${batchId}update.sql
exebatch bauu9151 ${batchId}update.sql
rm -f ${batchId}update.sql
sleep 1
echo "MERGE /*+ parallel(16) */ INTO custom.CUST_MPESA_RECON_TBL D using  (SELECT distinct TRAN_PARTICULAR_2 FROM tbaadm.dtd where bank_id ='${ibankid}' and acid='VZ86824')s on (D.RECEIPT_NO = s.TRAN_PARTICULAR_2) when MATCHED THEN UPDATE SET D.PROCESSED = 'Y', LINKED_TRANSACTION_ID ='Tran Found in Fin'  where FILE_NAME ='${ifilename}' and  D.PROCESSED = 'N' and upl_batch_id='${batchId}' ; " >${batchId}merge.sql
echo "commit;">>${batchId}merge.sql
exebatch bauu9151 ${batchId}merge.sql
rm -f ${batchId}merge.sql
sleep 1
echo "MERGE /*+ parallel(16) */ INTO custom.CUST_MPESA_RECON_TBL D using (SELECT distinct TRAN_PARTICULAR_2 FROM tbaadm.htd where bank_id ='${ibankid}' and acid='VZ86824' and  tran_date =(select SOL_CLS_DATE from tbaadm.sol where sol_id ='000' and bank_id ='54'))s on (D.RECEIPT_NO = s.TRAN_PARTICULAR_2) when MATCHED THEN UPDATE SET D.PROCESSED = 'Y', LINKED_TRANSACTION_ID ='Tran Found in Fin'  where FILE_NAME ='${ifilename}' and  D.PROCESSED = 'N' and upl_batch_id='${batchId}' ; " >${batchId}mergehtd.sql
echo "commit;">>${batchId}mergehtd.sql
exebatch bauu9151 ${batchId}mergehtd.sql
rm -f ${batchId}mergehtd.sql
sleep 1
echo "delete  custom.CUST_MPESA_RECON_TBL where  PROCESSED ='N'   and  ACCT_NUM is  null  and  file_name ='${ifilename}' and upl_batch_id='${batchId}'; " >${batchId}Invalidrec.sql
echo "commit;">>${batchId}Invalidrec.sql
exebatch bauu9151 ${batchId}Invalidrec.sql
rm -f ${batchId}Invalidrec.sql
sleep 1
echo "set head off;">${batchId}mcal.sql
echo "set trimspool on;">>${batchId}mcal.sql
echo "set trimout on;">>${batchId}mcal.sql
echo "set pages 0;">>${batchId}mcal.sql
echo "set feedback off;">>${batchId}mcal.sql
echo "set linesize 32767;">>${batchId}mcal.sql
echo "set echo off;">>${batchId}mcal.sql
echo "set long 90000;">>${batchId}mcal.sql
echo "spool ${batchId}_mcal.DAT;">>${batchId}mcal.sql
echo "select nvl(RECEIPT_NO,'NA')||'|'|| nvl(Paid_in,'NA')||'|'||nvl(acct_num,'NA')||'|'|| nvl(GL,'NA')||'|'||file_name||'|'||upl_batch_id from custom.cust_mpesa_recon_tbl where bank_id='${ibankid}' and upl_batch_id='${batchId}' and processed ='N' and file_name ='${ifilename}' ; " >> ${batchId}mcal.sql  
echo "spool off;">>${batchId}mcal.sql
exebatch bauu9151 ${batchId}mcal.sql
rm -f ${batchId}mcal.sql
sleep 1
exebatch -i ${batchId}_mcal.DAT -n ${nopj} babx4061 $B2K_SESSION_ID vpc2breCallTran.scr @s &
REPORTNAME=${ifilename}"_Upload_Report.TXT"
exebatch babx4040 $B2K_SESSION_ID ${REPORTNAME} 'C2B Auto Post Transaction Upload Report ' MANAGER 1 N
exit 0
