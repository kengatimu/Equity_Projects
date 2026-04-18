OPTIONS (SKIP=1)
LOAD DATA
append
into table custom.ofac_add_tbl 
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(
ent_num,
add_num,
address,
city_state_prov_postal_code,
country,
address_remarks,
upl_batch_id "'uplbaid'",
entity_cre_flg constant 'Y',
del_flg constant 'N',
rcre_time sysdate,
rcre_user_id "'upluser'",
lchg_user_id "'upluser'",
lchg_time sysdate,
bank_id "'uplbankid'")
