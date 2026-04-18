OPTIONS (SKIP=0)
LOAD DATA
append
into table custom.cust_agentcomm_master_tbl 
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(
acct_number, 
part_tran_type,
tran_amt,
tran_crncy,
tran_particular,
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
machine_name "'machineid'",
module_code "'modulecode'") 
