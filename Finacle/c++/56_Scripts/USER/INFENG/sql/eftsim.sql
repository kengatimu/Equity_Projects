set verify off
set feedback off
set termout off
set pages 0
set lines 500
set trims on
set serveroutput on size 1000000
set termout on
spool &3
Select lpad(emd.TRANSACTION_CODE,4,'0')||lpad(htd.TRAN_AMT*10,13,'0')||'0'||'30'||substr(htd.sol_id,2,2)||'47'||lpad(gam.foracid,15,'0')
||emd.OTHER_BANK_CODE||emd.OTHER_BRANCH_CODE||'47'||lpad(emd.OTHER_PARTY_ACCT,15,'0')||'30'||htd.SOL_ID||'0000000000000'||rpad(substr(emd.OTHER_PARTY_NAME,1,35),35,' ')||rpad(nvl(trim(emd.REFERENCE_ID_1),' '),15,' ')||
rpad(substr(GAM.ACCT_NAME,0,20),20,' ')||'000000000'
from tbaadm.htd,tbaadm.emd,tbaadm.pyrd,tbaadm.pyrh,tbaadm.gam
where htd.TRAN_PARTICULAR=emd.B2K_ID
and emd.B2K_ID=pyrh.PR_B2K_ID
and pyrh.PR_SRL_NUM=pyrd.PR_SRL_NUM
and pyrd.acid=gam.acid
and gam.bank_id = htd.bank_id
and gam.bank_id = emd.bank_id
and gam.bank_id = pyrd.bank_id
and gam.bank_id = pyrh.bank_id
and pyrh.PART_TRAN_TYPE='D'
and htd.part_tran_type='C'
and htd.TRAN_TYPE='T'
and htd.TRAN_SUB_TYPE='SI'
and htd.del_flg!='Y'
and htd.TRAN_DATE>=to_date('&4','dd-mm-yyyy')
and gam.bank_id = '&2'
/
spool off

