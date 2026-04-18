LOAD DATA
INFILE 'SALARY.TXT'
APPEND
INTO TABLE CUSTOM.C_SUP
FIELDS TERMINATED BY "|"
(
employer,
employee_id,
upl_acct_no,
acct_crncy_code,
upl_acct_name,
sal_cr_amt,
tran_particular,
sol_id,
foracid,
upl_key,
upl_date,
upl_status,
lchg_user_id,
lchg_time,
rcre_user_id,
rcre_time,
chrg_flg,
del_flg,
bank_id
)
