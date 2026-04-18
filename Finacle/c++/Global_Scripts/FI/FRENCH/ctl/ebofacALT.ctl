OPTIONS (SKIP=1)
LOAD DATA
append
into table custom.ofac_alt_tbl 
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(
ent_num,
alt_num,
alt_type,
alt_name,
alt_remarks,
upl_batch_id "'uplbaid'",
entity_cre_flg constant 'Y',
del_flg constant 'N',
rcre_time sysdate,
rcre_user_id "'upluser'",
lchg_user_id "'upluser'",
lchg_time sysdate,
bank_id "'uplbankid'")
