---------------------------------------------------------------------------------
--    File Name                  : zeroigls.sql
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
spool zeroigls.lst
SELECT  gam.sol_id||'|'||gam.FORACID||'|'||substr(gam.ACCT_NAME,1,30)||'|'||CLR_BAL_AMT from GAM where CLR_BAL_AMT !=0 
AND bacid = '&3' 
and gam.SOL_ID = '&1'
AND GAM.bank_id = '&2';
spool off;
exit;
