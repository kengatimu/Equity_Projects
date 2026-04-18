OPTIONS (SKIP=1)
LOAD DATA
append
into table custom.cust_merchant_eft_tbl 
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(
srl_num,
dr_acct_id,
beneficiary_acct_num,
beneficiary_name,
beneficiary_bank_br_code,
payment_amt,
purpose_code_remarks,
payment_type,
tran_crncy,
tran_code,
additional_ref,
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
tran_type constant 'EFT') 
