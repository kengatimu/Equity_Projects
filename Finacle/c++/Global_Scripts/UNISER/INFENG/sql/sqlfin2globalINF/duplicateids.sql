---------------------------------------------------------------------------------
--    File Name                  : duplicateids.sql
--    Tables Used                : crmuser.accounts
--    Date                       : 22.02.2013
--    Author                     : Gokulkrishna
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          22.02.2013     Gokulkrishna                  Original Version
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
spool duplicateids.lst
select primary_sol_id||'|'||orgkey||'|'||CUST_FIRST_NAME||'|'||CUST_LAST_NAME||'|'||accounts.uniqueid from crmuser.accounts where  
uniqueid in (select accounts.uniqueid from crmuser.accounts,(select count(orgkey),bank_id,UNIQUEID from crmuser.accounts where bank_id='&1' and UNIQUEID!='MIGR'
group by UNIQUEID,bank_id
having count(orgkey) >1)a
where accounts.uniqueid = a.UNIQUEID
and accounts.bank_id = a.bank_id
and accounts.bank_id ='&1'
and accounts.UNIQUEID!='MIGR'
and PRIMARY_SOL_ID ='&2'
) and bank_id='&1' order by UNIQUEID asc ;
spool off;
exit;

