---------------------------------------------------------------------------------
--    File Name                  : cchqidp001.sql
--    Tables Used                : custom_cbr
--    Date                       : 17.12.2013
--    Author                     : Bharath
--    Assumptions                : NA
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>		<Description>
--       1.          17.12.2013     Bharath            		Original Version
-----------------------------------------------------------------------------------
set pages 0
set heading off
set feedback off
set linesize 861
set echo off
set verify off
set trims on

spool &6
SELECT 
rpad(' ',100,'-')
FROM DUAL;



SELECT  ' | ' ||
rpad('Request ID',12,' ')	|| ' | ' ||
rpad('Account ID',20,' ')	|| ' | ' ||
lpad('No.of ChqBooks',14,' ')	|| ' | ' ||
lpad('No.of Leaves',12,' ')	|| ' | ' ||
rpad('Req Date',12,' ')		|| ' | ' ||
rpad('Req Status',10,' ')	|| ' | '
FROM DUAL;

SELECT 
rpad(' ',100,'-')
FROM DUAL;

SELECT  ' | ' ||
rpad(req_id,12,' ')		|| ' | ' ||
rpad(foracid,20,' ')		|| ' | ' ||
lpad(num_of_chb,14,' ')		|| ' | ' ||
lpad(num_of_chq_lvs,12,' ')	|| ' | ' ||
rpad(req_date,12,' ')		|| ' | ' ||
rpad(req_status,10,' ')		|| ' | '
FROM custom.CUSTOM_CBR
where  
 foracid like '%&3%'
and req_status like '%&4%'
and BRANCH_ID like '&1'
and bank_id = '&5';

SELECT 
rpad(' ',100,'-')
FROM DUAL;

spool off

exit;
