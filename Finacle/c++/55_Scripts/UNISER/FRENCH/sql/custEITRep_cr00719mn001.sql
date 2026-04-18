/* Formatted on 2013/01/23 15:45 (Formatter Plus v4.8.8) */
-------------------------------------------------------------------------------------------------------
--  Name                        : custEITRep_cr00719mn001.sql
--  Date                        : 21-10-2012
--  Description                 : Sql inserting data into C_EIT
--  Author                      : Parikshith V
--  Modification History        :
-- <Serial No.>    <Date>       <Author Name>       <Description>
--     2.0       21-10-2012      Parikshith V     Initial draft
-------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE CUSTOM.c_eit_fetch_pack
AS
   PROCEDURE c_eit_fetch_proc (
      inp_str       IN       VARCHAR2,
      out_retcode   OUT      NUMBER,
      out_rec       OUT      VARCHAR2
   );

END c_eit_fetch_pack;
/

CREATE OR REPLACE PACKAGE BODY CUSTOM.c_eit_fetch_pack
AS
--{
   outarr   tbaadm.basp0099.arraytype;

   -------------------------------------------------------------

   -- Cursor to fetch account id from c_eit_backup table

   -------------------------------------------------------------
   CURSOR entity_id_fetch_cur (
      cin_bank_id    c_eit_backup.bank_id%TYPE,
      cin_sba_date   DATE,
      cin_oda_date   DATE,
      cin_caa_date   DATE,
      cin_laa_date   DATE,
      cin_tda_date   DATE,
      cin_tua_date   DATE,
      cin_cla_date   DATE,
      cin_sol_id     VARCHAR2
   )
   IS
      SELECT c.entity_id, g.acct_ownership, c.eit_date, g.bacid, g.foracid,
      g.acct_crncy_code, g.sol_id, g.schm_type, g.schm_code,
      g.un_clr_bal_amt, g.future_bal_amt, g.lien_amt,
      g.gl_sub_head_code
      FROM c_eit_backup c, tbaadm.gam g
      WHERE c.bank_id = cin_bank_id
      AND c.entity_type = 'ACCNT'
      AND (   (c.eit_date = cin_sba_date AND schm_type = 'SBA')
              OR (c.eit_date = cin_oda_date AND schm_type = 'ODA')
              OR (c.eit_date = cin_caa_date AND schm_type = 'CAA')
              OR (c.eit_date = cin_laa_date AND schm_type = 'LAA')
              OR (c.eit_date = cin_cla_date AND schm_type = 'CLA')
              OR (c.eit_date = cin_tda_date AND schm_type = 'TDA')
              OR (c.eit_date = cin_tua_date AND schm_type = 'TUA')
             )
      AND (   (   (c.booked_upto_date_cr = c.eit_date)
                  OR (c.booked_upto_date_dr = c.eit_date)
                  )
              OR  ( (c.last_int_cr_tran_date = c.eit_date)
                  OR (c.last_int_dr_tran_date = c.eit_date)
                  )

               OR   (   (c.booked_upto_date_cr = c.eit_date - 1)
             OR (c.booked_upto_date_dr = c.eit_date - 1 )
              )
        OR  ( (c.last_int_cr_tran_date = c.eit_date - 1)
              OR (c.last_int_dr_tran_date = c.eit_date - 1)
                  )

                  OR   ( (c.booked_upto_date_cr is null)
                       OR (c.booked_upto_date_dr is null)
              )

          )
      AND c.entity_id = g.acid
      AND c.bank_id = g.bank_id
      AND g.sol_id  = cin_sol_id
      AND g.entity_cre_flg = 'Y'
      AND g.del_flg != 'Y';


   -------------------------------------------------------------

   -- Procedure begin

   -------------------------------------------------------------
   PROCEDURE c_eit_fetch_proc (
      inp_str       IN       VARCHAR2,
      out_retcode   OUT      NUMBER,
      out_rec       OUT      VARCHAR2
   )
   AS
      lv_boddate                   DATE;
      lv_bankid                    VARCHAR2 (2);
      lv_flg_dr                    CHAR (1);
      lv_flg_cr                    CHAR (1);
      lv_acid                      c_eit_backup.entity_id%TYPE;
      lv_crdrflg                   CHAR (1)                            := 'N';
      lv_bkdappl_flg               CHAR (1);
      lv_accr_amt_today_cr         NUMBER (22, 6);
      lv_bkd_amt_today_cr          NUMBER (22, 6);
      lv_appl_amt_today_cr         NUMBER (22, 6);
      lv_accr_amt_today_dr         NUMBER (22, 6);
      lv_bkd_amt_today_dr          NUMBER (22, 6);
      lv_appl_amt_today_dr         NUMBER (22, 6);
      lv_accruptodt                DATE;
      lv_bkduptodt                 DATE;
      lv_bkdtranid                 c_eit_backup.last_book_dr_tran_id%TYPE;
      lv_appltranid                c_eit_backup.last_int_dr_tran_id%TYPE;
      lv_appltrandt                DATE;
      lv_intrate                   c_eit_backup.interest_rate%TYPE;
      lv_accr_upto_amt_dr          NUMBER (22, 6);
      lv_bkd_upto_amt_dr           NUMBER (22, 6);
      lv_appl_upto_amt_dr          NUMBER (22, 6);
      lv_accr_upto_amt_cr          NUMBER (22, 6);
      lv_bkd_upto_amt_cr           NUMBER (22, 6);
      lv_appl_upto_amt_cr          NUMBER (22, 6);
      lv_eabdate                   DATE;
      lv_bacid                     tbaadm.gam.bacid%TYPE;
      lv_foracid                   tbaadm.gam.foracid%TYPE;
      lv_glacc                     tbaadm.gam.foracid%TYPE;
      lv_solid                     tbaadm.gam.sol_id%TYPE;
      lv_schm_type                 tbaadm.gam.schm_type%TYPE;
      lv_schm_code                 tbaadm.gam.schm_code%TYPE;
      lv_unclrbalamt               tbaadm.gam.un_clr_bal_amt%TYPE;
      lv_futbalamt                 tbaadm.gam.future_bal_amt%TYPE;
      lv_lienamt                   tbaadm.gam.lien_amt%TYPE;
      lv_glsub                     tbaadm.gam.gl_sub_head_code%TYPE;
      lv_intcollflg                tbaadm.gam.int_coll_flg%TYPE;
      lv_intpdflg                  tbaadm.gam.int_paid_flg%TYPE;
      lv_eodbal                    tbaadm.eab.tran_date_bal%TYPE;
      lv_freecode7                 tbaadm.gac.free_code_7%TYPE;
      lv_segment                   crmuser.accounts.segmentation_class%TYPE;
      lv_subsegment                crmuser.accounts.subsegment%TYPE;
      lv_ptransrlnum               tbaadm.dctd_acli.part_tran_srl_num%TYPE;
      lv_tranpart                  tbaadm.dctd_acli.tran_particular%TYPE;
      lv_tranpart2                 tbaadm.dctd_acli.tran_particular_2%TYPE;
      lv_tranrmks                  tbaadm.dctd_acli.tran_rmks%TYPE;
      lv_ptrantype                 tbaadm.dctd_acli.part_tran_type%TYPE;
      lv_lchguserid                c_eit_backup.lchg_user_id%TYPE;
      lv_lchgtime                  c_eit_backup.lchg_time%TYPE;
      lv_rcreuserid                c_eit_backup.rcre_user_id%TYPE;
      lv_rcretime                  c_eit_backup.rcre_time%TYPE;
      lv_tranamt                   tbaadm.dctd_acli.tran_amt%TYPE;
      lv_trancrncy                 tbaadm.dctd_acli.crncy_code%TYPE;
      lv_acctown                   tbaadm.gam.acct_ownership%TYPE;
      lv_glacid                    tbaadm.gam.acid%TYPE;
      lv_prevdate                  DATE;
      lv_eitdate                   DATE;
      lv_tempacid                  tbaadm.gam.acid%TYPE;
      lv_penbacid                  tbaadm.gam.bacid%TYPE;
      lv_penforacid                tbaadm.gam.foracid%TYPE;
      lv_sba_date                  DATE;
      lv_oda_date                  DATE;
      lv_caa_date                  DATE;
      lv_laa_date                  DATE;
      lv_tda_date                  DATE;
      lv_tua_date                  DATE;
      lv_cla_date                  DATE;
      lv_trancount                 NUMBER;
      lv_acctcrncy                 tbaadm.gam.acct_crncy_code%TYPE;
      lv_count                     NUMBER                                := 0;
      lv_count2                    NUMBER                 :=0;
      lv_errmsg                    VARCHAR2 (300);
      lv_accr_penal_amt_today_dr   NUMBER (22, 6);
      lv_bkd_penal_amt_today_dr    NUMBER (22, 6);
      lv_appl_penal_amt_today_dr   NUMBER (22, 6);
      lv_accr_penal_upto_dr        NUMBER (22, 6);
      lv_bkd_penal_upto_dr         NUMBER (22, 6);
      lv_appl_penal_upto_dr        NUMBER (22, 6);
      --Added by Maniraj for calculating the difference between the over due amounts
      lv_accramtdr_ovdu            NUMBER (22, 6);
      lv_bkdamtdr_ovdu             NUMBER (22, 6);
      lv_applamtdr_ovdu            NUMBER (22, 6);
      lv_accramtdr_ovdu_ret        NUMBER (22, 6):=0;
      lv_bkdamtdr_ovdu_ret         NUMBER (22, 6):=0;
      lv_applamtdr_ovdu_ret        NUMBER (22, 6):=0;
      --Added for OD scenarios where both int_paid_flg and int_coll_flg are Y
      lv_bkdtraniddr               c_eit_backup.last_book_dr_tran_id%TYPE;
      lv_bkdtranidcr               c_eit_backup.last_book_cr_tran_id%TYPE;
      lv_appltraniddr              c_eit_backup.last_int_dr_tran_id%TYPE;
      lv_appltranidcr              c_eit_backup.last_int_cr_tran_id%TYPE;
      lv_bkduptodtdr               DATE;
      lv_bkduptodtcr               DATE;
      lv_appltrandtdr              DATE;
      lv_appltrandtcr              DATE;
      lv_accruptodtdr              DATE;
      lv_accruptodtcr              DATE;
      --Added for Bonus interest booking
      lv_bonusBooking              CHAR(1);
      lv_bonusApp                  CHAR(1);
      lv_rcretime1                 DATE;
      lv_rcretime2                 DATE;
      lv_inp_solid                 tbaadm.gam.sol_id%TYPE;
      lv_tran_date_dctd            tbaadm.dctd_acli.tran_date%TYPE;
      lv_tranid_dctd               tbaadm.dctd_acli.tran_id%TYPE;
      lv_overdue_int               CHAR(1):='N';
      lv_renewal_account       CHAR(1):='N';
      lv_credit_debit_ind       CHAR(1);
      lv_int_book_diff1           NUMBER(22,6);
      lv_int_book_diff2           NUMBER(22,6);
      lv_nrml_int_book_dr_diff1    NUMBER(22,6);
      lv_nrml_int_book_cr_diff1    NUMBER(22,6);
      lv_penl_int_book_dr_diff1    NUMBER(22,6);
      lv_ovdu_int_book_diff1       NUMBER(22,6);
      lv_nrml_outstanding_int_cr   NUMBER(22,6);
      lv_nrml_outstanding_pandl_cr NUMBER(22,6);
      lv_tran_amt_int_adm        NUMBER(22,6);
      lv_pandl_bacid                tbaadm.gam.bacid%TYPE;
      lv_pandl_glacid               tbaadm.gam.acid%TYPE;
      lv_pandl_glacc                tbaadm.gam.foracid%TYPE;
      lv_overdue_idt           NUMBER(22,6);
      lv_bkdamtdr_ovdu_reversed    NUMBER(22,6);
      lv_bkdamtdr_ovdu_app_pandl   NUMBER(22,6);
      lv_bkdamtdr_ovdu_app_gl      NUMBER(22,6);
      lv_open_eff_date           DATE;
      lv_count3               NUMBER:=0;
      lv_ovdu_pay_out_flg          CHAR(1);
      lv_last_int_cr_tran_date     DATE;
      lv_pid               VARCHAR2(20);
      lv_unique_id           VARCHAR2(40);
   --End of modification
   BEGIN
      --{
      out_rec := NULL;
      out_retcode := 0;
      tbaadm.basp0099.forminputarr (inp_str, outarr);
      lv_bankid := NVL (UPPER (outarr (0)), 'NG');
      lv_boddate := TO_DATE (outarr (1), 'dd-mm-yyyy');
      lv_inp_solid :=outarr(2);
      lv_pid:=outarr(3);
      lv_unique_id:=lv_pid||lv_inp_solid||TO_CHAR(lv_boddate,'ddmmyyyy');
      out_rec := 'Processing'||lv_pid;

      BEGIN
         --{

         -------------------------------------------------------------

         -- Fetcing previous date

         -------------------------------------------------------------
         SELECT dc_cls_date
         INTO lv_prevdate
         FROM tbaadm.gct
         WHERE bank_id = lv_bankid;

      --}
      END;

      lv_sba_date:=lv_boddate;
      lv_oda_date:=lv_boddate;
      lv_caa_date:=lv_boddate;
      lv_laa_date:=lv_boddate;
      lv_tda_date:=lv_boddate;
      lv_tua_date:=lv_boddate;
      lv_cla_date:=lv_boddate;

      -------------------------------------------------------------

      -- c_eit_backup cursor fetch

      -------------------------------------------------------------
      IF (NOT entity_id_fetch_cur%ISOPEN)
      THEN
         --{
         OPEN entity_id_fetch_cur (lv_bankid,
                                   lv_sba_date,
                                   lv_oda_date,
                                   lv_caa_date,
                                   lv_laa_date,
                                   lv_tda_date,
                                   lv_tua_date,
                                   lv_cla_date,
                                   lv_inp_solid
                                  );
      --}
      END IF;

      IF (entity_id_fetch_cur%ISOPEN)
      THEN
         --{
         FETCH entity_id_fetch_cur
          INTO lv_acid, lv_acctown, lv_eitdate, lv_bacid, lv_foracid,
               lv_acctcrncy, lv_solid, lv_schm_type, lv_schm_code,
               lv_unclrbalamt, lv_futbalamt, lv_lienamt, lv_glsub;


         IF (entity_id_fetch_cur%NOTFOUND)
         THEN
            --{
                DBMS_OUTPUT.put_line ('closed');
                out_rec := out_rec || 'Cursor entity_id_fetch_cur closed';

                CLOSE entity_id_fetch_cur;
                out_retcode := 1;
                RETURN;
         --}
         END IF;

         out_rec := out_rec || 'lv_acid' || lv_acid;
         lv_count := lv_count + 1;

         IF (lv_acctown != 'O')
         THEN
            --{
            BEGIN
               --{
                       ------------------------------------------------------------------------------------------------
                       --Fetching the count of records from c_eit_backup to check whether only single record is present
                       ------------------------------------------------------------------------------------------------
                       lv_count2:=0;
                       SELECT count(1)
                       INTO lv_count2
                       FROM c_eit_backup a
                       WHERE a.entity_id = lv_acid
                       AND a.bank_id = lv_bankid;

            -------------------------------------------------------------------------------
            --Fetching the rcre time of both the records to check whether the latest record
            --is a newly created record which is possible in case of TD renewal
            -------------------------------------------------------------------------------

            IF(lv_count2=2)
            THEN
            --{
                SELECT a.rcre_time,b.rcre_time
                INTO lv_rcretime1,lv_rcretime2
                FROM   c_eit_backup a, c_eit_backup b
                WHERE a.entity_id = lv_acid
                AND b.entity_id = a.entity_id
                AND a.eit_date = lv_eitdate
                AND b.eit_date < lv_eitdate
                AND a.entity_id = b.entity_id
                AND a.bank_id = lv_bankid
                AND b.bank_id = a.bank_id;
            --}
            END IF;
            lv_overdue_int:='N';
            lv_renewal_account:='N';
            lv_nrml_int_book_dr_diff1:=0;
            lv_nrml_int_book_cr_diff1:=0;

        lv_penl_int_book_dr_diff1:=0;
        lv_ovdu_int_book_diff1:=0;

            lv_nrml_outstanding_int_cr:=0;
            lv_nrml_outstanding_pandl_cr:=0;

            IF((lv_count2=1) OR (lv_rcretime1!=lv_rcretime2))
            THEN
            --{
                    out_rec := out_rec ||'|new account or renewal account|'||lv_acid;
                       -------------------------------------------------------------

                       -- Query to calculate booked amount today and interest applied today

                       -------------------------------------------------------------
                       SELECT (  (a.nrml_accrued_amount_cr
                         )
                          ) accramtcr,
                          (  (a.nrml_booked_amount_cr )

                          ) bkdamtcr,
                        (a.nrml_interest_amount_cr


                         )applamtcr,

                          ( (  a.nrml_accrued_amount_dr
                           + a.addnl_accrued_amount_dr
                           + a.qis_accrued_amount_dr
                           + a.stock_accrued_amount_dr

                          )) accramtdr,

                          (a.penal_accrued_amount_dr
                          ) accrpenaldr,
                          (  (  a.nrml_booked_amount_dr
                           + a.stock_booked_amount_dr
                           + a.qis_booked_amount_dr
                           + a.addnl_booked_amount_dr

                          )
                          ) bkdamtdr,
                          (a.penal_booked_amount_dr
                          ) bkdpenaldr,
                          (  ((  a.nrml_interest_amount_dr
                           + a.addnl_interest_amount_dr
                           + a.qis_interest_amount_dr
                           + a.stock_interest_amount_dr

                          )
                         )
                          ) applamtdr,
                          (  (  a.penal_interest_amount_dr
                          + a.penal_adv_int_amount_dr
                         )
                          ) applpenaldr,
                          NVL (a.accrued_upto_date_cr, a.accrued_upto_date_dr)
                                               accruptodt,
                          NVL (a.booked_upto_date_cr, a.booked_upto_date_dr)
                                                bkduptodt,
                          NVL (a.last_book_cr_tran_id, a.last_book_dr_tran_id)
                                                bkdtranid,
                          NVL (a.last_int_cr_tran_id, a.last_int_dr_tran_id)
                                               appltranid,
                          NVL (a.last_int_cr_tran_date, a.last_int_dr_tran_date)
                                               appltrandt,
                          a.accrued_upto_date_cr accruptodtcr,
                          a.accrued_upto_date_dr accruptodtdr,
                          a.booked_upto_date_cr bkduptodtcr,
                          a.booked_upto_date_dr bkduptodtdr,
                          a.last_int_cr_tran_date appltrandtcr,
                          a.last_int_dr_tran_date appltrandtdr,
                          a.last_book_cr_tran_id bkdtranidcr,
                          a.last_book_dr_tran_id bkdtraniddr,
                          a.last_int_cr_tran_id appltranidcr,
                          a.last_int_dr_tran_id appltraniddr,
                          a.interest_rate,
                          ((  a.nrml_accrued_amount_dr
                        + a.addnl_accrued_amount_dr
                        + a.qis_accrued_amount_dr
                        + a.stock_accrued_amount_dr
                        + a.ovdu_accrued_amount_dr
                           )
                          ) accuptoamtdr,
                          a.penal_accrued_amount_dr,
                          ((  a.nrml_booked_amount_dr
                        + a.stock_booked_amount_dr
                        + a.ovdu_booked_amount_dr
                        + a.qis_booked_amount_dr
                        + a.addnl_booked_amount_dr
                           )
                          ) bkduptoamtdr,
                          a.penal_booked_amount_dr,
                          ((  a.nrml_interest_amount_dr
                        + a.addnl_interest_amount_dr
                        + a.qis_interest_amount_dr
                        + a.stock_interest_amount_dr
                        + a.ovdu_interest_amount_dr
                           )
                          ) appluptoamtdr,
                          (a.penal_interest_amount_dr + a.penal_adv_int_amount_dr
                          ) applpenaluptoamtdr,
                          a.nrml_accrued_amount_cr, a.nrml_booked_amount_cr,
                          a.nrml_interest_amount_cr, a.eit_date, a.lchg_user_id,
                          a.lchg_time, a.rcre_user_id, a.rcre_time,

                          --Added by Maniraj for calculating the difference between the over due amounts
                          (a.ovdu_booked_amount_dr
                          ) bkdamtdr_ovdu,
                          (a.ovdu_interest_amount_dr
                          ) applamtdr_ovdu,
                          (a.ovdu_accrued_amount_dr
                          ) accramtdr_ovdu
                     --End of modification
                       INTO   lv_accr_amt_today_cr,
                          lv_bkd_amt_today_cr,
                          lv_appl_amt_today_cr,
                          lv_accr_amt_today_dr,
                          lv_accr_penal_amt_today_dr,
                          lv_bkd_amt_today_dr,
                          lv_bkd_penal_amt_today_dr,
                          lv_appl_amt_today_dr,
                          lv_appl_penal_amt_today_dr,
                          lv_accruptodt,
                          lv_bkduptodt,
                          lv_bkdtranid,
                          lv_appltranid,
                          lv_appltrandt,
                          lv_accruptodtcr,
                          lv_accruptodtdr,
                          lv_bkduptodtcr,
                          lv_bkduptodtdr,
                          lv_appltrandtcr,
                          lv_appltrandtdr,
                          lv_bkdtranidcr,
                          lv_bkdtraniddr,
                          lv_appltranidcr,
                          lv_appltraniddr,
                          lv_intrate,
                          lv_accr_upto_amt_dr,
                          lv_accr_penal_upto_dr,
                          lv_bkd_upto_amt_dr,
                          lv_bkd_penal_upto_dr,
                          lv_appl_upto_amt_dr,
                          lv_appl_penal_upto_dr,
                          lv_accr_upto_amt_cr, lv_bkd_upto_amt_cr,
                          lv_appl_upto_amt_cr, lv_eabdate, lv_lchguserid,
                          lv_lchgtime, lv_rcreuserid, lv_rcretime,
                          --Added by Maniraj for calculating the difference between the over due amounts
                          lv_bkdamtdr_ovdu,
                          lv_applamtdr_ovdu,
                          lv_accramtdr_ovdu

                     --End of modification
                       FROM   c_eit_backup a
                       WHERE a.entity_id = lv_acid
                       AND a.eit_date = lv_eitdate
                       AND a.bank_id = lv_bankid;

                       --------------------------------------------------------------
                       --Fetching the overdue amounts in case of renewal account
                       --as when TD account is renewed overdue interest is taken back
                       --from the Overdue Interest Payable
                       ---------------------------------------------------------------

                       IF((lv_count2=2) and ((lv_schm_type='TDA') OR (lv_schm_type='TUA')))
                       THEN
                       --{

                              SELECT (b.ovdu_booked_amount_dr - b.ovdu_interest_amount_dr
                          ) bkdamtdr_ovdu,
                          (b.nrml_booked_amount_cr - b.nrml_interest_amount_cr)nrml_outstanding_int_cr,
                          b.last_int_cr_tran_date
                          INTO
                          lv_bkdamtdr_ovdu_ret,
                          lv_nrml_outstanding_int_cr,
                          lv_last_int_cr_tran_date

                               FROM   c_eit_backup a, c_eit_backup b
                WHERE a.entity_id = lv_acid
                AND b.entity_id = a.entity_id
                AND a.eit_date = lv_eitdate
                AND b.eit_date < lv_eitdate
                AND a.entity_id = b.entity_id
                AND a.bank_id = lv_bankid
                            AND b.bank_id = a.bank_id;

                            lv_renewal_account:='Y';

                       --}
                       END IF;


            --}
            ELSE
            --{
                   -------------------------------------------------------------

                   -- Query to calculate booked amount today and interest applied today

                   -------------------------------------------------------------
                   SELECT (  (a.nrml_accrued_amount_cr
                     )
                       - (b.nrml_accrued_amount_cr
                     )
                      ) accramtcr,
                      (  (a.nrml_booked_amount_cr )
                       - (b.nrml_booked_amount_cr )
                      ) bkdamtcr,
                      (  (a.nrml_interest_amount_cr


                     )
                       - (b.nrml_interest_amount_cr


                     )
                      ) applamtcr,
                      (  ((  a.nrml_accrued_amount_dr
                       + a.addnl_accrued_amount_dr
                       + a.qis_accrued_amount_dr
                       + a.stock_accrued_amount_dr

                      )
                     )
                       - ((  b.nrml_accrued_amount_dr
                       + b.addnl_accrued_amount_dr
                       + b.qis_accrued_amount_dr
                       + b.stock_accrued_amount_dr

                      )
                     )
                      ) accramtdr,
                      (a.penal_accrued_amount_dr - b.penal_accrued_amount_dr
                      ) accrpenaldr,
                      (  ((  a.nrml_booked_amount_dr
                       + a.stock_booked_amount_dr
                       + a.qis_booked_amount_dr
                       + a.addnl_booked_amount_dr


                      )
                     )
                       - ((  b.nrml_booked_amount_dr
                       + b.stock_booked_amount_dr
                       + b.qis_booked_amount_dr
                       + b.addnl_booked_amount_dr

                      )
                     )
                      ) bkdamtdr,
                      (a.penal_booked_amount_dr - b.penal_booked_amount_dr
                      ) bkdpenaldr,
                      (  ((  a.nrml_interest_amount_dr
                       + a.addnl_interest_amount_dr
                       + a.qis_interest_amount_dr
                       + a.stock_interest_amount_dr


                      )
                     )
                       - ((  b.nrml_interest_amount_dr
                       + b.addnl_interest_amount_dr
                       + b.qis_interest_amount_dr
                       + b.stock_interest_amount_dr

                      )
                     )
                      ) applamtdr,
                      (  (  a.penal_interest_amount_dr
                      + a.penal_adv_int_amount_dr
                     )
                       - (  b.penal_interest_amount_dr
                      + b.penal_adv_int_amount_dr
                     )
                      ) applpenaldr,
                      NVL (a.accrued_upto_date_cr, a.accrued_upto_date_dr)
                                           accruptodt,
                      NVL (a.booked_upto_date_cr, a.booked_upto_date_dr)
                                            bkduptodt,
                      NVL (a.last_book_cr_tran_id, a.last_book_dr_tran_id)
                                            bkdtranid,
                      NVL (a.last_int_cr_tran_id, a.last_int_dr_tran_id)
                                           appltranid,
                      NVL (a.last_int_cr_tran_date, a.last_int_dr_tran_date)
                                           appltrandt,
                      a.accrued_upto_date_cr accruptodtcr,
                      a.accrued_upto_date_dr accruptodtdr,
                      a.booked_upto_date_cr bkduptodtcr,
                      a.booked_upto_date_dr bkduptodtdr,
                      a.last_int_cr_tran_date appltrandtcr,
                      a.last_int_dr_tran_date appltrandtdr,
                      a.last_book_cr_tran_id bkdtranidcr,
                      a.last_book_dr_tran_id bkdtraniddr,
                      a.last_int_cr_tran_id appltranidcr,
                      a.last_int_dr_tran_id appltraniddr,
                      a.interest_rate,
                      ((  a.nrml_accrued_amount_dr
                    + a.addnl_accrued_amount_dr
                    + a.qis_accrued_amount_dr
                    + a.stock_accrued_amount_dr
                    + a.ovdu_accrued_amount_dr
                       )
                      ) accuptoamtdr,
                      a.penal_accrued_amount_dr,
                      ((  a.nrml_booked_amount_dr
                    + a.stock_booked_amount_dr
                    + a.ovdu_booked_amount_dr
                    + a.qis_booked_amount_dr
                    + a.addnl_booked_amount_dr
                       )
                      ) bkduptoamtdr,
                      a.penal_booked_amount_dr,
                      ((  a.nrml_interest_amount_dr
                    + a.addnl_interest_amount_dr
                    + a.qis_interest_amount_dr
                    + a.stock_interest_amount_dr
                    + a.ovdu_interest_amount_dr
                       )
                      ) appluptoamtdr,
                      (a.penal_interest_amount_dr + a.penal_adv_int_amount_dr
                      ) applpenaluptoamtdr,
                      a.nrml_accrued_amount_cr, a.nrml_booked_amount_cr,
                      a.nrml_interest_amount_cr, b.eit_date, a.lchg_user_id,
                      a.lchg_time, a.rcre_user_id, a.rcre_time,

                      --Added by Maniraj for calculating the difference between the over due amounts
                      (a.ovdu_booked_amount_dr - b.ovdu_booked_amount_dr
                      ) bkdamtdr_ovdu,
                      (a.ovdu_interest_amount_dr - b.ovdu_interest_amount_dr
                      ) applamtdr_ovdu,
                      (a.ovdu_accrued_amount_dr - b.ovdu_accrued_amount_dr
                      ) accramtdr_ovdu,
                      ((  a.nrml_interest_amount_dr
                                  + a.addnl_interest_amount_dr
                                  + a.qis_interest_amount_dr
                                  + a.stock_interest_amount_dr
                                     )-( b.nrml_booked_amount_dr
                       + b.stock_booked_amount_dr
                       + b.qis_booked_amount_dr
                       + b.addnl_booked_amount_dr

                      ))nrml_int_book_dr_diff1,
                      (a.penal_interest_amount_dr - b.penal_booked_amount_dr)penl_int_book_dr_diff1,
                      (a.ovdu_interest_amount_dr - b.ovdu_booked_amount_dr)ovdu_int_book_diff1,
                      (a.nrml_interest_amount_cr - b.nrml_booked_amount_cr)nrml_int_book_cr_diff1


                 --End of modification
                   INTO   lv_accr_amt_today_cr,
                      lv_bkd_amt_today_cr,
                      lv_appl_amt_today_cr,
                      lv_accr_amt_today_dr,
                      lv_accr_penal_amt_today_dr,
                      lv_bkd_amt_today_dr,
                      lv_bkd_penal_amt_today_dr,
                      lv_appl_amt_today_dr,
                      lv_appl_penal_amt_today_dr,
                      lv_accruptodt,
                      lv_bkduptodt,
                      lv_bkdtranid,
                      lv_appltranid,
                      lv_appltrandt,
                      lv_accruptodtcr,
                      lv_accruptodtdr,
                      lv_bkduptodtcr,
                      lv_bkduptodtdr,
                      lv_appltrandtcr,
                      lv_appltrandtdr,
                      lv_bkdtranidcr,
                      lv_bkdtraniddr,
                      lv_appltranidcr,
                      lv_appltraniddr,
                      lv_intrate,
                      lv_accr_upto_amt_dr,
                      lv_accr_penal_upto_dr,
                      lv_bkd_upto_amt_dr,
                      lv_bkd_penal_upto_dr,
                      lv_appl_upto_amt_dr,
                      lv_appl_penal_upto_dr,
                      lv_accr_upto_amt_cr, lv_bkd_upto_amt_cr,
                      lv_appl_upto_amt_cr, lv_eabdate, lv_lchguserid,
                      lv_lchgtime, lv_rcreuserid, lv_rcretime,
                      --Added by Maniraj for calculating the difference between the over due amounts
                      lv_bkdamtdr_ovdu,
                      lv_applamtdr_ovdu,
                      lv_accramtdr_ovdu,
                      lv_nrml_int_book_dr_diff1,
                      lv_penl_int_book_dr_diff1,
                      lv_ovdu_int_book_diff1,
                      lv_nrml_int_book_cr_diff1

                 --End of modification
                    FROM   c_eit_backup a, c_eit_backup b
                    WHERE a.entity_id = lv_acid
                    AND b.entity_id = a.entity_id
                    AND a.eit_date = lv_eitdate
                    AND b.eit_date < lv_eitdate
                    AND a.entity_id = b.entity_id
                    AND a.bank_id = lv_bankid
                    AND b.bank_id = a.bank_id;
                        --}
            END IF;





               --out_rec := out_rec || '| Main query successful |'||'|Booked Amount today|'||lv_bkd_amt_today_dr;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  out_rec :=
                        out_rec
                     || 'Main query did not return any record |'
                     || lv_acid;
                  GOTO nextrec;
            --}
            END;
         --}
         END IF;

     -------------------------------------------------------------

         -- Fetching EOD balance for the customer acid

         -------------------------------------------------------------
         BEGIN
            --{
                SELECT tran_date_bal
                INTO lv_eodbal
                FROM tbaadm.eab
                WHERE acid = lv_acid
                AND eod_date = lv_prevdate
                AND bank_id = lv_bankid;

         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               lv_eodbal := 0;
         --}
         END;

     -------------------------------------------------------------

         -- Fetching free_code_7 from GAC for the customer acid

         -------------------------------------------------------------
         BEGIN
            --{
                SELECT free_code_7
                INTO lv_freecode7
                FROM tbaadm.gac
                WHERE acid = lv_acid
                AND bank_id = lv_bankid;

             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                lv_freecode7 := '';
         --}
         END;

        -- out_rec := out_rec || '| Before segmentation fetch |';

    -----------------------------------------------------------------

         -- Fetching SEGMENT details from ACCOUNTS for the customer acid

         -----------------------------------------------------------------
         BEGIN
            --{
                SELECT segmentation_class, subsegment
                INTO lv_segment, lv_subsegment
                FROM crmuser.accounts acc, tbaadm.gam
                WHERE gam.acid = lv_acid
                AND gam.bank_id = lv_bankid
                AND gam.entity_cre_flg = 'Y'
                AND gam.del_flg != 'Y'
                AND acc.orgkey = gam.cif_id
                AND acc.bank_id = lv_bankid;

         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               lv_segment := '';
               lv_subsegment := '';
         --}
         END;

    -------------------------------------------------------------

         -- Setting the Interest flag

         -------------------------------------------------------------
       BEGIN
       --{
               SELECT int_paid_flg,int_coll_flg
               INTO lv_intpdflg,lv_intcollflg
               FROM tbaadm.GSP
               WHERE schm_code=lv_schm_code
               AND schm_type=lv_schm_type
               AND bank_id=lv_bankid;
            EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
        lv_intpdflg := '';
        lv_intcollflg := '';
    --}
    END;

         IF (lv_intpdflg = 'Y')
         THEN
            --{
            lv_crdrflg := 'C';
         --}
         END IF;

         IF (lv_intcollflg = 'Y')
     THEN
         --{
            lv_crdrflg := 'D';
      --}
         END IF;

    -----------------------------------------------------------

         --lv_bkdappl_flg - A-Int applied , B- Booking, X-Accrual

         -- If applied amount today cr/dr is > 0 then application.

         -- Else if booking amt today cr/dr >0 then booking

         -- Else Accrual. Accrual records are not insrter into C_EIT table.

         -----------------------------------------------------------
         IF ((lv_appl_amt_today_cr != 0) OR (lv_appl_amt_today_dr != 0) OR (lv_appl_penal_amt_today_dr !=0) OR (lv_applamtdr_ovdu !=0))
         THEN
            --{
            lv_bkdappl_flg := 'A';
            --out_rec :=out_rec || '| Before dctd_acli query |' || lv_bkdappl_flg;

        -------------------------------------------------------------

            -- calling procedure to fetch tran details for interest application tran id and insert into C_EIT.

            -------------------------------------------------------------
            IF((lv_schm_type='ODA') OR (lv_schm_type='CAA')) THEN
            --{
                c_eit_tran_fetch_pack.c_eit_appl_tran_fetch_proc_oda
                             (lv_appltrandt,
                              lv_appltranid,
                              lv_bkdtranid,
                              lv_acid,
                              lv_foracid,
                              lv_solid,
                              lv_schm_type,
                              lv_schm_code,
                              lv_eodbal,
                              lv_unclrbalamt,
                              lv_futbalamt,
                              lv_lienamt,
                              lv_glsub,
                              lv_intcollflg,
                              lv_intpdflg,
                              lv_crdrflg,
                              lv_intrate,
                              lv_bkdappl_flg,
                              lv_accruptodt,
                              lv_accr_upto_amt_cr,
                              lv_accr_upto_amt_dr,
                              lv_accr_amt_today_cr,
                              lv_accr_amt_today_dr,
                              lv_bkduptodt,
                              lv_bkd_upto_amt_cr,
                              lv_bkd_upto_amt_dr,
                              lv_bkd_amt_today_cr,
                              lv_bkd_amt_today_dr,
                              lv_appl_upto_amt_cr,
                              lv_appl_upto_amt_dr,
                              lv_appl_amt_today_cr,
                              lv_appl_amt_today_dr,
                              lv_segment,
                              lv_subsegment,
                              lv_freecode7,
                              lv_rcreuserid,
                              lv_rcretime,
                              lv_lchguserid,
                              lv_lchgtime,
                              lv_bankid,
                              lv_errmsg,
                              lv_accr_penal_amt_today_dr,
                              lv_bkd_penal_amt_today_dr,
                              lv_appl_penal_amt_today_dr,
                              lv_accr_penal_upto_dr,
                              lv_bkd_penal_upto_dr,
                              lv_appl_penal_upto_dr,
                              lv_applamtdr_ovdu,
                              lv_bkdamtdr_ovdu,
                              lv_accramtdr_ovdu,
                              lv_accruptodtcr,
                              lv_accruptodtdr,
                              lv_bkduptodtcr,
                              lv_bkduptodtdr,
                              lv_appltrandtcr,
                              lv_appltrandtdr,
                              lv_bkdtranidcr,
                              lv_bkdtraniddr,
                              lv_appltranidcr,
                              lv_appltraniddr,
                              lv_acctcrncy,
                              lv_prevdate,
                              lv_unique_id

                             );
            --}
            ELSE
            --{
            c_eit_tran_fetch_pack.c_eit_appl_tran_fetch_proc
                             (lv_appltrandt,
                              lv_appltranid,
                              lv_bkdtranid,
                              lv_acid,
                              lv_foracid,
                              lv_solid,
                              lv_schm_type,
                              lv_schm_code,
                              lv_eodbal,
                              lv_unclrbalamt,
                              lv_futbalamt,
                              lv_lienamt,
                              lv_glsub,
                              lv_intcollflg,
                              lv_intpdflg,
                              lv_crdrflg,
                              lv_intrate,
                              lv_bkdappl_flg,
                              lv_accruptodt,
                              lv_accr_upto_amt_cr,
                              lv_accr_upto_amt_dr,
                              lv_accr_amt_today_cr,
                              lv_accr_amt_today_dr,
                              lv_bkduptodt,
                              lv_bkd_upto_amt_cr,
                              lv_bkd_upto_amt_dr,
                              lv_bkd_amt_today_cr,
                              lv_bkd_amt_today_dr,
                              lv_appl_upto_amt_cr,
                              lv_appl_upto_amt_dr,
                              lv_appl_amt_today_cr,
                              lv_appl_amt_today_dr,
                              lv_segment,
                              lv_subsegment,
                              lv_freecode7,
                              lv_rcreuserid,
                              lv_rcretime,
                              lv_lchguserid,
                              lv_lchgtime,
                              lv_bankid,
                              lv_errmsg,
                              lv_accr_penal_amt_today_dr,
                              lv_bkd_penal_amt_today_dr,
                              lv_appl_penal_amt_today_dr,
                              lv_accr_penal_upto_dr,
                              lv_bkd_penal_upto_dr,
                              lv_appl_penal_upto_dr,
                              lv_applamtdr_ovdu,
                              lv_bkdamtdr_ovdu,
                              lv_accramtdr_ovdu,
                              lv_acctcrncy,
                              lv_prevdate,
                              lv_nrml_int_book_dr_diff1,
                  lv_penl_int_book_dr_diff1,
                  lv_ovdu_int_book_diff1,
                  lv_nrml_int_book_cr_diff1,
                  lv_unique_id

                             );

       --}
        END IF;
         --}
         ELSE
            --{
            IF ((lv_bkd_amt_today_cr != 0) OR (lv_bkd_amt_today_dr != 0) OR (lv_bkd_penal_amt_today_dr !=0) OR (lv_bkdamtdr_ovdu !=0 ))
            THEN
               --{
               lv_bkdappl_flg := 'B';
               --out_rec :=out_rec || '| Before dctd_acli query |' || lv_bkdappl_flg;

        -------------------------------------------------------------------------------------------

               -- calling procedure to fetch tran details for interest booked tran id and insert into C_EIT.

               --------------------------------------------------------------------------------------------
               IF((lv_schm_type='ODA') OR (lv_schm_type='CAA')) THEN
               --{
                       c_eit_tran_fetch_pack.c_eit_book_tran_fetch_proc_oda
                               (lv_bkduptodt,
                            lv_bkdtranid,
                            lv_acctcrncy,
                            lv_foracid,
                            lv_solid,
                            lv_schm_type,
                            lv_schm_code,
                            lv_eodbal,
                            lv_unclrbalamt,
                            lv_futbalamt,
                            lv_lienamt,
                            lv_glsub,
                            lv_intcollflg,
                            lv_intpdflg,
                            lv_crdrflg,
                            lv_intrate,
                            lv_bkdappl_flg,
                            lv_accruptodt,
                            lv_accr_upto_amt_cr,
                            lv_accr_upto_amt_dr,
                            lv_accr_amt_today_cr,
                            lv_accr_amt_today_dr,
                            lv_bkd_upto_amt_cr,
                            lv_bkd_upto_amt_dr,
                            lv_bkd_amt_today_cr,
                            lv_bkd_amt_today_dr,
                            lv_appltrandt,
                            lv_appl_upto_amt_cr,
                            lv_appl_upto_amt_dr,
                            lv_appl_amt_today_cr,
                            lv_appl_amt_today_dr,
                            lv_segment,
                            lv_subsegment,
                            lv_freecode7,
                            lv_rcreuserid,
                            lv_rcretime,
                            lv_lchguserid,
                            lv_lchgtime,
                            lv_bankid,
                            lv_errmsg,
                            lv_bkdamtdr_ovdu,
                            lv_applamtdr_ovdu,
                            lv_accramtdr_ovdu,
                            lv_bkd_penal_amt_today_dr,
                            lv_accr_penal_amt_today_dr,
                            lv_appl_penal_amt_today_dr,
                            lv_accr_penal_upto_dr,
                            lv_bkd_penal_upto_dr,
                            lv_appl_penal_upto_dr,
                            lv_accruptodtcr,
                            lv_accruptodtdr,
                            lv_bkduptodtcr,
                            lv_bkduptodtdr,
                            lv_appltrandtcr,
                            lv_appltrandtdr,
                            lv_bkdtranidcr,
                            lv_bkdtraniddr,
                            lv_appltranidcr,
                            lv_appltraniddr,
                            lv_acid,
                            lv_unique_id
                            );
               --}
               ELSE
               --{
                       c_eit_tran_fetch_pack.c_eit_book_tran_fetch_proc
                               (lv_bkduptodt,
                            lv_bkdtranid,
                            lv_acctcrncy,
                            lv_foracid,
                            lv_solid,
                            lv_schm_type,
                            lv_schm_code,
                            lv_eodbal,
                            lv_unclrbalamt,
                            lv_futbalamt,
                            lv_lienamt,
                            lv_glsub,
                            lv_intcollflg,
                            lv_intpdflg,
                            lv_crdrflg,
                            lv_intrate,
                            lv_bkdappl_flg,
                            lv_accruptodt,
                            lv_accr_upto_amt_cr,
                            lv_accr_upto_amt_dr,
                            lv_accr_amt_today_cr,
                            lv_accr_amt_today_dr,
                            lv_bkd_upto_amt_cr,
                            lv_bkd_upto_amt_dr,
                            lv_bkd_amt_today_cr,
                            lv_bkd_amt_today_dr,
                            lv_appltrandt,
                            lv_appl_upto_amt_cr,
                            lv_appl_upto_amt_dr,
                            lv_appl_amt_today_cr,
                            lv_appl_amt_today_dr,
                            lv_segment,
                            lv_subsegment,
                            lv_freecode7,
                            lv_rcreuserid,
                            lv_rcretime,
                            lv_lchguserid,
                            lv_lchgtime,
                            lv_bankid,
                            lv_errmsg,
                            lv_bkdamtdr_ovdu,
                            lv_applamtdr_ovdu,
                            lv_accramtdr_ovdu,
                            lv_bkd_penal_amt_today_dr,
                            lv_accr_penal_amt_today_dr,
                            lv_appl_penal_amt_today_dr,
                            lv_accr_penal_upto_dr,
                            lv_bkd_penal_upto_dr,
                            lv_appl_penal_upto_dr,
                            lv_acid,
                            lv_unique_id
                                                       );
               --}
               END IF;

               --out_rec := out_rec || lv_errmsg;
            --}
            ELSE
               --{
               lv_bkdappl_flg := 'X';
               lv_glacc := '';
               lv_ptransrlnum := '';
               lv_tranpart := '';
               lv_tranamt := 0;
               lv_tranpart2 := '';
               lv_tranrmks := '';
               lv_ptrantype := '';
               lv_trancrncy := '';
               --out_rec :=out_rec || '| Before dctd_acli query |' || lv_bkdappl_flg;

            --}
            END IF;


         --}
         END IF;

         ------------------------------------
             --Bonus Interest
         ------------------------------------
         lv_bonusBooking:='N';
         lv_bonusApp:='N';

         --Checking whether bonus intrest booking is done on the customer account
         select count(1) into lv_count2
         from c_bib
         where acid=lv_acid
         and ((tran_date=lv_eitdate) or (rev_tran_date=lv_eitdate))
         and bank_id=lv_bankid;
         IF(lv_count2>0)
         THEN
         --{
        lv_bonusBooking:='Y';
         --}
         END IF;

         --Checking whether bonus interest application is done on the customer account
         lv_count2:=0;
         select count(1) into lv_count2
         from c_bia
         where acid=lv_acid
         and tran_date=lv_eitdate
         and bank_id=lv_bankid;
         IF(lv_count2>0)
         THEN
         --{
        lv_bonusApp:='Y';
         --}
         END IF;

         IF((lv_bonusBooking='Y') OR (lv_bonusApp='Y'))
         THEN
         --{
            c_eit_tran_fetch_pack.c_eit_tran_fetch_proc_bonus
                                       (lv_bkduptodt,
                                    lv_bkdtranid,
                                    lv_acctcrncy,
                                    lv_foracid,
                                    lv_solid,
                                    lv_schm_type,
                                    lv_schm_code,
                                    lv_eodbal,
                                    lv_unclrbalamt,
                                    lv_futbalamt,
                                    lv_lienamt,
                                    lv_glsub,
                                    lv_intcollflg,
                                    lv_intpdflg,
                                    lv_crdrflg,
                                    lv_intrate,
                                    lv_bkdappl_flg,
                                    lv_accruptodt,
                                    lv_accr_upto_amt_cr,
                                    lv_accr_upto_amt_dr,
                                    lv_accr_amt_today_cr,
                                    lv_accr_amt_today_dr,
                                    lv_bkd_upto_amt_cr,
                                    lv_bkd_upto_amt_dr,
                                    lv_bkd_amt_today_cr,
                                    lv_bkd_amt_today_dr,
                                    lv_appltrandt,
                                    lv_appl_upto_amt_cr,
                                    lv_appl_upto_amt_dr,
                                    lv_appl_amt_today_cr,
                                    lv_appl_amt_today_dr,
                                    lv_segment,
                                    lv_subsegment,
                                    lv_freecode7,
                                    lv_rcreuserid,
                                    lv_rcretime,
                                    lv_lchguserid,
                                    lv_lchgtime,
                                    lv_bankid,
                                    lv_errmsg,
                                    lv_bkdamtdr_ovdu,
                                    lv_applamtdr_ovdu,
                                    lv_accramtdr_ovdu,
                                    lv_bkd_penal_amt_today_dr,
                                    lv_acid,
                                    lv_bonusBooking,
                                    lv_bonusApp,
                                    lv_eitdate,
                                    lv_unique_id);

         --}
        END IF;


       ----------------------------------------------------------
       --Inserting the overdue interest applied to the customer
       --account and also that will bre reversed to P/L account
       ----------------------------------------------------------

       IF(lv_renewal_account='Y')
       THEN
       --{

              -------------------
              --Overdue Interest
              -------------------
              lv_count3:=0;
              lv_overdue_idt:=0;
              lv_bkdamtdr_ovdu_reversed:=0;
              lv_bkdamtdr_ovdu_app_pandl:=0;
              lv_bkdamtdr_ovdu_app_gl:=0;
              lv_nrml_outstanding_pandl_cr:=0;


                   BEGIN
                   --{

                ---------------------------------------------
                --Fetching open effective date from TAM table
                ---------------------------------------------
                select open_effective_date
                into lv_open_eff_date
                from tbaadm.tam where acid=lv_acid
                and bank_id=lv_bankid;

                --------------------------------------------
                --Fetching overdue interest amount idt table
                --which will be credited to customer
                --account
                --------------------------------------------

                select count(1)
                into lv_count3
                from tbaadm.idt where entity_id=lv_acid
                and interest_type='O'
                and end_date<lv_open_eff_date
                and start_date>=lv_last_int_cr_tran_date
                and bank_id=lv_bankid;

                IF(lv_count3>0)
                THEN
                --{
                    select sum(interest_amount)
                    into lv_overdue_idt
                    from
                    tbaadm.idt where entity_id=lv_acid
                    and interest_type='O'
                    and entity_id||'!'||serial_num=(select entity_id||'!'||max(serial_num)
                    from tbaadm.idt where entity_id=lv_acid
                    and interest_type='O'
                    and end_date<lv_open_eff_date
                    and start_date>=lv_last_int_cr_tran_date
                    and bank_id=lv_bankid
                    group by entity_id)
                    and bank_id=lv_bankid;
                --}
                END IF;


                EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                lv_open_eff_date:=null;

                        --}
                        END;

                        BEGIN
                        --{
                            ------------------------------------------------
                            --Fetching Overdue Interest Payout flag from TSP
                            ------------------------------------------------

                            select OVDU_INT_PAY_OUT_FLG
                            into lv_ovdu_pay_out_flg
                            from tbaadm.tsp
                            where schm_code=lv_schm_code
                            and crncy_code=lv_acctcrncy
                            and bank_id=lv_bankid;

                            EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                            lv_ovdu_pay_out_flg:='';


                        --}
                        END;

                        -------------------------------------------------------
                        --Fetching the overdue Interest payout flag from
                        --custom table C_OVDU_FLG in case of renewal done
                        --by user manually
                        -------------------------------------------------------
                        lv_count3:=0;
                        select count(1)
                        into lv_count3
                        from custom.c_ovdu_flg
                        where cust_acct=lv_foracid
                        and ren_date=lv_prevdate
                        and bank_id=lv_bankid;

                        IF(lv_count3>0) THEN
                        --{
                            select ovdu_flg
                            into lv_ovdu_pay_out_flg
                            from custom.c_ovdu_flg
                            where cust_acct=lv_foracid
                and ren_date=lv_prevdate
                            and bank_id=lv_bankid
                            and rownum<2;
                        --}
                        END IF;

                IF((lv_bkdamtdr_ovdu_ret!=0) OR (lv_overdue_idt!=0))
            THEN
               --{
                   IF((lv_bkdamtdr_ovdu_ret>0))
                   THEN
                   --{
                               IF(lv_ovdu_pay_out_flg='Y')
                               THEN
                               --{
                                   lv_bkdamtdr_ovdu_reversed:= lv_bkdamtdr_ovdu_ret - lv_overdue_idt;
                               --}
                               ELSE
                               --{
                                   lv_bkdamtdr_ovdu_reversed:=lv_bkdamtdr_ovdu_ret;
                               --}
                               END IF;

                           --}
                           END IF;


               --}
               END IF;

               BEGIN
        --{
               SELECT ovdu_int_paid_bacid,OVDU_INT_PANDL_BACID_CR
               INTO lv_bacid,lv_pandl_bacid
               FROM tbaadm.gsp p
               WHERE p.schm_code = lv_schm_code
               AND p.bank_id = lv_bankid
               AND p.schm_type = lv_schm_type;

              -------------------------------------------------------------

              -- Fetching account id for bacid.

              -------------------------------------------------------------
              SELECT foracid,acid
              INTO lv_glacc,lv_glacid
              FROM tbaadm.gam
              WHERE bacid = lv_bacid
              AND sol_id = lv_solid
              AND acct_crncy_code = lv_acctcrncy
              AND bank_id = lv_bankid;

              SELECT foracid,acid
              INTO lv_pandl_glacc,lv_pandl_glacid
              FROM tbaadm.gam
              WHERE bacid = lv_pandl_bacid
              AND sol_id = lv_solid
              AND acct_crncy_code = lv_acctcrncy
              AND bank_id = lv_bankid;

          EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
             out_rec :=out_rec|| ' GAM  query didnt fetch any Record '|| lv_acid;


        --}
               END;

               IF(lv_bkdamtdr_ovdu_reversed>0)
               THEN
               --{
                   BEGIN
            --{
                  ----------------------------------------

                -- fetching tran details from dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code,tran_id
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy,lv_bkdtranid
                 FROM tbaadm.dctd_acli
                 WHERE tran_date = lv_prevdate
                 AND tran_particular LIKE '%' || lv_foracid || '%'
                 AND acid = lv_glacid
                 AND tran_rmks='Book Interest'
                 AND pstd_flg = 'Y'
                 AND del_flg != 'Y'
                 AND bank_id = lv_bankid
                 AND ROWNUM < 2;


                --out_rec := out_rec || '| After dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN

                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';
            --}
            END;

            -------------------------------------------------------------

               -- C_EIT insert

               -------------------------------------------------------------
               BEGIN
              --{
              INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                   VALUES (lv_prevdate, lv_bacid, lv_glacc,
                       lv_bkdtranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       'D', lv_intrate,
                       'B', lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       DECODE (lv_crdrflg,
                           'C', lv_accr_amt_today_cr,
                           lv_accr_amt_today_dr
                          ),
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       abs(lv_bkdamtdr_ovdu_reversed),
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       0,
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id);
                       COMMIT;

                       BEGIN
                      --{
                        SELECT part_tran_srl_num, tran_particular, tran_amt,
                              tran_particular_2, tran_rmks, part_tran_type,
                              tran_crncy_code,tran_id
                         INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                              lv_tranpart2, lv_tranrmks, lv_ptrantype,
                              lv_trancrncy,lv_bkdtranid
                         FROM tbaadm.dctd_acli
                         WHERE tran_date = lv_prevdate
                         AND tran_particular LIKE '%' || lv_foracid || '%'
                         AND acid = lv_pandl_glacid
                         AND tran_rmks='Book Interest'
                         AND pstd_flg = 'Y'
                         AND del_flg != 'Y'
                         AND bank_id = lv_bankid
                          AND ROWNUM < 2;
                       EXCEPTION
                       WHEN NO_DATA_FOUND
                       THEN
                       NULL;
                      --}
                      END;

                      INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                   VALUES (lv_prevdate, lv_pandl_bacid, lv_pandl_glacc,
                       lv_bkdtranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       'C', lv_intrate,
                       'B', lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       DECODE (lv_crdrflg,
                           'C', lv_accr_amt_today_cr,
                           lv_accr_amt_today_dr
                          ),
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       abs(lv_bkdamtdr_ovdu_reversed),
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       0,
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id
                      );


              COMMIT;


               EXCEPTION
              WHEN OTHERS
              THEN

                 out_rec := out_rec || 'Insert uncusscessful';

               --}
            END;
               --}
               END IF;

               IF(lv_ovdu_pay_out_flg='Y')
               THEN
               --{
                   IF((lv_overdue_idt!=0) and (lv_overdue_idt>lv_bkdamtdr_ovdu_ret))
            THEN
            --{
                lv_bkdamtdr_ovdu_app_pandl:=lv_overdue_idt - lv_bkdamtdr_ovdu_ret;
                lv_bkdamtdr_ovdu_app_gl:=lv_bkdamtdr_ovdu_ret;
            --}
            ELSE
            --{
                lv_bkdamtdr_ovdu_app_pandl:=0;
                lv_bkdamtdr_ovdu_app_gl:=lv_overdue_idt;
            --}
                   END IF;
               --}
               END IF;

               lv_count3:=0;


        BEGIN
        --{

            select count(1)
            INTO     lv_count3
            from tbaadm.int_adm
            where tran_date=lv_prevdate
            and acid=lv_acid
            and record_type='I'
            and bank_id=lv_bankid;

            EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
            lv_count3:=0;
            out_rec :=out_rec|| ' INT_ADM query failed'|| lv_acid;
            GOTO nextrec;

        --}
        END;

        IF(lv_count3=0)
        THEN
        --{
            out_rec :=out_rec|| ' INT_ADM query failed'|| lv_acid;
            GOTO nextrec;
        --}
        END IF;
               IF(lv_bkdamtdr_ovdu_app_pandl>0)
               THEN
               --{
                   BEGIN
            --{

                select tran_id
                into lv_appltranid
                FROM tbaadm.int_adm
                where acid=lv_acid
                and tran_date=lv_prevdate
                and record_type='I'
                and bank_id=lv_bankid
                and rownum<2;
            EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
            NULL;
            --}
            END;

                   BEGIN
            --{
                  ----------------------------------------

                -- fetching tran details from dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                 FROM tbaadm.dctd_acli
                 WHERE tran_id = LPAD (lv_appltranid, 9)
                 AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                     OR (acid = lv_pandl_glacid))
                 AND tran_date = lv_prevdate
                 AND pstd_flg = 'Y'
                 AND del_flg != 'Y'
                 AND bank_id = lv_bankid
                 AND ROWNUM < 2;


                --out_rec := out_rec || '| After dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN

                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';
            --}
            END;

            --out_rec :=out_rec|| ' before lv_bkdamtdr_ovdu_app_pandl insert'|| lv_acid;
            -------------------------------------------------------------

               -- C_EIT insert

               -------------------------------------------------------------
               BEGIN
              --{
              INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                   VALUES (lv_prevdate, lv_pandl_bacid, lv_pandl_glacc,
                       lv_appltranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       'D', lv_intrate,
                       'A', lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       0,
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       0,
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       abs(lv_bkdamtdr_ovdu_app_pandl),
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id
                      );

              COMMIT;


               EXCEPTION
              WHEN OTHERS
              THEN

                 out_rec := out_rec || 'Insert uncusscessful';

               --}
              END;


               --}
               END IF;

               IF(lv_bkdamtdr_ovdu_app_gl>0)
        THEN
        --{
            BEGIN
            --{

                select tran_id
                into lv_appltranid
                FROM tbaadm.int_adm
                where acid=lv_acid
                and tran_date=lv_prevdate
                and record_type='I'
                and bank_id=lv_bankid
                and rownum<2;
            EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
            NULL;
            --}
            END;

            BEGIN
            --{
                  ----------------------------------------

                -- fetching tran details from dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                 FROM tbaadm.dctd_acli
                 WHERE tran_id = LPAD (lv_appltranid, 9)
                 AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                 AND tran_date = lv_prevdate
                 AND pstd_flg = 'Y'
                 AND del_flg != 'Y'
                 AND bank_id = lv_bankid
                 AND ROWNUM < 2;


                --out_rec := out_rec || '| After dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN

                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';
            --}
            END;

            --out_rec :=out_rec|| ' before lv_bkdamtdr_ovdu_app_gl insert'|| lv_acid;
            -------------------------------------------------------------

               -- C_EIT insert

               -------------------------------------------------------------
               BEGIN
              --{
              INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                   VALUES (lv_prevdate, lv_bacid, lv_glacc,
                       lv_appltranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       'D', lv_intrate,
                       'A', lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       0,
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       0,
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       abs(lv_bkdamtdr_ovdu_app_gl),
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id
                      );

              COMMIT;


               EXCEPTION
              WHEN OTHERS
              THEN

                 out_rec := out_rec || 'Insert uncusscessful';

               --}
              END;


        --}
               END IF;

               ------------------------------
               --Normal Outsanding Interest
               ------------------------------

               BEGIN
        --{
               SELECT int_paid_bacid,INT_PANDL_BACID_CR
               INTO lv_bacid,lv_pandl_bacid
               FROM tbaadm.gsp p
               WHERE p.schm_code = lv_schm_code
               AND p.bank_id = lv_bankid
               AND p.schm_type = lv_schm_type;

              -------------------------------------------------------------

              -- Fetching account id for bacid.

              -------------------------------------------------------------
              SELECT foracid,acid
              INTO lv_glacc,lv_glacid
              FROM tbaadm.gam
              WHERE bacid = lv_bacid
              AND sol_id = lv_solid
              AND acct_crncy_code = lv_acctcrncy
              AND bank_id = lv_bankid;

              SELECT foracid,acid
              INTO lv_pandl_glacc,lv_pandl_glacid
              FROM tbaadm.gam
              WHERE bacid = lv_pandl_bacid
              AND sol_id = lv_solid
              AND acct_crncy_code = lv_acctcrncy
              AND bank_id = lv_bankid;

          EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
             out_rec :=out_rec|| ' GAM  query didnt fetch any Record '|| lv_acid;


        --}
               END;

               lv_tran_amt_int_adm:=0;
        BEGIN
        --{

            select sum(base_amount)
            INTO     lv_tran_amt_int_adm
            from tbaadm.int_adm
            where tran_date=lv_prevdate
            and acid=lv_acid
            and record_type='I'
            and bank_id=lv_bankid
            and rownum<2;

            EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
            lv_tran_amt_int_adm:=0;

            out_rec :=out_rec|| ' INT_ADM query failed'|| lv_acid;

        --}
        END;


               IF(lv_nrml_outstanding_int_cr>0)
               THEN
               --{
                   BEGIN
                   --{

                select tran_id
                into lv_appltranid
                FROM tbaadm.int_adm
                where acid=lv_acid
                and tran_date=lv_prevdate
                and record_type='I'
                and bank_id=lv_bankid
                and rownum<2;
            EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
            NULL;
            --}
            END;

            BEGIN
            --{
                  ----------------------------------------

                -- fetching tran details from dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                 FROM tbaadm.dctd_acli
                 WHERE tran_id = LPAD (lv_appltranid, 9)
                 AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_glacid)
                     OR (acid = lv_glacid))
                 AND tran_date = lv_prevdate
                 AND pstd_flg = 'Y'
                 AND del_flg != 'Y'
                 AND bank_id = lv_bankid
                 AND ROWNUM < 2;


                --out_rec := out_rec || '| After dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN

                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';
            --}
            END;
            --out_rec :=out_rec|| ' before lv_nrml_outstanding_int_cr insert'|| lv_acid;
            -------------------------------------------------------------

               -- C_EIT insert

               -------------------------------------------------------------
               BEGIN
              --{
              INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                   VALUES (lv_prevdate, lv_bacid, lv_glacc,
                       lv_appltranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       'D', lv_intrate,
                       'A', lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       0,
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       0,
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       abs(lv_nrml_outstanding_int_cr),
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id
                      );

              COMMIT;


               EXCEPTION
              WHEN OTHERS
              THEN

                 out_rec := out_rec || 'Insert uncusscessful';

               --}
              END;


               --}
               END IF;


        IF(lv_nrml_outstanding_int_cr>0)
        THEN
        --{
            lv_nrml_outstanding_pandl_cr:=lv_tran_amt_int_adm-lv_nrml_outstanding_int_cr-lv_overdue_idt-(lv_appl_amt_today_cr+lv_applamtdr_ovdu);
        --}
        ELSE
        --{
            lv_nrml_outstanding_pandl_cr:=lv_tran_amt_int_adm-lv_overdue_idt-(lv_appl_amt_today_cr + lv_applamtdr_ovdu);
        --}
        END IF;

        IF(lv_nrml_outstanding_pandl_cr>0)
        THEN
        --{
            BEGIN
            --{

                select tran_id
                into lv_appltranid
                FROM tbaadm.int_adm
                where acid=lv_acid
                and tran_date=lv_prevdate
                and record_type='I'
                and bank_id=lv_bankid
                and rownum<2;
            EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
            NULL;
            --}
            END;

            BEGIN
            --{
                  ----------------------------------------

                -- fetching tran details from dctd_acli

                ----------------------------------------

                   SELECT part_tran_srl_num, tran_particular, tran_amt,
                      tran_particular_2, tran_rmks, part_tran_type,
                      tran_crncy_code
                 INTO lv_ptransrlnum, lv_tranpart, lv_tranamt,
                      lv_tranpart2, lv_tranrmks, lv_ptrantype,
                      lv_trancrncy
                 FROM tbaadm.dctd_acli
                 WHERE tran_id = LPAD (lv_appltranid, 9)
                 AND ((tran_particular LIKE '%' || lv_foracid || '%' AND acid = lv_pandl_glacid)
                     OR (acid = lv_pandl_glacid))
                 AND tran_date = lv_prevdate
                 AND pstd_flg = 'Y'
                 AND del_flg != 'Y'
                 AND bank_id = lv_bankid
                 AND ROWNUM < 2;


                --out_rec := out_rec || '| After dctd_acli query 1|';
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN

                   lv_ptransrlnum:='';
                   lv_tranpart:='';
                   lv_tranamt:='';
                   lv_tranpart2:='';
                   lv_tranrmks:='';
                   lv_ptrantype:='';
                   lv_trancrncy:='';
            --}
            END;
            --out_rec :=out_rec|| ' before lv_nrml_outstanding_pandl_cr insert'|| lv_acid;
            -------------------------------------------------------------

               -- C_EIT insert

               -------------------------------------------------------------
               BEGIN
              --{
              INSERT INTO c_eit
                      (tran_date, bacid, gl_acct_no,
                       tran_id, part_tran_srl_num,
                       tran_amt,
                       tran_crncy,
                       part_tran_type,
                       tran_particular,
                       tran_particular_2,
                       tran_remarks, customer_account_no, sol_id,
                       schm_type, schm_code, eod_closing_balance,
                       eod_un_clr_bal_amt, eod_future_bal_amt,
                       eod_lien_amt, gl_sub_head_code,
                       int_coll_flag, int_paid_flag,
                       debit_credit_ind, interest_rate,
                       int_appl_flg, accrued_upto_date,
                       accrued_upto_amount,
                       accrued_amount_today,
                       booked_upto_date,
                       booked_upto_amount,
                       booked_amount_today,
                       applied_upto_date,
                       applied_upto_amount,
                       applied_amount_today,
                       SEGMENT, sub_segment, free_code_7,
                       rcre_user_id, rcre_time, lchg_user_id,
                       lchg_time, bank_id,unq_identifier
                      )
                   VALUES (lv_prevdate, lv_pandl_bacid, lv_pandl_glacc,
                       lv_appltranid, lv_ptransrlnum,
                       lv_tranamt,
                       lv_trancrncy,
                       lv_ptrantype,
                       lv_tranpart,
                       lv_tranpart2,
                       lv_tranrmks, lv_foracid, lv_solid,
                       lv_schm_type, lv_schm_code, lv_eodbal,
                       lv_unclrbalamt, lv_futbalamt,
                       lv_lienamt, lv_glsub,
                       lv_intcollflg, lv_intpdflg,
                       'D', lv_intrate,
                       'A', lv_accruptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_accr_upto_amt_cr,
                           lv_accr_upto_amt_dr
                          ),
                       0,
                       lv_bkduptodt,
                       DECODE (lv_crdrflg,
                           'C', lv_bkd_upto_amt_cr,
                           lv_bkd_upto_amt_dr
                          ),
                       0,
                       lv_appltrandt,
                       DECODE (lv_crdrflg,
                           'C', lv_appl_upto_amt_cr,
                           lv_appl_upto_amt_dr
                          ),
                       abs(lv_nrml_outstanding_pandl_cr),
                       lv_segment, lv_subsegment, lv_freecode7,
                       lv_rcreuserid, lv_rcretime, lv_lchguserid,
                       lv_lchgtime, lv_bankid,lv_unique_id
                      );

              COMMIT;


               EXCEPTION
              WHEN OTHERS
              THEN

                 out_rec := out_rec || 'Insert uncusscessful';

               --}
              END;
        --}
        END IF;


       --}
       END IF;


         --Cursor c_eit_backup end
     <<nextrec>>

      DBMS_OUTPUT.put_line ('outside loop');


      --}
      END IF;

   -------------------------------------------------------------

   -- Procedure end

   -------------------------------------------------------------

   --}
   END c_eit_fetch_proc;

-------------------------------------------------------------

-- Package end

-------------------------------------------------------------

--}
END c_eit_fetch_pack;
/
CREATE OR REPLACE SYNONYM tbaadm.c_eit_fetch_pack FOR custom.c_eit_fetch_pack
/
CREATE OR REPLACE SYNONYM tbagen.c_eit_fetch_pack FOR custom.c_eit_fetch_pack
/
CREATE OR REPLACE SYNONYM tbautil.c_eit_fetch_pack FOR custom.c_eit_fetch_pack
/
GRANT EXECUTE ON custom.c_eit_fetch_pack TO tbagen,tbautil,tbaadm
/

