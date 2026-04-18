------------------------------------------------------------------------------------
--    File Name                  : unverifiedRaco.sql
--    Tables Used                : gam,tatt
--    Date                       : 22.04.2020
--    Author                     : Dennis Chirchir
-----------------------------------------------------------------------------------
set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool unverifiedRaco.lst
select sol_id||'|'|| foracid||'|'|| acct_name||'|'|| acct_opn_date||'|'||schm_code||'|'||acct_crncy_code||'|'||s.rcre_user_id
from tbaadm.gam g , tbaadm.tatt s where g.acid = s.acid and g.bank_id =s.bank_id and g.schm_type in ('ODA') and g.bank_id ='&1'
and g.ACCT_CLS_FLG ='N'  and sol_id='&2'
order by g.sol_id;
spool off;
exit;
