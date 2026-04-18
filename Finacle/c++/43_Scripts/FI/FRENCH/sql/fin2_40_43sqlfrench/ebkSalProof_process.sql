---------------------------------------------------------------------------------
--    File Name                  : ebkSalProof_process.sql 
--    Tables Used                : GAM,CUSTOM.c_sup
--    Date                       : 13.03.2013
--    Author                     : GOKULKRISHNA 
--    Assumptions                : NA
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>		<Description>
--       1.          13.03.2013     GOKULKRISHNA            Original Version
--       2.          18.07.2013     Bharath 			Validation added for other currency accounts
-----------------------------------------------------------------------------------
set pages 0
set heading off
set feedback off
set linesize 400
set echo off
set verify off
set trims on
set serveroutput on
col ee  new_value v_employer noprint
col uu  new_value v_userid noprint
col l new_value v_len
col inp new_value v_input noprint
col fn  new_value v_filename noprint
col bank  new_value v_bank_id noprint
col sysdatetime new_value v_sysdatetime noprint

select '&1' inp from dual
/
select substr('&v_input',1,INSTR('&v_input',',') - 1) ee ,substr('&v_input',instr('&v_input',',') + 1) inp from dual
/
select substr('&v_input',1,INSTR('&v_input',',') - 1) uu ,substr('&v_input',instr('&v_input',',') + 1) inp  from dual
/
select substr('&v_input',1,INSTR('&v_input',',') - 1) bank ,substr('&v_input',instr('&v_input',',') + 1) inp  from dual
/
select '&v_input' sysdatetime from dual
/
spool off
spool processtime.lst
select 'Started at'||to_char(sysdate,'HH:MI:SS') l from dual
/
exec CUSTOM.ebkSalProof_43.process('&v_employer','&v_userid','&v_bank_id', '&2')
/
select 'End at'||to_char(sysdate,'HH:MI:SS') l from dual
/
--select '&v_bank_id'||'&v_employer'||'&v_userid' 1 from dual
--/
spool off;
select '&v_employer'||'_'||'&v_sysdatetime'||'.lst' fn from dual
/
spool &v_filename
select c_sup.EMPLOYER||','||c_sup.ACCT_CRNCY_CODE||','||c_sup.SOL_ID||','||c_sup.UPL_ACCT_NO||','||c_sup.SAL_CR_AMT||','||c_sup.INVALID||','||c_sup.TRAN_PARTICULAR||','||
c_sup.UPL_ACCT_NAME||','||GAM_ACCT||','||c_sup.EMPLOYEE_ID||','||C_SUP.RMK from CUSTOM.c_sup
where c_sup.EMPLOYER = '&v_employer'
and c_sup.RCRE_USER_ID ='&v_userid'
and bank_id = '&v_bank_id'
/
spool off;
exit;
