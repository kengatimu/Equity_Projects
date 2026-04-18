---------------------------------------------------------------------------------
--    File Name                  : hotce.sql
--    Tables Used                : ADT
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
spool hotce.lst
SELECT init_sol_id||'|'||ADT.audit_bod_date||'|'||TRIM(ADT.table_key) FROM TBAADM.ADT
WHERE ADT.init_sol_id in (SELECT sol_id from TBAADM.SST WHERE set_id = '&1' AND bank_id = '&2')
AND ADT.table_name = 'OTC'
AND ADT.auth_id = '!'
AND bank_id = '&2';
spool off;
exit;
