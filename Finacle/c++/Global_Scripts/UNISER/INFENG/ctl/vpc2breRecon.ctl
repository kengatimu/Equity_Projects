OPTIONS (SKIP=1)
LOAD DATA
append
into table custom.cust_mpesa_recon_tbl 
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(
receipt_no,
completion_time,
initiation_time,
details,
transaction_status,
paid_in,
withdrawn,
balance,
balance_confirmed,
reson_type,
other_party_info,
linked_transaction_id,
acct_num,
gl,
posted constant 'N',
manual_posted constant 'N',
del_flg constant 'N',
cre_user constant 'D',
mod_user constant 'D',
processed constant 'N',
file_name "'uplfilname'",
upld_date sysdate,
upl_batch_id "'uplbaid'",
bank_id "'uplbankid'",
rcre_user_id constant 'CDCI54',
rcre_time sysdate,
lchg_user_id constant 'CDCI54',
lchg_time sysdate)
