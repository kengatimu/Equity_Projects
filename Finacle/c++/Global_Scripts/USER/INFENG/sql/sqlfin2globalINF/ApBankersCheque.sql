---------------------------------------------------------------------------------
--    File Name                  : ApBankersCheque.sql
--    Tables Used                : FIN_DD_UPLOAD_TABLE
--    Date                       : 04.03.2013
--    Author                     : Prakash
--    Assumptions                : NA
--    Modification History       :
--    <Serial No.>    <Date>        <Author Name>       <Description>
--       1.          22.02.2013     Prakash             Original Version
-----------------------------------------------------------------------------------

set echo off
set feed off
set head off
set verify off
set term off
set pages 0
set linesize 303 
set trims off
set serveroutput on

spool BCHUPLOAD.TXT;
SELECT RPAD(BANK,6)||RPAD(BRANCHCODE,6)||RPAD(PAYEENAME,80)||lpad(AMOUNT,17)||RPAD(DIVPAYABLESAC,16)||IND||CCY||rpad(BANKERSCHEQAC,16)||rpad(REMARKS,158)
FROM CUSTOM.FIN_DD_UPLOAD_TABle  WHERE processed_flag='N' AND bank_id = '&1' ORDER BY instnumber
/
spool off;
/
update custom.fin_dd_upload_table  set  processed_flag='P'
where processed_flag='N'
AND bank_id = '&1'
/
Commit
/
