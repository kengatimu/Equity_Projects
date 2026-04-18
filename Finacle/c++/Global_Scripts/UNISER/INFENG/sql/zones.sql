---------------------------------------------------------------------------------
--    File Name                  : zones.sql
--    Tables Used                : OZH
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
spool zones.lst
SELECT SOL_ID||'|'||CLG_ZONE_DATE||'|'||CLG_ZONE_CODE||'|'||ZONE_STAT||'|'||SETS_ENTERED||'|'||SETS_VERIFIED 
FROM tbaadm.OZH
WHERE OZH.sol_id = '&1'
AND OZH.zone_stat in ('O','S')
AND OZH.clg_zone_date < = sysdate
AND OZH.del_flg = 'N'
AND OZH.bank_id= '&2';
spool off;
exit;

