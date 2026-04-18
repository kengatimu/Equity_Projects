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
select OCS.SET_NUM||'|'||OCS.CLG_ZONE_CODE||'|'||OCS.CLG_ZONE_DATE||'|'||OCS.SOL_ID from TBAADM.ocs,TBAADM.ozh
WHERE ocs.CLG_ZONE_CODE=ozh.CLG_ZONE_CODE
and ocs.CLG_ZONE_DATE = ozh.CLG_ZONE_DATE
and ocs.sol_id = ozh.sol_id
and (VFD_DATE is null or VFD_USER_ID  is null)
and ZONE_STAT not in ('C','R') 
and ocs.del_flg!='Y'
and OCS.sol_id = '&1'
AND OCS.bank_id = OZH.bank_id
AND OCS.bank_id = '&2';
spool off;
exit;
