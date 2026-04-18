#+++++++++++++++++++++++++++++++++
#FileName : ebGtJipZ.com 
#Author : Vino Palani
#Date   : 09/07/2019
#Desc   : JJCLS Job 
#+++++++++++++++++++++++++++++++++
npj=10
echo "set head off;">ebGtJipZ.sql
echo "set trims on;">>ebGtJipZ.sql
echo "set pages 0;">>ebGtJipZ.sql
echo "set feedback off;">>ebGtJipZ.sql
echo "set termout off;">>ebGtJipZ.sql
echo "spool ebGtJipZ${2}.lst;">>ebGtJipZ.sql
##echo "select gam.foracid||'|'||'01-03-2020 00:00:00' from tbaadm.gam,tbaadm.gac " >>ebGtJipZ.sql
echo "select gam.foracid||'|'||gac.free_text_10 from tbaadm.gam,tbaadm.gac " >>ebGtJipZ.sql
echo "where gam.bank_id='54'" >>ebGtJipZ.sql 
echo "and gac.bank_id='54'" >>ebGtJipZ.sql
echo "and gam.acid=gac.acid" >>ebGtJipZ.sql
echo "and gam.schm_type='SBA'" >>ebGtJipZ.sql
echo "and gam.schm_code ='SB700'" >>ebGtJipZ.sql
echo "and gam.entity_cre_flg='Y'" >>ebGtJipZ.sql 
echo "and gam.del_flg='N'" >>ebGtJipZ.sql 
echo "and gam.acct_cls_date is null " >>ebGtJipZ.sql
echo "and gam.sol_id=${2} " >>ebGtJipZ.sql
echo "and gam.acct_cls_flg <> 'Y' " >>ebGtJipZ.sql 
echo "and gac.free_text_1 in (select foracid from tbaadm.gam where bank_id='54' and acct_ownership<>'O'" >>ebGtJipZ.sql 
echo "and schm_type not in ('LAA','TDA','PCA','FBA','CLA'))" >>ebGtJipZ.sql
echo "and gac.free_text_2 is not null" >>ebGtJipZ.sql
echo "and gac.free_text_4 is not null;" >>ebGtJipZ.sql
echo "spool off;">>ebGtJipZ.sql

exebatch bauu9151 ebGtJipZ.sql

rm -f ebGtJipZ.sql

exebatch -i ebGtJipZ${2}.lst -n ${npj} babx4061 $B2K_SESSION_ID ebGtJipZ.scr @s

rm -f ebGtJipZ${2}.lst
exit 0
