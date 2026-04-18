set pages 0
set heading off
set feedback off
set linesize 400
set echo on
set verify off
set trims on
set serveroutput on size 30000
col uu  new_value v_userid noprint
col l new_value v_len
col inp new_value v_input
col fn  new_value v_filename noprint
select '&1' inp from dual
/
select substr('&v_input',1,INSTR('&v_input',',') - 1) fn ,length(substr('&v_input',1,INSTR('&v_input',',') + 1 )) l from dual
/
select substr('&v_input',&v_len) uu from dual
/
exec CUSTOM.ebkSalProof.kbadirectdebits('&2');
/
select '&v_filename'||'.lst' fn from dual
/
spool &3
select STATUS||'|'||ORIGINATOR_REF||'|'||DEBITBANKBRANCH||'|'||DEBITACCTNUM||'|'||POLICYNUM1||'|'||AMOUNT||'|'||REMARKS l 
from CUSTOM.C_KBADDS
WHERE bank_id = '&2'
order by STATUS
/
spool off;
exit;
