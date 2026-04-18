DROP PACKAGE CUSTOM.INTRPT_REPORT_PACK;

CREATE OR REPLACE PACKAGE CUSTOM.intrpt_report_pack
AS
   PROCEDURE intrpt_report_proc (
      inp_str       IN       VARCHAR2,
      out_retcode   OUT      NUMBER,
      out_rec       OUT      VARCHAR2
   );
END intrpt_report_pack;
/

DROP PACKAGE BODY CUSTOM.INTRPT_REPORT_PACK;

CREATE OR REPLACE PACKAGE BODY CUSTOM.intrpt_report_pack
AS
   gv_reporttype   VARCHAR2 (50);
   gv_solsetid     tbaadm.sst.set_id%TYPE;
   gv_acctnum      VARCHAR2 (50);
   gv_prod         VARCHAR2 (50);
   gv_fromdate     DATE;
   gv_todate       DATE;
   gv_bank_id      tbaadm.gam.bank_id%TYPE;
   gv_boddate      DATE;
   gv_outarr       tbaadm.basp0099.arraytype;

-------------------------------------------------------------
--Cursor
-------------------------------------------------------------
   CURSOR intrpt_report_cur (
      iv_bacid          custom.c_eit.bacid%TYPE,
      iv_setid          tbaadm.sst.set_id%TYPE,
      iv_bankid         custom.c_eit.bank_id%TYPE,
      iv_trancrncy      custom.c_eit.tran_crncy%TYPE,
      iv_fromtrandate   custom.c_eit.tran_date%TYPE,
      iv_totrandate     custom.c_eit.tran_date%TYPE,
      iv_glacctno       custom.c_eit.gl_acct_no%TYPE,
      iv_tranid         custom.c_eit.tran_id%TYPE,
      iv_trandate       custom.c_eit.tran_date%TYPE
   )
   IS
      SELECT tran_date, bacid, gl_acct_no, tran_id, part_tran_srl_num,
             tran_amt, tran_crncy, part_tran_type, tran_particular,
             tran_particular_2, tran_remarks, customer_account_no, sol_id,
             schm_type, schm_code, eod_closing_balance, eod_un_clr_bal_amt,
             eod_future_bal_amt, eod_lien_amt, gl_sub_head_code,
             int_coll_flag, int_paid_flag, debit_credit_ind, interest_rate,
             DECODE (int_appl_flg,
                     'B', 'BOOKING',
                     'A', 'APPLICATION',
                     'T', 'TRANSFER'
                    ),
             accrued_upto_date, accrued_upto_amount, accrued_amount_today,
             booked_upto_date, booked_upto_amount, booked_amount_today,
             applied_upto_date, applied_upto_amount, applied_amount_today,
             SEGMENT, sub_segment, free_code_7
        FROM c_eit
       WHERE bank_id = iv_bankid
         AND int_appl_flg != 'X'
         AND (   (    bacid = iv_bacid
                  AND sol_id IN (
                         SELECT sol_id
                           FROM tbaadm.sst
                          WHERE set_id =
                                        DECODE (iv_setid,
                                                '', 'ALL',
                                                iv_setid
                                               )
                            AND bank_id = iv_bankid)
                  AND tran_crncy =
                           DECODE (iv_trancrncy,
                                   '', tran_crncy,
                                   iv_trancrncy
                                  )
                  AND tran_date >=
                         DECODE (iv_fromtrandate,
                                 '', tran_date,
                                 iv_fromtrandate
                                )
                  AND tran_date <=
                          DECODE (iv_totrandate,
                                  '', tran_date,
                                  iv_totrandate
                                 )
                 )
              OR (    gl_acct_no = iv_glacctno
                  AND tran_id = DECODE (iv_tranid, '', tran_id, iv_tranid)
                  AND tran_date =
                              DECODE (iv_trandate,
                                      '', tran_date,
                                      iv_trandate
                                     )
                 )
             );

-------------------------------------------------------------
-- Procedure begin
-------------------------------------------------------------
   PROCEDURE intrpt_report_proc (
      inp_str       IN       VARCHAR2,
      out_retcode   OUT      NUMBER,
      out_rec       OUT      VARCHAR2
   )
   AS
