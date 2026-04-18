DROP PROCEDURE CUSTOM.INSERT_INTO_OVERDRAWN;

CREATE OR REPLACE PROCEDURE CUSTOM.INSERT_INTO_OVERDRAWN(vBankId VARCHAR2)  IS
vAcctDate date;

cursor  cur1 is
select sol_id,schm_type ,SCHM_CODE,acct_crncy_code, sum(clr_bal_amt) bal
 from tbaadm.gam where   schm_type in ('CAA','SBA','TDA','FBA' ) and clr_bal_amt<0 and gam.BANK_ID = vBankId
        --AND a.SOL_ID='105'
        group by sol_id,schm_type ,SCHM_CODE,acct_crncy_code
        union
select sol_id,schm_type ,SCHM_CODE,acct_crncy_code, sum(clr_bal_amt) bal
        from tbaadm.gam 
        where   schm_type ='LAA'  and clr_bal_amt>0 and gam.BANK_ID = vBankId
        --AND a.SOL_ID='105'
        group by sol_id,schm_type ,SCHM_CODE,acct_crncy_code;

BEGIN
select  db_stat_date 
into    vAcctDate
from    tbaadm.gct where BANK_ID = vBankId;

--vAcctDate :='01-FEB-2010';
COMMIT;
for i in cur1 loop
INSERT  INTO  CUSTOM.OVERDRAWN_ACCT
        (TRAN_DATE,SOL_ID, SCHM_TYPE, SCHM_CODE, ACCT_CRNCY_CODE, TRAN_AMT)
        values(vAcctDate,i.sol_id,i.schm_type ,i.SCHM_CODE,i.acct_crncy_code,i.bal );

 COMMIT;
 END LOOP;
 
END INSERT_INTO_OVERDRAWN;
/


GRANT EXECUTE ON CUSTOM.INSERT_INTO_OVERDRAWN TO CEOD_USERS;
