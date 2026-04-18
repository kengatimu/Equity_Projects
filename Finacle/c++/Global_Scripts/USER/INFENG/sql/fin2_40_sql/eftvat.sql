set verify off
set feedback off
set termout off
set pages 0
set lines 500
set trims on
set serveroutput on size 1000000
set termout on
spool &3
select '186'||to_char(SETTLEMENT_DATE+1,'ddmmyyyy')||'686800001234567800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000' from
TBAADM.pstd where SETTLEMENT_DATE=to_date('&1','dd-mm-yyyy')
AND bank_id = '&2'
and rownum<2
/
SELECT lpad(otc.tran_code,4,'0')||lpad((TRAN_AMT*100),13,'0')||''||'068'||''||OTC.SOL_ID||''||lpad(nvl(free_text5,' '),15,'0')
||''||DEST_BANK_CODE||''||DEST_BRANCH_CODE||''||lpad(NVL(DEST_CUST_ACCT,' '),15,'0')
||''||'68'||''||OTC.SOL_ID||'000000000000000'||''||RPAD(NVL(free_text1,' '),35,' ')||''||RPAD(NVL(free_text2,' '),11,' ')
||''||RPAD(NVL(free_text3,' '),6,' ')||''||TO_CHAR(SYSDATE,'ddmmyyyy')||''||'01'||''||RPAD(NVL(free_text4,'0'),6,'0')||''||'000200000000'
FROM tbaadm.GAM,tbaadm.OTC 
WHERE gam.FORACID=otc.FREE_TEXT5
AND gam.bank_id = otc.bank_id
AND gam.bank_id = '&2'
AND tran_date=to_date('&1','dd-mm-yyyy')
and tran_code in ('42','39')
/
spool off

