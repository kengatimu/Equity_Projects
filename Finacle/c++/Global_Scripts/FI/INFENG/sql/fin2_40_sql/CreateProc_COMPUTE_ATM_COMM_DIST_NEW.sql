DROP PROCEDURE CUSTOM.COMPUTE_ATM_COMM_DIST_NEW;

CREATE OR REPLACE PROCEDURE CUSTOM.compute_atm_comm_dist_new (v_tran_date date)
as
   --(v_from_date date, v_to_date date) as

   --get all branch comm accounts
   --cursor cur is select acid from gam
   --where foracid='0006500103419'
   --bacid='SUNDRYTD'
   --and acid='0010661'
   --and  del_flg !='Y';
   --order by sol_id;


   ---all GLS now
   cursor cur
   is
        select acid
          from tbaadm.gam
         where bacid = 'PNLSAATM' and del_flg != 'Y' and bank_id='54'
      --and acid in ('0211330','031629203','041158121')
      order by sol_id;

   --- commisions tran
   cursor cur1 (
      v_in_acid    varchar2,
      v_date       date)
   is
      select tran_date,
             tran_id,
             decode (part_tran_type, 'C', 1, -1) amtsign,
             gam.acid,
             tran_amt * decode (part_tran_type, 'C', 1, -1) tran_amt,
             gam.sol_id,
             gam.foracid brnch_comm_account
        from tbaadm.htd htd, tbaadm.gam gam
       where     gam.acid = v_in_acid
             and gam.acid = htd.acid
             and substr(TRAN_PARTICULAR,0,14)!='ATM With Share'
             and gam.bank_id=htd.bank_id
             and gam.bank_id='54'
             and tran_date = v_date;

   --and tran_date <= '30-apr-2012'
   --and tran_date >= v_from_date ---'01-apr-2012'
   --and tran_date <= v_to_date --'30-apr-2012'
   --and htd.gl_sub_head_code in ('65001');

   --where tran_id='S77792816'
   --and tran_date='1-feb-2012'
   --and gl_sub_head_code in ('65001');

   v_atm_sol_id           varchar2 (5);
   v_atm_id               varchar2 (15);
   v_errm                 varchar2 (200);
   v_cust_sol_comm        number := 0;
   v_cust_sol_id          varchar2 (5);
   v_atm_sol_comm         number := 0;
   v_atm_sol_comm_acct    varchar2 (15);
   v_home_sol_comm_acct   varchar2 (15);
