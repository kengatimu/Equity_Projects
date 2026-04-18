OPTIONS (SKIP=1)
LOAD DATA
append
into table custom.cust_merchant_tran_tbl 
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(
acct_number, 
acct_crncy_code,
init_sol_id,
part_tran_type,
tran_amt,
tran_particular,
ref_amt,
ref_crncy_code,
upl_rate_code,
process_status constant 'U',
process_desc constant 'Uploaded Successfully',
rcre_user_id "'upluser'", 
rcre_time sysdate, 
lchg_user_id "'upluser'", 
lchg_time sysdate, 
entity_cre_flg constant 'Y', 
del_flg constant 'N', 
bank_id "'uplbankid'",
file_name "'uplfilname'", 
upld_date sysdate,
upl_batch_id "'uplbaid'", 
tran_type constant 'T') 
