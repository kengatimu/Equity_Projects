---------------------------------------------------------------------------------
--    File Name                  : payoff.sql
--    Tables Used                : CLTT,GAM
--    Date                       : 03.10.2016
--    Author                     : Kim Mugambi
--    Assumptions                : NIL
--    Modification History	 :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--     1.             03.10.2016    Kim Mugambi                  Original Version
--     2.             08-09-2018    james irungu                 include tran_id
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
spool payoff.lst
select gam.sol_id||'|'||gam.foracid||'|'||gam.acct_name||'|'||c.EVENT_ID||'|'||c.RCRE_USER_ID||'|'||c.VALUE_DATE||'|'||c.TRAN_ID from tbaadm.cltt c, tbaadm.gam  
where gam.acid =c.acid 
and gam.bank_id =c.bank_id
and gam.bank_id='&2'
and c.bank_id='&2'
AND c.value_date > '01-aug-2018' 
and gam.sol_id='&1';
spool off;
exit;

