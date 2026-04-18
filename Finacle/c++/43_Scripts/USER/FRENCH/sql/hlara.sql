---------------------------------------------------------------------------------
--    File Name                  : hlara.sql
--    Tables Used                : ADT,GAM
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
spool hlara.lst
SELECT  DISTINCT GAM.FORACID||'|'||GAM.ACCT_NAME||'|'||ENTERER_ID||'|'||AUDIT_DATE
FROM TBAADM.ADT,TBAADM.GAM 
WHERE ADT.init_sol_id = '&1'
AND ADT.table_name = 'LRS'
AND ADT.auth_id='!'
AND ADT.bank_id = '&2'
AND ADT.ACID=GAM.ACID
AND GAM.BANK_ID='&2';
spool off;
exit;
