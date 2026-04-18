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
spool TradingABHpur.lst

SELECT TRAN_SOL_ID||'|'||TRAN_DATE||'|'||TRAN_ID||'|'||TRAN_AMOUNT||'|'||ACCOUNT_NUMBER||'|'||CREATED_BY_ID
FROM 
   (select TRAN_SOL_ID,TRAN_DATE,TRAN_ID,TRAN_AMOUNT,ACCOUNT_NUMBER,CREATED_BY_ID from custom.share_purchase_master where IS_VERIFIED=0 and TRAN_SOL_ID='&1')

/
spool off;
exit;
