#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#  Name            : vptmRTDpost.com
#  Description     :
#  Date            : 01-03-2022
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             01-03-2022      Vino Palani          Original Version
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
cd /finacle/EQDR/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/CDCI54
echo $0
echo $#
echo $$
batchId="RTD-"`date +%d%m%Y%H%M%S`
nopj="1"
pidd=$B2K_SESSION_ID
ubankid=`echo $FIN_BANK_ID`
echo "set head off;">${batchId}.sql
echo "set trimspool on;">>${batchId}.sql
echo "set trimout on;">>${batchId}.sql
echo "set pages 0;">>${batchId}.sql
echo "set feedback off;">>${batchId}.sql
echo "set linesize 32767;">>${batchId}.sql
echo "set echo off;">>${batchId}.sql
echo "set long 90000;">>${batchId}.sql
echo "spool ${batchId}.DAT;">>${batchId}.sql
echo "select req_uuid||'|'||value_date||'|'||rcre_time from custom.cust_treasury_deal_tbl where bank_id='${ubankid}' and req_channel_id='RTD' and pstd_flg='N' and pstd_date is null and pstd_user_id is null and entity_cre_flg='N' and del_flg='N' and free_text_4 is null and free_text_3='Insufficient Fund' and failue_desc='DRBalance' and exists ( select req_uuid from custom.cust_treasury_deal_tbl s where s.bank_id='${ubankid}' and s.req_uuid=req_uuid and s.req_channel_id='RTD' and s.pstd_flg='N' and s.pstd_date is null and s.pstd_user_id is null and s.entity_cre_flg='N' and s.del_flg='N' and s.free_text_4 is null and s.free_text_3='Insufficient Fund' and s.failue_desc='DRBalance' and trunc(s.rcre_time)=(select db_stat_date from tbaadm.gct where bank_id='${ubankid}') and s.tran_amount < (select clr_bal_amt from tbaadm.gam where bank_id='${ubankid}' and entity_cre_flg='Y' and del_flg='N' and acct_cls_flg <>'Y' and acct_cls_date is null and foracid=s.foracid)) and trunc(rcre_time)=(select db_stat_date from tbaadm.gct where bank_id='${ubankid}'); " >> ${batchId}.sql
echo "spool off;">>${batchId}.sql
exebatch bauu9151 ${batchId}.sql
rm -f ${batchId}.sql
sleep 1
noOfLine=`cat ${batchId}.DAT|wc -l`
if [ ${noOfLine} -gt 1 ]
then
exebatch -i ${batchId}.DAT -n ${nopj} babx4061 $B2K_SESSION_ID vptmRTDpost.scr @s &
######rm -f ${batchId}.DAT
else
rm -f ${batchId}.DAT
fi
exit 0
