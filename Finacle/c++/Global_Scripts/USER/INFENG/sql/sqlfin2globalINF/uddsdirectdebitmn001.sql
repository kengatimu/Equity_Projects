set feedback off
set pages 0
set heading off
set linesize 861
set echo off
set verify off
set trims on
col sol new_value v_sol_id noprint;
col ff  new_value v_foracid noprint
col ee  new_value v_employer noprint
col uu  new_value v_userid noprint
col trmk new_value v_tran_rm noprint
col cur new_value v_cur noprint
col tamt new_value v_amt noprint
col fn  new_value v_filename noprint
col ch  new_value v_charge_amt noprint
col tmp  new_value v_tmp noprint
col bank new_value v_bank_id noprint;
col crncy new_value v_crncy_code noprint;
col bacid new_value v_bacid noprint;

select  '&1' tmp from dual
/
select substr('&v_tmp',1,instr('&v_tmp',',') - 1) sol,substr('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select substr('&v_tmp',1,instr('&v_tmp',',') - 1) ff,substr('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select substr('&v_tmp',1,instr('&v_tmp',',') - 1) ee,substr('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select substr('&v_tmp',1,instr('&v_tmp',',') - 1) uu,substr('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select substr('&v_tmp',1,instr('&v_tmp',',') - 1) ch,substr('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select substr('&v_tmp',1,instr('&v_tmp',',') - 1) bank,substr('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select substr('&v_tmp',1,instr('&v_tmp',',') - 1) crncy,substr('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select '&v_tmp' bacid from dual
/
select 'BL'||to_char(sysdate,'ddmmyy')||'.STS'  fn from dual
/
set trims off
spool &v_filename
select '01|68-000|BL'||to_char(sysdate,'ddmmyy')||'.STS'||'|'||to_char(sysdate,'dd/mm/yyyy')||'|&v_crncy_code'  from dual
/
select RECTYPE||'|'||CLIENTREF||'|'||BANKCODE||'|'||BRANCHCODE||'|'||CLIENTBANKNAME||'|'||CLIENTBANKBRANCH||'|'||AMOUNT||'|'||POLICYNO||'|'||STATUS||'|'||to_char(DUEDATE,'DD/MM/YYYY')||'|'||to_char(sysdate,'DD/MM/YYYY') l 
from CUSTOM.c_dds
where bank_id = '&v_bank_id'
order by STATUS
/
select '03|'||count(1)||'|'||sum(nvl(amount,0))||'|'||sum(decode(status,'ACC',1,0))||'|'||sum(decode(status,'ACC',amount,0))||'|'||sum(decode(status,'ACC',0,1))||'|'||sum(decode(status,'ACC',amount,1)) from CUSTOM.c_dds
where bank_id = '&v_bank_id'
/
spool off;
/
select '&v_employer'||'_APPLIED_'||to_char(sysdate,'DD-MM-YYYY')||'.SUC' fn from dual
/
select '&v_crncy_code' cur,REMARKS trmk
from CUSTOM.C_DDS
where STATUS in ('ACC')
and UPL_STATUS='P'
and ORIGINATOR_CODE='&v_employer'
and RCRE_USER_ID='&v_userid'
and bank_id = '&v_bank_id'
and del_flg ='N'
and rownum < 2
/
select sum(nvl(AMOUNT,0)) tamt
from CUSTOM.C_DDS
where STATUS in ('ACC')
and UPL_STATUS='P'
and ORIGINATOR_CODE='&v_employer'
and bank_id = '&v_bank_id'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
/
set trims off
spool &v_filename
select RPAD(CLIENTACNO,16,' ')||RPAD('&v_crncy_code',3,' ')||RPAD(SOL_ID,8,' ')||'D'||LPAD(trim(AMOUNT),17,' ')||RPAD(REMARKS,17,' ')||RPAD(' ',799,' ')
from CUSTOM.C_DDS
where STATUS in ('ACC')
and UPL_STATUS='P'
and ORIGINATOR_CODE='&v_employer'
and bank_id = '&v_bank_id'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
/
select RPAD('&v_foracid',16,' ')||RPAD('&v_cur',3,' ')||RPAD('&v_sol_id',8,' ')||'C'||LPAD(trim('&v_amt'),17,' ')||RPAD('&v_tran_rm',17,' ')||RPAD(' ',799,' ')
from dual
/
spool off;
select '&v_employer'||'_UNAPPLIED_'||to_char(sysdate,'DD-MM-YYYY')||'.SUC' fn from dual
/
set trims off
spool &v_filename
select RPAD(CLIENTACNO,16,' ')||RPAD('&v_crncy_code',3,' ')||RPAD(SOL_ID,8,' ')||'D'||LPAD(trim(AMOUNT),17,' ')||RPAD(REMARKS,17,' ')||RPAD(' ',799,' ')
from CUSTOM.C_DDS
where STATUS in ('RIF')
and UPL_STATUS='P'
and ORIGINATOR_CODE='&v_employer'
and bank_id = '&v_bank_id'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
/
select RPAD(CLIENTACNO,16,' ')||RPAD('&v_crncy_code',3,' ')||RPAD(SOL_ID,8,' ')||'C'||LPAD(trim(AMOUNT),17,' ')||RPAD(REMARKS,17,' ')||RPAD(' ',799,' ')
from CUSTOM.C_DDS
where STATUS in ('RIF')
and UPL_STATUS='P'
and ORIGINATOR_CODE='&v_employer'
and bank_id = '&v_bank_id'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
/
spool off;
/
select '&v_employer'||'_Charge_'||to_char(sysdate,'DD-MM-YYYY')||'.SUC' fn from dual
/
set trims off
spool &v_filename;
select RPAD(custom.ebkSalProof.creditors('&v_bacid','&v_sol_id','&v_bank_id'),16,' ')||RPAD('&v_crncy_code',3,' ')||RPAD(sol_id,8,' ')||'C'||LPAD(to_char(count(1) * '&v_charge_amt'),17,' ')||RPAD('Direct',46,' ')
from CUSTOM.C_DDS
where STATUS in ('RIF')
and UPL_STATUS='P'
and ORIGINATOR_CODE='&v_employer'
and bank_id = '&v_bank_id'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
group by sol_id
/
select RPAD(CLIENTACNO,16,' ')||RPAD('&v_crncy_code',3,' ')||RPAD(sol_id,8,' ')||'D'||LPAD(&v_charge_amt,17,' ')||RPAD('Unapplied Direct debit Comm',46,' ')
from CUSTOM.C_DDS
where STATUS in ('RIF')
and UPL_STATUS='P'
and ORIGINATOR_CODE='&v_employer'
and bank_id = '&v_bank_id'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
/
spool off;
/
update CUSTOM.C_DDS
set del_flg='N',UPL_STATUS='U'
where originator_code='&v_employer'
and RCRE_USER_ID='&v_userid'
and bank_id = '&v_bank_id'
and del_flg ='N'
/
commit
/
spool off;
exit

