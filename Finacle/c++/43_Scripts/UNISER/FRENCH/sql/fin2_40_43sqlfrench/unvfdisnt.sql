---------------------------------------------------------------------------------
--    File Name                  : unvfdisnt.sql
--    Tables Used                : GAM,GSP,EAB,CMG,GCT
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
spool unvfdisnt.lst
select C.SET_NUM||'|'||C.CLG_ZONE_CODE||'|'||C.CLG_ZONE_DATE||'|'||C.SOL_ID||'|'||C.ENTRY_USER_ID 
FROM TBAADM.OCI C,TBAADM.OZH Z
WHERE  C.clg_zone_date = Z.clg_zone_date
AND C.clg_zone_code = Z.clg_zone_code
and C.sol_id = Z.sol_id
AND C.STATUS_FLG NOT IN ('G','R','J')
AND C.sol_id  = '&1'
AND C.del_flg != 'Y' 
AND C.bank_id = Z.bank_id
AND Z.bank_id ='&2';
spool off;
exit;

