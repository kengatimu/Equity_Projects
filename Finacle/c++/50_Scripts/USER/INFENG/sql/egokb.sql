set verify off
set feedback off
set termout off
set pages 0
set lines 500
set trims on
set serveroutput on size 1000000
set termout on
spool &3
select '186'||to_char(SETTLEMENT_DATE+1,'ddmmyyyy')||'858500001234567800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000' 
from tbaadm.pstd where SETTLEMENT_DATE=to_date('&1','dd-mm-yyyy')
and pstd.bank_id = '&2'
and rownum<2

/
select lpad(TRAN_CODE,4,'0')||'40'||lpad((TRAN_AMT*100),13,'0')||'085'||substr(TBAADM.otc.sol_id,2,3)||lpad(nvl(free_text5,' '),15,'0')
||substr(DEST_BANK_CODE,1,2)||substr(DEST_BRANCH_CODE,0,3)||lpad(NVL(DEST_CUST_ACCT,' '),18,' ')||'85'||substr(otc.sol_id,2,3)||'000000000000'||
rpad(nvl(substr(DEST_CUST_NAME,1,35),' '),35,' ')||rpad(nvl(free_text1,' '),20,' ')||rpad(substr(GAM.ACCT_NAME,0,15),15,' ')||'00000000'
from tbaadm.otc,tbaadm.gam
where gam.foracid=otc.free_text5
and gam.bank_id = otc.bank_id
and gam.bank_id = '&2'
--and otc.tran_code in ('58','59')
and otc.FREE_TEXT6 is null
and otc.ENTITY_CRE_FLG ='Y'
AND SETTLEMENT_DATE=to_date('&1','dd-mm-yyyy')
union all
select lpad(emd.TRANSACTION_CODE,4,'0')||'40'||lpad((pstd.AMOUNT*100),13,'0')||substr(pstd.SPONSOR_BK_MICR,4,2)||lpad(gam.foracid,15,'0')
||lpad(trim(substr(nvl(pstd.DESTN_MICR_CD,' '),5)),5,' ')||lpad(pstd.DESTN_ACC_NO,18,' ')||substr(pstd.SPONSOR_BK_MICR,5,2)||'000000000000'||
rpad(substr(pstd.DESTN_ACCOUNT_HLDR_NAME,1,35),35,' ')||rpad(nvl(trim(pstd.FREE_TEXT_1),' '),15,' ')
||rpad(substr(GAM.ACCT_NAME,0,20),20,' ')||'00000000' l
from tbaadm.pyrh,tbaadm.pyrd,tbaadm.pstd,tbaadm.gam,tbaadm.emd 
where pyrh.PR_SRL_NUM=pyrd.PR_SRL_NUM
and pstd.USER_REFERENCE_NUM=pyrh.PR_B2K_ID
and gam.acid=pyrd.acid
and emd.B2K_ID=pstd.USER_REFERENCE_NUM
and gam.bank_id = pyrh.bank_id
and gam.bank_id = pyrd.bank_id
and gam.bank_id = pstd.bank_id
and gam.bank_id = emd.bank_id
and gam.bank_id = '&2'
and PART_TRAN_TYPE='D'
and SETTLEMENT_DATE=to_date('&1','dd-mm-yyyy')
/
spool off
/
update tbaadm.otc  set FREE_TEXT6='1'  where FREE_TEXT6 is null and BANK_ID = '&2' AND SETTLEMENT_DATE=to_date('&1','dd-mm-yyyy');
/
commit;
/
exit
/