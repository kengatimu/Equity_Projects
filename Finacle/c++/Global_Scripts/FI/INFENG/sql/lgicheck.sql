set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool lgicheck.lst

/
update crmuser.accounts set OFFLINE_CUM_DEBIT_LIMIT='999999.99' where orgkey in (select orgkey from crmuser.accounts where BODATECREATED >= (select db_stat_date from tbaadm.gct where bank_id ='54'))
/
update tbaadm.upr set user_Work_class ='150'  where role_id ='AMO' and home_bank_id in ('54','50') and user_Work_class ='200'
/
update tbaadm.upr set role_id ='CAO2' where role_id='AMO' and user_work_class='110' and home_bank_id ='54'
/
update tbaadm.adt set auth_id ='SYSTEM' where acid in  (select acid from tbaadm.cltt where bank_id ='99')and auth_id ='!' and bank_id ='99'
/
commit
/
delete from tbaadm.cltt where bank_id ='99'
/
commit
/
update crmuser.accounts_mod set recordstatus='F' where bank_id ='56' and recordstatus='D' and BOCREATEDBY='407776'
/
commit
/
Update tbaadm.chat set CHRGE_AMT_COLLECTED=USER_CALC_CHRGE_AMT where acid in(SELECT ACID FROM TBAADM.GAM where schm_code='LA527' and acct_cls_flg<>'Y' and clr_bal_amt=0 and bank_id='54' and entity_cre_flg='Y' and acct_opn_date<(select db_stat_date from tbaadm.gct where bank_id ='54')) and CHRGE_AMT_COLLECTED<>USER_CALC_CHRGE_AMT and bank_id='54'
/
drop table custom.cif_issue
/
create table custom.cif_issue as (select mod.orgkey, mod.recordstatus ModSTAT,ac.recordstatus aCCOUNTSSTAT,mod.entity_cre_flag ModEntity_cre_flag,ac.entity_cre_flag AccountsEntity_cre_flag, MOD.CREATEDBYSYSTEMID, MOD.BODATECREATED from crmuser.accounts_mod mod,crmuser.accounts ac where mod.orgkey=ac.orgkey and mod.bank_id ='54' and ac.entity_cre_flag='Y' and mod.recordstatus  IN ('F','R') AND ac.recordstatus = 'A' AND MOD.ORGKEY NOT IN (SELECT ORGKEY FROM CRMUSER.ADDRESS_MOD WHERE ORGKEY IN (select mod.orgkey from crmuser.accounts_mod mod,crmuser.accounts ac where mod.orgkey=ac.orgkey and mod.bank_id ='54' and ac.entity_cre_flag='Y' and mod.recordstatus in ('F') AND ac.recordstatus = 'A' )))
/
delete from crmuser.accounts_mod where orgkey in(select orgkey from custom.cif_issue)
/
delete from crmuser.entitydocument_mod where orgkey in(select orgkey from custom.cif_issue)
/
commit
/
spool off;
exit;