------------------------------------------------------------
-- DECLARE LOCAL VARIABLES  USED IN CURSOR AND PROCEDURE
------------------------------------------------------------
      lv_bacid                custom.c_eit.bacid%TYPE;
      lv_setid                tbaadm.sst.set_id%TYPE;
      lv_bankid               custom.c_eit.bank_id%TYPE;
      lv_fromtrandate         custom.c_eit.tran_date%TYPE;
      lv_totrandate           custom.c_eit.tran_date%TYPE;
      lv_trandate             custom.c_eit.tran_date%TYPE;
      lv_glacctno             custom.c_eit.gl_acct_no%TYPE;
      lv_tranid               custom.c_eit.tran_id%TYPE;
      lv_parttransrlnum       custom.c_eit.part_tran_srl_num%TYPE;
      lv_tranamt              custom.c_eit.tran_amt%TYPE;
      lv_trancrncy            custom.c_eit.tran_crncy%TYPE;
      lv_parttrantype         custom.c_eit.part_tran_type%TYPE;
      lv_tranparticular       custom.c_eit.tran_particular%TYPE;
      lv_tranparticular2      custom.c_eit.tran_particular_2%TYPE;
      lv_tranremarks          custom.c_eit.tran_remarks%TYPE;
      lv_customeraccountno    custom.c_eit.customer_account_no%TYPE;
      lv_solid                custom.c_eit.sol_id%TYPE;
      lv_schmtype             custom.c_eit.schm_type%TYPE;
      lv_schmcode             custom.c_eit.schm_code%TYPE;
      lv_eodclosingbalance    custom.c_eit.eod_closing_balance%TYPE;
      lv_eodunclrbalamt       custom.c_eit.eod_un_clr_bal_amt%TYPE;
      lv_eodfuturebalamt      custom.c_eit.eod_future_bal_amt%TYPE;
      lv_eodlienamt           custom.c_eit.eod_lien_amt%TYPE;
      lv_glsubheadcode        custom.c_eit.gl_sub_head_code%TYPE;
      lv_intcollflag          custom.c_eit.int_coll_flag%TYPE;
      lv_intpaidflag          custom.c_eit.int_paid_flag%TYPE;
      lv_debitcreditind       custom.c_eit.debit_credit_ind%TYPE;
      lv_interestrate         custom.c_eit.interest_rate%TYPE;
      lv_intapplflg           VARCHAR2 (20);
      lv_accrueduptodate      custom.c_eit.accrued_upto_date%TYPE;
      lv_accrueduptoamount    custom.c_eit.accrued_upto_amount%TYPE;
      lv_accruedamounttoday   custom.c_eit.accrued_amount_today%TYPE;
      lv_bookeduptodate       custom.c_eit.booked_upto_date%TYPE;
      lv_bookeduptoamount     custom.c_eit.booked_upto_amount%TYPE;
      lv_bookedamounttoday    custom.c_eit.booked_amount_today%TYPE;
      lv_applieduptodate      custom.c_eit.applied_upto_date%TYPE;
      lv_applieduptoamount    custom.c_eit.applied_upto_amount%TYPE;
      lv_appliedamounttoday   custom.c_eit.applied_amount_today%TYPE;
      lv_segment              custom.c_eit.SEGMENT%TYPE;
      lv_subsegment           custom.c_eit.sub_segment%TYPE;
      lv_freecode7            custom.c_eit.free_code_7%TYPE;
      lv_custaccname          tbaadm.gam.acct_name%TYPE;
      lv_glacctname           tbaadm.gam.acct_name%TYPE;
   BEGIN
      out_retcode := 0;
      out_rec := NULL;
      tbaadm.basp0099.forminputarr (inp_str, gv_outarr);
      lv_bacid := gv_outarr (0);
      lv_setid := gv_outarr (1);
      lv_bankid := gv_outarr (2);
      lv_trancrncy := gv_outarr (3);

      IF (TRIM (gv_outarr (4)) = '')
      THEN
         lv_fromtrandate := '';
      ELSE
         lv_fromtrandate := TO_DATE (gv_outarr (4), 'dd-mm-yyyy');
      END IF;

      IF (TRIM (gv_outarr (5)) = '')
      THEN
         lv_totrandate := '';
      ELSE
         lv_totrandate := TO_DATE (gv_outarr (5), 'dd-mm-yyyy');
      END IF;

      lv_glacctno := gv_outarr (6);

      IF (TRIM (gv_outarr (7)) = '')
      THEN
         lv_tranid := '';
      ELSE
         lv_tranid := LPAD (gv_outarr (7), 9);
      END IF;

      IF (TRIM (gv_outarr (8)) = '')
      THEN
         lv_trandate := '';
      ELSE
         lv_trandate := TO_DATE (gv_outarr (8), 'dd-mm-yyyy');
      END IF;

      IF (NOT intrpt_report_cur%ISOPEN)
      THEN
         OPEN intrpt_report_cur (lv_bacid,
                                 lv_setid,
                                 lv_bankid,
                                 lv_trancrncy,
                                 lv_fromtrandate,
                                 lv_totrandate,
                                 lv_glacctno,
                                 lv_tranid,
                                 lv_trandate
                                );
      END IF;

      IF (intrpt_report_cur%ISOPEN)
      THEN
         --DBMS_OUTPUT.put_line ('fetching now');
         FETCH intrpt_report_cur
          INTO lv_trandate, lv_bacid, lv_glacctno, lv_tranid,
               lv_parttransrlnum, lv_tranamt, lv_trancrncy, lv_parttrantype,
               lv_tranparticular, lv_tranparticular2, lv_tranremarks,
               lv_customeraccountno, lv_solid, lv_schmtype, lv_schmcode,
               lv_eodclosingbalance, lv_eodunclrbalamt, lv_eodfuturebalamt,
               lv_eodlienamt, lv_glsubheadcode, lv_intcollflag,
               lv_intpaidflag, lv_debitcreditind, lv_interestrate,
               lv_intapplflg, lv_accrueduptodate, lv_accrueduptoamount,
               lv_accruedamounttoday, lv_bookeduptodate, lv_bookeduptoamount,
               lv_bookedamounttoday, lv_applieduptodate,
               lv_applieduptoamount, lv_appliedamounttoday, lv_segment,
               lv_subsegment, lv_freecode7;

         IF (intrpt_report_cur%NOTFOUND)
         THEN
            CLOSE intrpt_report_cur;

            --DBMS_OUTPUT.put_line ('Closed');
            out_retcode := 1;
            RETURN;
         END IF;
      END IF;

      BEGIN
         SELECT acct_name
           INTO lv_glacctname
           FROM tbaadm.gam
          WHERE foracid = lv_glacctno AND bank_id = lv_bankid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            lv_glacctname := '';
      END;

      BEGIN
         SELECT acct_name
           INTO lv_custaccname
           FROM tbaadm.gam
          WHERE foracid = lv_customeraccountno AND bank_id = lv_bankid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            lv_custaccname := '';
      END;

      --concat the output line
      IF (out_retcode = 0)
      THEN
         out_rec :=
               lv_intapplflg
            || '|'
            || lv_bacid
            || '|'
            || TO_CHAR (lv_trandate, 'dd-mm-yyyy')
            || '|'
            || lv_glacctno
            || '|'
            || lv_glacctname
            || '|'
            || lv_tranid
            || '|'
            || lv_parttransrlnum
            || '|'
            || lv_parttrantype
            || '|'
            || lv_tranamt
            || '|'
            || lv_tranparticular
            || '|'
            || lv_tranparticular2
            || '|'
            || lv_tranremarks
            || '|'
            || lv_solid
            || '|'
            || lv_customeraccountno
            || '|'
            || lv_custaccname
            || '|'
            || TO_CHAR (lv_accrueduptodate, 'dd-mm-yyyy')
            || '|'
            || lv_accrueduptoamount
            || '|'
            || lv_accruedamounttoday
            || '|'
            || TO_CHAR (lv_bookeduptodate, 'dd-mm-yyyy')
            || '|'
            || lv_bookeduptoamount
            || '|'
            || lv_bookedamounttoday
            || '|'
            || TO_CHAR (lv_applieduptodate, 'dd-mm-yyyy')
            || '|'
            || lv_applieduptoamount
            || '|'
            || lv_appliedamounttoday
            || '|'
            || lv_schmtype
            || '|'
            || lv_schmcode
            || '|'
            || lv_interestrate
            || '|'
            || lv_eodclosingbalance
            || '|'
            || lv_eodunclrbalamt
            || '|'
            || lv_eodfuturebalamt
            || '|'
            || lv_eodlienamt
            || '|'
            || lv_glsubheadcode
            || '|'
            || lv_intcollflag
            || '|'
            || lv_intpaidflag
            || '|'
            || lv_debitcreditind;
      --DBMS_OUTPUT.put_line (out_rec);
      END IF;
