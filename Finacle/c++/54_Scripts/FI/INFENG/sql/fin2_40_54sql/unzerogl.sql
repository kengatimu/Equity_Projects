---------------------------------------------------------------------------------
--    File Name                  : unzeroigls.sql
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
spool unzerogl.lst
select gam.sol_id||'|'||gam.FORACID||'|'||substr(gam.ACCT_NAME,1,30)||'|'||clr_bal_amt from TBAADM.gam
where CLR_BAL_AMT != 0
AND INSTR('&3', '!'||SUBSTR(foracid,4,13)||'!') > 0
and SOL_ID  = '&1'
AND bank_id = '&2';
spool off;
exit;
