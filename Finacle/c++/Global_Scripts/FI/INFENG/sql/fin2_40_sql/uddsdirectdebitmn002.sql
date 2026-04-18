ges 0
set heading off
set feedback off
set linesize 400
set echo off
set verify off
set trims on
set serveroutput on
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
exec custom.ebkSalProof.directdebits('&2');
/
spool off;
select '&v_filename'||'.lst' fn from dual
/
spool &v_filename;
select RECTYPE||'|'||CLIENTREF||'|'||BRANCHCODE||'|'||CLIENTACNO||'|'||CLIENTNAME||'|'||AMOUNT||'|'||POLICYNO||'|'||STATUS||'|'||to_char(DUEDATE,'DD/MM/YYYY')||'|'||to_char(sysdate,'DD/MM/YYYY')||'|'||REMARKS l 
from CUSTOM.C_DDS
WHERE bank_id = '&2'
order by STATUS
/
spool off;
exit;
