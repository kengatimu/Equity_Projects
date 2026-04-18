---------------------------------------------------------------------------------
--    File Name                  : ebkSalProof_upload.sql 
--    Tables Used                : GAM,CUSTOM.c_sup
--    Date                       : 13.03.2013
--    Author                     : GOKULKRISHNA 
--    Assumptions                : NA
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>		<Description>
--       1.          13.03.2013     GOKULKRISHNA            Original Version
-----------------------------------------------------------------------------------
set pages 0
set heading off
set feedback off
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
col ch new_value v_charge_amt noprint
col tmp new_value v_tmp noprint
col bank new_value v_bank_id noprint
col sysdatetime new_value v_sysdatetime noprint
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
select '&v_tmp' sysdatetime from dual
/
select '&v_employer'||'_Sal_Upl_'||'&v_sysdatetime'||'.SUC' fn from dual
/
spool &v_filename
select RPAD(ACCT_CRNCY_CODE,3,' ')||RPAD(FORACID,16,' ')||RPAD(SAL_CR_AMT,17,' ')||RPAD(sol_id,8,' ')||'C'||RPAD(TRAN_PARTICULAR,46,' ')  l 
from CUSTOM.c_sup
where INVALID in ('S','N')
and UPL_STATUS='P'
and EMPLOYER='&v_employer'
and RCRE_USER_ID ='&v_userid'
and del_flg ='N'
and bank_id = '&v_bank_id'
/
spool off
select '&v_employer'||'_Sus_Cr_'||'&v_sysdatetime'||'.SUC' fn from dual
/
select ACCT_CRNCY_CODE cur,TRAN_PARTICULAR trmk
from CUSTOM.c_sup
where INVALID  = ('Y')
and UPL_STATUS='P'
and EMPLOYER='&v_employer'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
and bank_id = '&v_bank_id'
and rownum < 2
/
select sum(nvl(SAL_CR_AMT,0)) tamt
from CUSTOM.c_sup
where INVALID  = ('Y')
and UPL_STATUS='P'
and EMPLOYER='&v_employer'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
and bank_id = '&v_bank_id'
/
set trims off
spool &v_filename;
select RPAD('&v_foracid',16,' ')||RPAD('&v_cur',3,' ')||RPAD('&v_sol_id',8,' ')||'D'||LPAD(trim('&v_amt'),17,' ')||RPAD('&v_tran_rm',17,' ')||RPAD(' ',799,' ')
from dual
/
select RPAD(custom.ebkSalProof.creditors('SUSPCR509','&v_sol_id','&v_bank_id'),16,' ')||RPAD(ACCT_CRNCY_CODE,3,' ')||RPAD('&v_sol_id',8,' ')||'C'||LPAD(SAL_CR_AMT,17,' ')||RPAD((UPL_ACCT_NO||' '||SUBSTR(UPL_ACCT_NAME,1,10)||' '||TRAN_PARTICULAR),17,' ')||RPAD(' ',799,' ')
from CUSTOM.c_sup
where INVALID  = ('Y')
and UPL_STATUS='P'
and EMPLOYER='&v_employer'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
and bank_id = '&v_bank_id'
/
spool off;
select '&v_employer'||'_Sal_Chg_'||'&v_sysdatetime'||'.SUC' fn from dual
/
spool &v_filename;
select decode('&v_employer','KTDA',RPAD(custom.ebkSalProof.creditors('PNLTEA',c_sup.sol_id,c_sup.bank_id),16,' '),RPAD(custom.ebkSalProof.creditors('PNLSALREM',c_sup.sol_id,c_sup.bank_id),16,' '))||RPAD(c_sup.ACCT_CRNCY_CODE,3,' ')||RPAD(c_sup.sol_id,8,' ')||'C'||RPAD(to_char(count(1) * '&v_charge_amt'),17,' ')||RPAD('Remittance Commission',46,' ')
from CUSTOm.c_sup,gam
where c_sup.FORACID=gam.FORACID
AND c_sup.INVALID in ('S','N')
AND gam.SCHM_CODE!='SB190'
and c_sup.UPL_STATUS='P'
and c_sup.EMPLOYER='&v_employer'
and c_sup.RCRE_USER_ID='&v_userid'
and c_sup.del_flg ='N'
and SAL_CR_AMT > 100
and C_sup.bank_id = gam.bank_id
and GAM.bank_id = '&v_bank_id'
group by c_sup.sol_id,c_sup.ACCT_CRNCY_CODE,decode('&v_employer','KTDA',RPAD(custom.ebkSalProof.creditors('PNLTEA',c_sup.sol_id,c_sup.bank_id),16,' '),RPAD(custom.ebkSalProof.creditors('PNLSALREM',c_sup.sol_id,c_sup.bank_id),16,' '))
/
select RPAD(c_sup.FORACID,16,' ')||RPAD(c_sup.ACCT_CRNCY_CODE,3,' ')||RPAD(c_sup.sol_id,8,' ')||'D'||RPAD('&v_charge_amt',17,' ')||RPAD('Remmittance Commission',46,' ')
from CUSTOM.c_sup,gam
where c_sup.FORACID=gam.FORACID
AND gam.SCHM_CODE!='SB190'
AND c_sup.INVALID in ('S','N')
and c_sup.UPL_STATUS='P'
and c_sup.EMPLOYER='&v_employer'
and c_sup.RCRE_USER_ID='&v_userid'
and c_sup.del_flg ='N'
and SAL_CR_AMT > 100
and c_sup.bank_id = gam.bank_id
and GAM.bank_id = '&v_bank_id'
/
spool off;
select '&v_userid'||'&v_bank_id'||'&v_charge_amt' from dual
/
spool off;

select '&v_employer'||'_CURRERR.lst' fn from dual
/
spool &v_filename
select c_sup.EMPLOYER||','||c_sup.ACCT_CRNCY_CODE||','||c_sup.SOL_ID||','||c_sup.UPL_ACCT_NO||','||c_sup.SAL_CR_AMT||','||c_sup.INVALID||','||c_sup.TRAN_PARTICULAR||','||
c_sup.UPL_ACCT_NAME||','||GAM_ACCT||','||c_sup.EMPLOYEE_ID||','||C_SUP.RMK from CUSTOM.c_sup
where c_sup.EMPLOYER = '&v_employer'
and c_sup.RCRE_USER_ID ='&v_userid'
AND c_sup.INVALID = 'C'
and bank_id = '&v_bank_id'
/
spool off;


spool updateerr.lst
select user from dual
/
update CUSTOM.c_sup
set del_flg='Y'
where EMPLOYER='&v_employer'
and RCRE_USER_ID='&v_userid'
and del_flg ='N'
and bank_id = '&v_bank_id'
/
commit
/
insert into CUSTOM.c_supsc select * 
from CUSTOM.C_SUP where EMPLOYER='&v_employer'
and RCRE_USER_ID='&v_userid'
and del_flg ='Y'
and bank_id = '&v_bank_id'
and UPL_DATE =(select db_stat_date from gct WHERE bank_id = '&v_bank_id')
/
commit
/
spool off;
exit