-------------------------------------------------------------
-- Procedure end
-------------------------------------------------------------
   END intrpt_report_proc;
-------------------------------------------------------------
-- Package end
-------------------------------------------------------------
END intrpt_report_pack;
/


DROP SYNONYM TBAADM.INTRPT_REPORT_PACK;

CREATE SYNONYM TBAADM.INTRPT_REPORT_PACK FOR CUSTOM.INTRPT_REPORT_PACK;

DROP SYNONYM TBAGEN.INTRPT_REPORT_PACK;

CREATE SYNONYM TBAGEN.INTRPT_REPORT_PACK FOR CUSTOM.INTRPT_REPORT_PACK;

DROP SYNONYM TBAUTIL.INTRPT_REPORT_PACK;

CREATE SYNONYM TBAUTIL.INTRPT_REPORT_PACK FOR CUSTOM.INTRPT_REPORT_PACK;

GRANT EXECUTE ON CUSTOM.INTRPT_REPORT_PACK TO ALLTAB;

GRANT EXECUTE ON CUSTOM.INTRPT_REPORT_PACK TO TBAADM;

GRANT EXECUTE ON CUSTOM.INTRPT_REPORT_PACK TO TBAGEN;

GRANT EXECUTE ON CUSTOM.INTRPT_REPORT_PACK TO TBAUTIL;
