---------------------------------------------------------------------------------
--    File Name                  : cheque.sql
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
spool cheque.lst
SELECT req_id||'|'||foracid||'|'||branch_id||'|'||begin_chq_num||'|'||num_of_chb||'|'||
num_of_chq_lvs||'|'||req_date FROM CUSTOM.CUSTOM_CBR
WHERE req_status = 'E'
AND (del_flg != 'Y' OR del_flg  IS NULL)
AND branch_id IN (SELECT sol_id FROM TBAADM.SST WHERE set_id = '&1' AND bank_id = '&2')
AND bank_id = '&2';
spool off;
exit;
