---------------------------------------------------------------------------------
--    File Name                  : closed.sql
--    Tables Used                : GAM
--    Date                       : 22.02.2013
--    Author                     : Gokulkrishna
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          22.02.2013     Gokulkrishna                  Original Version INFENG
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
spool closedcharges.lst
select gam.sol_id||'|'||gam.FORACID||'|'||substr(gam.ACCT_NAME,1,30)||'|'||'USE_HCACC_CANCEL_VERIFY' from tbaadm.gam
where sol_id ='&1' 
AND acct_cls_chrg_pend_verf='Y' and schm_type in ('SBA','CAA','ODA') and acct_cls_flg='N' ;
spool off;
exit;
