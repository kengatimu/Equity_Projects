OPTIONS (SKIP=1)
LOAD DATA
append
into table custom.ofac_sdn_tbl 
fields terminated by ',' optionally enclosed by '"'
TRAILING NULLCOLS
(
ent_num,
sdn_name,
sdn_type,
program_type,
title,
call_sign,
vessel_type,
vessel_tonnage,
grt,
vessel_flg,
vessel_owner,
remarks_sdn char(200000),
upl_batch_id "'uplbaid'",
entity_cre_flg constant 'Y',
del_flg constant 'N',
rcre_time sysdate,
rcre_user_id "'upluser'",
lchg_user_id "'upluser'",
lchg_time sysdate,
bank_id "'uplbankid'")
