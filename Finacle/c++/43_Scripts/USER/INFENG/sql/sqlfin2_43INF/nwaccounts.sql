---------------------------------------------------------------------------------
--    File Name                  : newaccounts.sql
--    Tables Used                : GAM
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
spool nwaccounts.lst
select gam.sol_id||'|'||gam.FORACID||'|'||substr(gam.ACCT_NAME,1,30)||'|'||adt.AUDIT_BOD_DATE from gam,adt
where gam.acid=adt.acid 
and adt.AUDIT_SOL_ID in (select sol_id from sst where SET_ID = '&1')
and adt.TABLE_NAME='GAM' 
and ADT.FUNC_CODE ='A'
and adt.AUTH_ID='!';
spool off;
exit;