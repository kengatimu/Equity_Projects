#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : ebcpluplEFT.com 
#  Description     :
#  Date            : 07-09-2020
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             07-09-2020      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
uuid=${2}
filp=${3}
tranYN=${4}
batchId=${5}
nopj="1"
echo "set head off;">${batchId}EFT.sql
echo "set trimspool on;">>${batchId}EFT.sql
echo "set trimout on;">>${batchId}EFT.sql
echo "set pages 0;">>${batchId}EFT.sql
echo "set feedback off;">>${batchId}EFT.sql
echo "set linesize 32767;">>${batchId}EFT.sql
echo "set echo off;">>${batchId}EFT.sql
echo "set long 90000;">>${batchId}EFT.sql
echo "spool ${batchId}EFT.DAT;">>${batchId}EFT.sql
echo "select dr_acct_num||'|'||beneficary_name||'|'||benef_bank_code||'|'||benef_branch_code||'|'||benef_account_num||'|'||tran_amt||'|'||tran_remarks||'|'||upl_sol_id||'|'||upl_ref_num||'|'||free_text4" >> ${batchId}EFT.sql
echo "from custom.plmt " >> ${batchId}EFT.sql
echo "where bank_id='54' " >> ${batchId}EFT.sql
echo "and upl_ref_num='${batchId}' " >> ${batchId}EFT.sql
echo "and core_tran_id is null " >> ${batchId}EFT.sql
echo "and core_tran_date is null " >> ${batchId}EFT.sql
echo "and process_staus='EFT' " >> ${batchId}EFT.sql
echo "and api_yn='E'; " >> ${batchId}EFT.sql
echo "spool off;">>${batchId}EFT.sql
exebatch bauu9151 ${batchId}EFT.sql
##rm -f ${batchId}EFT.sql
sleep 2
exebatch -i ${batchId}EFT.DAT -n ${nopj} babx4061 $B2K_SESSION_ID ebcpluplPEFT.scr @s &
##rm -f ${batchId}EFT.DAT
fi
exit 0


