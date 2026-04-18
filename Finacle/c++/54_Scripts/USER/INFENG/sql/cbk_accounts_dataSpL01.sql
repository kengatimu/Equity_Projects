set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool cbk_accounts_2022.lst

declare
cursor c1 is 
select foracid from custom.cbk_accounts_2022 where del_flg='N' and sol_id='&2';
begin
for i in c1 loop
  insert into custom.cbk_accounts_list_2022  SELECT INIT_SOL_ID,FORACID,ACCT_NAME,CLR_BAL_AMT,acct_cls_flg,(select acct_status from tbaadm.smt where smt.acid=adt.acid and rownum<2)Status,
ENTERER_ID,AUTH_ID ,MODIFIED_FIELDS_DATA,AUDIT_BOD_DATE 
FROM TBAADM.ADT,TBAADM.GAM WHERE GAM.ACID = ADT.ACID AND  TABLE_NAME ='SMT' AND GAM.BANK_ID='54' AND ADT.BANK_ID='54'
AND ((MODIFIED_FIELDS_DATA LIKE 'acct_status|D|A|%' ) OR  (MODIFIED_FIELDS_DATA LIKE 'acct_status|I|A|%' ) )
and adt.AUDIT_BOD_DATE>='01-jan-2021'
and adt.AUDIT_BOD_DATE<='31-dec-2022'
and gam.foracid =i.foracid;
commit;
update custom.cbk_accounts_2022 set del_flg='Y'  where del_flg='N'  and foracid=i.foracid;
commit;
end loop;
end;
/
commit;
/
spool off;
exit;


