DROP PROCEDURE CUSTOM.COMPUTE_ATM_COMM_DIST_SUM;

CREATE OR REPLACE PROCEDURE CUSTOM.compute_atm_comm_dist_sum (v_tran_date date) as

  v_seq      number :=0;
   v_date   date := v_tran_date;

begin
   select max (sequence_no) into v_seq from custom.atm_share_totpost;

   for i
      in (  select substr(main_sol_comm_acnt,0,3) main_sol,
                   main_sol_comm_acnt,
                   atm_sol_id,
                   atm_sol_comm_acct,
                   cust_sol_id,
                   cust_sol_comm_acct,
                   sum (tran_amt) total,
                   sum (atm_sol_comm) atm_sol_comm,
                   sum (cust_sol_comm) cust_sol_comm,
                   tran_date
              from custom.atm_comm_distribution
             where tran_date = v_date
                       group by main_sol_comm_acnt,
                   atm_sol_comm_acct,
                   cust_sol_comm_acct,
                   atm_sol_id,
                   cust_sol_id,
                   tran_date)
   loop
      v_seq := v_seq + 1;

      insert into custom.atm_share_totpost (main_sol,
                                          main_sol_comm_acnt,
                                          atm_sol_id,
                                          atm_sol_comm_acct,
                                          cust_sol_id,
                                          cust_sol_comm_acct,
                                          total,
                                          atm_sol_comm,
                                          cust_sol_comm,
                                          process_flag,
                                          sequence_no,
                                          process_date,
                                          BANK_ID)
           values (i.main_sol,
                   i.main_sol_comm_acnt,
                   i.atm_sol_id,
                   i.atm_sol_comm_acct,
                   i.cust_sol_id,
                   i.cust_sol_comm_acct,
                   i.total,
                   i.atm_sol_comm,
                   i.cust_sol_comm,
                   'N',
                   v_seq,
                   v_date,
                   '54');
   end loop;

   commit;
end;
/

GRANT EXECUTE ON CUSTOM.COMPUTE_ATM_COMM_DIST_SUM TO TBAADM;

GRANT EXECUTE ON CUSTOM.COMPUTE_ATM_COMM_DIST_SUM TO TBAGEN;

GRANT EXECUTE ON CUSTOM.COMPUTE_ATM_COMM_DIST_SUM TO TBAUTIL;
