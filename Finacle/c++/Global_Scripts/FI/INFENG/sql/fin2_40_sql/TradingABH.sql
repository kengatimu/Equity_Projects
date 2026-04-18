---------------------------------------------------------------------------------
--    File Name                  : TradingABH.sql
--    Tables Used                : GAM,DTD
--    Date                       : 22.02.2013
--    Author                     : Gokulkrishna
--    AsSUMptions                : NIL
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
spool TradingABH.lst

SELECT SOL_ID||'|'||TRANS_DATE||'|'||REF_NUM||'|'||AMOUNT||'|'||ACCT_NUM||'|'||ENTERED_BY
FROM 
    (select SOL_ID,TRANS_DATE,REF_NUM,AMOUNT,ACCT_NUM,ENTERED_BY from custom.sale_details where TRANS_STATUS not in('V','D') and SOL_ID = '&1')
/
spool off;
exit;
