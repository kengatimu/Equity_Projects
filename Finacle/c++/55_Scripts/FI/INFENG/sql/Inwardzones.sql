---------------------------------------------------------------------------------
--    File Name                  : Inwardzones.sql
--    Tables Used                : IZH
--    Date                       : 05.10.2015
--    Author                     : Kim Mugambi
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          01.10.2015     Kim Mugambi                  Original Version
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
spool Inwardzones.lst
SELECT SOL_ID||'|'||ZONE_CODE||'|'||ZONE_DATE||'|'||ZONE_STAT||'|'||LCHG_USER_ID
FROM TBAADM.IZH
WHERE sol_id = '&1'
AND zone_stat in ('O','S') 
AND Zone_date < = sysdate
AND bank_id = '&2';
spool off;
exit;

