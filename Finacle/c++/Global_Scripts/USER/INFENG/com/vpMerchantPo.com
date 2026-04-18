#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vpMerchantPo.com 
#  Description     :
#  Date            : 24-08-2021
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             24-08-2021      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cd /finacle/EQPROD/BackEnd/Finacle/FC/app/CDCI_LOGS/CDCI54
batchId=${1}
nopj="5"
echo "set head off;">${batchId}PO.sql
echo "set trimspool on;">>${batchId}PO.sql
echo "set trimout on;">>${batchId}PO.sql
echo "set pages 0;">>${batchId}PO.sql
echo "set feedback off;">>${batchId}PO.sql
echo "set linesize 32767;">>${batchId}PO.sql
echo "set echo off;">>${batchId}PO.sql
echo "set long 90000;">>${batchId}PO.sql
echo "spool ${batchId}PO.DAT;">>${batchId}PO.sql
echo "select upl_batch_id||'|'||dr_acct_id||'|'||benef_acct_id||'|'||benef_bic_code||'|'||remit_amt from custom.cust_merchant_po_tbl where bank_id='54' and upl_batch_id='${batchId}' and entity_cre_flg='Y' and del_flg='N' " >> ${batchId}PO.sql
echo "and process_status='U'; " >> ${batchId}PO.sql
echo "spool off;">>${batchId}PO.sql
exebatch bauu9151 ${batchId}PO.sql
rm -f ${batchId}PO.sql
sleep 1
exebatch -i ${batchId}PO.DAT -n ${nopj} babx4061 $B2K_SESSION_ID vpMerchantPo.scr @s &
##rm -f ${batchId}PO.DAT
exit 0


