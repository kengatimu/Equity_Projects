---------------------------------------------------------------------------------
--    File Name                  : userswithoutbio.sql
--    Tables Used                : DDC
--    Date                       : 05-27-2019
--    Author                     : Edwin Zico
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          05-27-2019     Edwin Zico                  Original Version
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
spool userswithoutbio.lst
select S.USER_ID||'|'||G.EMP_NAME||'|'||U.SOL_ID
from  SSOADM.USER_PROFILE_TBL S,TBAADM.UPR U,TBAADM.GET G 
where REQ_TWO_FACTOR_AUTH ='N' AND S.user_id not in ('SM01534','CN01473') 
AND U.VIRTUAL_FLG ='N' AND S.HOME_ENTITY ='&2' AND U.SOL_ID ='&1' AND U.USER_WORK_CLASS !='011' AND U.DEL_FLG ='N' AND U.ROLE_ID !='DEL' 
AND U.USER_ID=S.USER_ID AND S.HOME_ENTITY=U.HOME_BANK_ID AND U.USER_EMP_ID =G.EMP_ID;
spool off;
exit;
