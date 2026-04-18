#+++++++++++++++++++++++++++++++++
#FileName : ebGtJipPayoutJob.com 
#Author : Vino Palani
#Date   : 17/07/2019
#Desc   : JJPAY Job 
#+++++++++++++++++++++++++++++++++
npj=10
echo "set head off;">ebGtJipPayoutJob.sql
echo "set trims on;">>ebGtJipPayoutJob.sql
echo "set pages 0;">>ebGtJipPayoutJob.sql
echo "set feedback off;">>ebGtJipPayoutJob.sql
echo "set termout off;">>ebGtJipPayoutJob.sql
echo "spool ebGtJipPayoutJob${2}.lst;">>ebGtJipPayoutJob.sql
echo "select gam.foracid from tbaadm.gam,tbaadm.gac " >>ebGtJipPayoutJob.sql
echo "where gam.bank_id='54'" >>ebGtJipPayoutJob.sql 
echo "and gac.bank_id='54'" >>ebGtJipPayoutJob.sql
echo "and gam.acid=gac.acid" >>ebGtJipPayoutJob.sql
echo "and gam.schm_type='SBA'" >>ebGtJipPayoutJob.sql
echo "and gam.schm_code ='SB700'" >>ebGtJipPayoutJob.sql
echo "and gam.entity_cre_flg='Y'" >>ebGtJipPayoutJob.sql 
echo "and gam.del_flg='N'" >>ebGtJipPayoutJob.sql 
echo "and gam.acct_cls_date is null " >>ebGtJipPayoutJob.sql
echo "and gam.sol_id in (select sol_id from tbaadm.sst where bank_id='54' and set_id='${2}' and entity_cre_flg='Y' and del_flg='N' )" >>ebGtJipPayoutJob.sql
echo "and gam.acct_cls_flg <> 'Y' " >>ebGtJipPayoutJob.sql 
echo "and gac.free_text_1 in (select foracid from tbaadm.gam where bank_id='54' and acct_ownership<>'O'" >>ebGtJipPayoutJob.sql 
echo "and schm_type not in ('LAA','TDA','PCA','FBA','CLA') and sol_id='${2}')" >>ebGtJipPayoutJob.sql
echo "and gac.free_text_2 is not null" >>ebGtJipPayoutJob.sql
echo "and gac.free_text_4 is not null" >>ebGtJipPayoutJob.sql
echo "and (gac.free_text_8 like 'OCT%' or gac.free_text_8 is null)" >>ebGtJipPayoutJob.sql 
echo "and (gac.free_text_9 like 'APR%' or gac.free_text_9 is null);" >>ebGtJipPayoutJob.sql 
echo "spool off;">>ebGtJipPayoutJob.sql

exebatch bauu9151 ebGtJipPayoutJob.sql

##rm -f ebGtJipPayoutJob.sql

exebatch -i ebGtJipPayoutJob${2}.lst -n ${npj} babx4061 $B2K_SESSION_ID ebGtJipPayoutJob.scr @s

##rm -f ebGtJipPayoutJob${2}.lst
exit 0