begin
   delete custom.atm_comm_distribution
    where bod_date = v_tran_date;

   delete custom.atm_comm_distribution_err
    where bod_date = v_tran_date;

   commit;

   --select max(tran_date) into v_tran_date  from htd;

   dbms_output.put_line (
      'brnch_comm_account |tran_id    |  TRan Date  |  tran amt  |  atm sol |  cust sol | atm comm | cust sol comm| v_atm_sol_comm_acct  | ATM');
   dbms_output.put_line (
      '=======================================================================================');

   for j in cur
   loop
      for i in cur1 (j.acid, v_tran_date)
      loop
         v_cust_sol_comm := 0;
         v_atm_sol_comm := 0;
         v_atm_sol_id := null;
         v_atm_id := null;

         begin
            ---atm
            select sol_id, acct_short_name
              into v_atm_sol_id, v_atm_id
              from tbaadm.gam gam
             where exists
                      (select 1
                         from tbaadm.htd htd
                        where     tran_id = i.tran_id
                              and tran_date = i.tran_date
                              and substr(TRAN_PARTICULAR,0,14)!='ATM With Share'
                              and gl_sub_head_code in ('10001')
                              and htd.bank_id='54'
                              and gam.acid = htd.acid and gam.bank_id=htd.bank_id) and gam.bank_id='54';

            v_atm_sol_comm_acct := null;

            select foracid
              into v_atm_sol_comm_acct
              from tbaadm.gam gam
             where bacid = 'PNLSAATM' and  gam.bank_id='54' and sol_id = v_atm_sol_id;
         exception
            when others
            then
               v_errm := substr (sqlerrm (sqlcode), 1, 150);
               v_errm :=
                  (   'tran='
                   || i.tran_id
                   || ' tran_date='
                   || to_char (i.tran_date, 'dd-mon-yyyy')
                   || ' unable to get atm error='
                   || v_errm);


               insert into custom.atm_comm_distribution_err (bod_date,
                                                      tran_id,
                                                      tran_date,
                                                      err)
                    values (v_tran_date,
                            i.tran_id,
                            i.tran_date,
                            v_errm);
         end;

         begin
            v_cust_sol_id := null;

            select sol_id
              into v_cust_sol_id
              from (select htd.sol_id
                      from tbaadm.htd htd , tbaadm.gam gam
                     where     htd.acid = gam.acid
                           and gam.schm_type in ('SBA', 'CAA')
                           and gam.bank_id=htd.bank_id
                           and substr(TRAN_PARTICULAR,0,14)!='ATM With Share'
                           and htd.bank_id='54'
                           and tran_id = i.tran_id
                           and tran_date = i.tran_date)
             where rownum < 2;

            v_home_sol_comm_acct := null;

            select foracid
              into v_home_sol_comm_acct
              from tbaadm.gam gam
             where bacid = 'PNLSAATM' and bank_id ='54' and sol_id = v_cust_sol_id;
         exception
            when others
            then
               v_errm := substr (sqlerrm (sqlcode), 1, 150);
               v_errm :=
                  (   'tran='
                   || i.tran_id
                   || ' tran_date='
                   || to_char (i.tran_date, 'dd-mon-yyyy')
                   || ' unable to get cust sol is error='
                   || v_errm);

               insert into custom.atm_comm_distribution_err (bod_date,
                                                      tran_id,
                                                      tran_date,
                                                      err)
                    values (v_tran_date,
                            i.tran_id,
                            i.tran_date,
                            v_errm);
         end;

         if (v_atm_sol_id = v_cust_sol_id) or (v_atm_sol_id is null)
         then
            v_cust_sol_comm := i.tran_amt;
            v_atm_sol_comm := 0;
         elsif v_cust_sol_id is null
         then
            v_cust_sol_comm := 0;
            v_atm_sol_comm := i.tran_amt;
         else
            v_cust_sol_comm := round (i.tran_amt * 0.4);
            v_atm_sol_comm := round (i.tran_amt * 0.6);
         end if;

         /*
         if (i.sol_id=v_atm_sol_id) OR (v_atm_sol_id is null) then
             v_cust_sol_comm :=i.tran_amt;
             v_atm_sol_comm:=0;
         else
             v_cust_sol_comm :=round(i.tran_amt*0.4);
             v_atm_sol_comm :=round(i.tran_amt*0.6);
         end if;
         */
         --  dbms_output.put_line(i.brnch_comm_account||'  |  '||i.tran_id||'    |  '||i.TRan_Date||'  |  '||i.tran_amt||'  |  '||v_atm_sol_id||' |  '|| i.sol_id||' | '||v_atm_sol_comm||' | '||v_cust_sol_comm||'   | '||v_atm_sol_comm_acct||' | '||v_atm_id);
         --insert rec
         insert into custom.atm_comm_distribution (bod_date,
                                            main_sol_comm_acnt,
                                            tran_id,
                                            tran_date,
                                            tran_amt,
                                            atm_sol_id,
                                            cust_sol_id,
                                            atm_sol_comm,
                                            cust_sol_comm,
                                            atm_sol_comm_acct,
                                            atm_id,
                                            cust_sol_comm_acct)
              values (v_tran_date,
                      i.brnch_comm_account,
                      i.tran_id,
                      i.tran_date,
                      i.tran_amt,
                      v_atm_sol_id,
                      v_cust_sol_id,
                      v_atm_sol_comm,
                      v_cust_sol_comm,
                      v_atm_sol_comm_acct,
                      v_atm_id,
                      v_home_sol_comm_acct);

         commit;
      end loop;
   end loop;
end;
/

GRANT EXECUTE ON CUSTOM.COMPUTE_ATM_COMM_DIST_NEW TO ALLTAB;

GRANT EXECUTE ON CUSTOM.COMPUTE_ATM_COMM_DIST_NEW TO TBAADM;
 
GRANT EXECUTE ON CUSTOM.COMPUTE_ATM_COMM_DIST_NEW TO TBAGEN;

GRANT EXECUTE ON CUSTOM.COMPUTE_ATM_COMM_DIST_NEW TO TBAUTIL;
