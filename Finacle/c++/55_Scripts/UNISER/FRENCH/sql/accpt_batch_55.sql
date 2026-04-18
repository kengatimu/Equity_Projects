/

set head on
set verify on
set feed on
set pages 0
set lines 10000
set trims on
set serveroutput on
set termout on
spool ACPART_INSERT
DECLARE
        bankid           tbaadm.acpart.bank_id%type :='55';
       --v_acct_id          tbaadm.gam.foracid%type :='';
        v_sol_id         tbaadm.gam.sol_id%type;
        v_acct_crncy_code  tbaadm.gam.acct_crncy_code%type;
        v_sol_id_C       tbaadm.gam.sol_id%type;
        v_acct_crncy_code_C tbaadm.gam.acct_crncy_code%type;
        db_date          date;

        Cursor c1 is
        select sum(decode(part_tran_type,'C' ,tran_amt,'D',-tran_amt)) t_amt,partitioned_acid,cust_id,b2k_id,bank_id
        from tbaadm.acpart where B2K_TYPE='ACCNT' and pstd_flg='Y' and bank_id=55 and (b2k_id, bank_id) in (
        select acid, bank_id from tbaadm.gam where 
    --foracid=v_acct_id
    schm_type='LAA' and clr_bal_amt=0 and bank_id='55') /* Changes for Setting as batch job. */
        group by partitioned_acid,cust_id,b2k_id,bank_id
        having sum(decode(part_tran_type,'C' ,tran_amt,'D',-tran_amt)) >0;

        Cursor c2 is
        select sum(decode(part_tran_type,'C' ,tran_amt,'D',-tran_amt)) t_amt,partitioned_acid,cust_id,b2k_id,bank_id
        from tbaadm.acpart where B2K_TYPE='ACCNT' and pstd_flg='Y' and bank_id=55 and (b2k_id, bank_id) in (
        select acid, bank_id from tbaadm.gam where 
    --foracid=v_acct_id
    schm_type='LAA' and clr_bal_amt=0  and bank_id='55') /* Changes for Setting as batch job. */
        group by partitioned_acid,cust_id,b2k_id,bank_id
        having sum(decode(part_tran_type,'C' ,tran_amt,'D',-tran_amt)) <0;

rec1 c1%rowtype;
rec1 c2%rowtype;

BEGIN
        for rec1 in c1
        loop
                begin
                select sol_id,acct_crncy_code into v_sol_id,v_acct_crncy_code from tbaadm.gam where acid=rec1.b2k_id and
                bank_id=rec1.bank_id;
                exception when no_data_found then
                v_sol_id :=null;
                v_acct_crncy_code :=null;
                end;

insert into tbaadm.acpart values('15-nov-2013',custom.MIGR_ACPART_54.nextval,'1','Y',rec1.partitioned_acid,rec1.cust_id,'ACCNT',rec1.b2k_id,abs(rec1.t_amt
),v_sol_id,v_acct_crncy_code,'D','',rec1.bank_ID);
                commit;
                end loop;

                for rec2 in c2
                loop
begin
select sol_id,acct_crncy_code into v_sol_id_C,v_acct_crncy_code_C from tbaadm.gam where acid=rec2.b2k_id and
bank_id=rec2.bank_id;
exception when no_data_found then
v_sol_id_C :=null;
v_acct_crncy_code_C :=null;
end;

insert into tbaadm.acpart values('15-nov-2013',custom.MIGR_ACPART_54.nextval,'2','Y',rec2.partitioned_acid,rec2.cust_id,'ACCNT',rec2.b2k_id,abs(rec2.t_amt
),v_sol_id_C,v_acct_crncy_code_C,'C','',rec2.bank_id);
                commit;
end loop;
end;

/

commit;
/
exit
/
