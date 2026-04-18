OPTIONS (SKIP=1)
LOAD DATA
append
into table custom.cust_merchant_po_tbl 
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(
dr_acct_id,
cr_acct_id,
remit_amt,
our_branch_code,
remit_crncy,
benef_branch_code,
benef_bic_code,
flg_yn,
benef_bank_code,
narration,
benef_name,
country_desc,
country_code,
benef_acct_id,
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
tran_type constant 'PO') 
