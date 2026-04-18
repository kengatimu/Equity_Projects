---------------------------------------------------------------------------------
--    File Name                  : liens.sql
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
spool lien.lst
SELECT GAM.sol_id||'|'||GAM.foracid||'|'||SUBSTR(GAM.acct_name,1,30)||'|'||ADT.audit_bod_date FROM TBAADM.GAM,TBAADM.ADT
WHERE GAM.acid = ADT.acid 
AND ADT.init_sol_id in (SELECT sol_id FROM TBAADM.SST WHERE set_id = '&1' AND bank_id = '&2')
AND ADT.table_name = 'ALT'
AND ADT.auth_id = '!'
AND GAM.bank_id = ADT.bank_id
AND GAM.bank_id = '&2';
spool off;
exit;
