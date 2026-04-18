---------------------------------------------------------------------------------
--    File Name                  : zeroloan.sql
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
spool zeroloan.lst
select gam.sol_id||'|'||gam.FORACID||'|'||substr(gam.ACCT_NAME,1,30)||'|'||CLR_BAL_AMT
from TBAADM.GAM,TBAADM.gac
where gam.acid=gac.acid 
AND (gac.CHRGE_OFF_FLG!='Y' or gac.CHRGE_OFF_FLG IS NULL)
AND gam.SCHM_TYPE='LAA' 
and gam.acct_cls_flg!='Y' 
and gam.clr_bal_amt=0 
and gam.SOL_ID = '&1'
AND GAM.bank_id = GAC.bank_id
AND GAM.bank_id = '&2';
spool off;
exit;
