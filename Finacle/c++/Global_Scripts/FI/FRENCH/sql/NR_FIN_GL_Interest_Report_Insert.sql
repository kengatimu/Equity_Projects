/* Formatted on 2013/05/27 17:56 (Formatter Plus v4.8.8) */
-----------------------------------------------------------------------------------------------------
--  Name                        : FIN_GL_Interest_Report.sql
--  Date                        : 21-10-2012
--  Description                 : 
--  Author                      : Parikshith V
--  Modification History        :
-- <Serial No.>    <Date>       <Author Name>       <Description>
--     2.0       21-10-2012      Parikshith V     Initial draft
-----------------------------------------------------------------------------------------------------
set time on
set timing on
set echo off
set feedback on
set serveroutput on size 100000
Declare
-----------------------------------------------------------
--Cursor
-----------------------------------------------------------
   CURSOR gl_int_rep (
      iv_bank_id      tbaadm.gam.bank_id%TYPE,
      iv_coll_crncy   tbaadm.gam.acct_crncy_code%TYPE,
      iv_branch       tbaadm.gam.sol_id%TYPE,
      iv_todate       DATE
   )
   IS
	SELECT foracid foracid,g.acct_crncy_code acctcrncycode,
 g.acid custacid, g.sol_id solid, g.schm_type schmtype, g.schm_code schmcode,
		NVL (g.clr_bal_amt, 0) balance,
		TO_CHAR (e.accrued_upto_date_dr, 'dd-mm-yyyy') accruptodtdr ,
		NVL ((e.nrml_accrued_amount_dr + e.penal_accrued_amount_dr), 0) accrdramt ,
		TO_CHAR (e.booked_upto_date_dr, 'dd-mm-yyyy') bkduptodtdr ,
		NVL ((e.nrml_booked_amount_dr + e.penal_booked_amount_dr), 0) bkddramt ,
		TO_CHAR (e.interest_calc_upto_date_dr, 'dd-mm-yyyy') intcalcuptodtdr ,
		NVL (e.last_book_dr_tran_id, '-') traniddr ,
		NVL ((e.nrml_interest_amount_dr + e.penal_interest_amount_dr), 0) intamtdr ,
		TO_CHAR (e.accrued_upto_date_cr, 'dd-mm-yyyy') accruptodtcr ,
		NVL (e.nrml_accrued_amount_cr, 0) accrcramt ,
		TO_CHAR (e.booked_upto_date_cr, 'dd-mm-yyyy') bkduptodtcr ,
		NVL (e.nrml_booked_amount_cr, 0) bkdcramt ,
		TO_CHAR (e.interest_calc_upto_date_cr, 'dd-mm-yyyy') intcalcuptodtcr ,
		NVL (e.last_book_cr_tran_id, '-') tranidcr ,
		NVL (e.nrml_interest_amount_cr, 0) intamtcr, e.last_book_dr_tan_date lastbookdrtandt ,
		e.last_book_cr_tan_date lastbookcrtandt , e.interest_rate intrate , 
		g.int_coll_flg intcollflg,
		g.int_paid_flg intpaidflg, 
		nvl(b.nrml_booked_amount_dr,0) lastbkdamtdr ,
		nvl(b.nrml_booked_amount_cr,0) lastbkdamtcr ,
		(nvl(e.CUMM_DR_INT_ADJ_AMT,0) - nvl(b.CUMM_DR_INT_ADJ_AMT,0)) dr_adj_amt,
		(nvl(e.CUMM_CR_INT_ADJ_AMT,0) - nvl(b.CUMM_CR_INT_ADJ_AMT,0)) cr_adj_amt,
		(nvl(e.nrml_booked_amount_dr,0) - nvl(b.nrml_booked_amount_dr,0)) nrml_booked_amt_dr,
		(nvl(e.penal_booked_amount_dr,0) - nvl(b.penal_booked_amount_dr,0)) penal_booked_amt_dr,
		CASE g.schm_type
			WHEN 'TDA' THEN
				(nvl(e.nrml_booked_amount_cr,0) + nvl(e.ovdu_booked_amount_dr,0)- nvl(b.nrml_booked_amount_cr,0) - nvl(b.ovdu_booked_amount_dr,0))
                        WHEN 'TUA' THEN
				(nvl(e.nrml_booked_amount_cr,0) + nvl(e.ovdu_booked_amount_dr,0)- nvl(b.nrml_booked_amount_cr,0) - nvl(b.ovdu_booked_amount_dr,0))
                        ELSE
				(nvl(e.nrml_booked_amount_cr,0) - nvl(b.nrml_booked_amount_cr,0) )
                 END     nrml_booked_amt_cr 
	FROM tbaadm.gam g, custom.c_eit_hist e,custom.c_eit_hist b 
		WHERE g.schm_type in ('LAA','CLA')
		AND g.sol_id = iv_branch
		AND (g.acct_cls_flg != 'Y' OR ACCT_CLS_DATE >= iv_todate-1)
		AND g.bank_id = iv_bank_id
		AND e.entity_type(+) = 'ACCNT'
		AND e.entity_id(+) = g.acid
		AND e.bod_date(+)= iv_todate 
		AND e.bank_id(+) = g.bank_id
		AND b.entity_type(+)='ACCNT'
		AND b.entity_id(+)=g.acid
		AND b.bod_date(+)= iv_todate-1 
		AND b.bank_id(+)=g.bank_id;

----------------------------------------------------------
-- DECLARE LOCAL VARIABLES  USED IN CURSOR AND PROCEDURE
----------------------------------------------------------
	inp_str              VARCHAR2(500 char);
	outarr          tbaadm.basp0099.arraytype;
	iv_bank_id      tbaadm.gam.bank_id%TYPE;
	iv_coll_crncy   tbaadm.gam.acct_crncy_code%TYPE;
	iv_branch       tbaadm.gam.sol_id%TYPE;
	iv_todate       DATE;
	lv_foracid                        tbaadm.gam.foracid%TYPE;
	lv_acctcrncycode			  tbaadm.gam.acct_crncy_code%TYPE;
	lv_schmtype                     tbaadm.gam.schm_type%TYPE;
	lv_schmcode                     tbaadm.gam.schm_code%TYPE;
	lv_balance                      tbaadm.gam.clr_bal_amt%TYPE;
	lv_drintrate                    NUMBER (20, 4)                     := 0;
	lv_accruptodtdr                 VARCHAR2 (10);
	lv_accrdramt                    tbaadm.eit.nrml_accrued_amount_dr%TYPE;
	lv_bkduptodtdr                  VARCHAR2 (10);
	lv_bkddramt                     tbaadm.eit.nrml_booked_amount_dr%TYPE;
	lv_intcalcuptodtdr              VARCHAR2 (10);
	lv_traniddr                     tbaadm.eit.last_book_dr_tran_id%TYPE;
	lv_intamtdr                     tbaadm.eit.nrml_interest_amount_dr%TYPE;
	lv_rmksdr                       tbaadm.dtd.tran_particular%TYPE;
	lv_crintrate                    NUMBER (20, 4)                     := 0;
	lv_accruptodtcr                 VARCHAR2 (10);
	lv_accrcramt                    tbaadm.eit.nrml_accrued_amount_cr%TYPE;
	lv_bkduptodtcr                  VARCHAR2 (10);
	lv_bkdcramt                     tbaadm.eit.nrml_booked_amount_cr%TYPE;
	lv_intcalcuptodtcr              VARCHAR2 (10);
	lv_tranidcr                     tbaadm.eit.last_book_cr_tran_id%TYPE;
	lv_intamtcr                     tbaadm.eit.nrml_interest_amount_cr%TYPE;
	lv_rmkscr                       tbaadm.dtd.tran_particular%TYPE;
	lv_solid                        tbaadm.gam.sol_id%TYPE;
	lv_lastbookdrtandt              tbaadm.eit.last_book_dr_tan_date%TYPE;
	lv_lastbookcrtandt              tbaadm.eit.last_book_cr_tan_date%TYPE;
	lv_intrate                      NUMBER (20, 4)                     := 0;
	lv_intpaidflg                   CHAR (1);
	lv_intcollflg                   CHAR (1);
	lv_lastbkdamtdr                 tbaadm.eit.last_nrml_booked_amount_dr%TYPE;
	lv_lastbkdamtcr                 tbaadm.eit.last_nrml_booked_amount_cr%TYPE;
	lv_custacid                     tbaadm.gam.acid%TYPE;
	lv_int_susp_amt                 tbaadm.cot.int_suspense_amt%TYPE;
	lv_pen_int_susp_amt             tbaadm.cot.penal_int_suspense_amt%TYPE;
	lv_pandl_bacid_dr               tbaadm.gsp.int_pandl_bacid_dr%TYPE;
	lv_pandl_bacid_cr               tbaadm.gsp.int_pandl_bacid_cr%TYPE;
	lv_intIncAcct			tbaadm.gam.foracid%TYPE;
	lv_intExpAcct			tbaadm.gam.foracid%TYPE;
	lv_penal_int_susp_bacid         tbaadm.aip.penal_int_susp_bacid%TYPE;
	lv_dpdcntr                      tbaadm.gac.dpd_cntr%TYPE;
	lv_pdxferdt                     VARCHAR2 (10);
	lv_re_pdxferdt                     VARCHAR2 (10);
	lv_pdflg                        tbaadm.gac.pd_flg%TYPE;
	lv_mainclassuser                tbaadm.acd.main_classification_user%TYPE;
	lv_subclassuser                 tbaadm.acd.sub_classification_user%TYPE;
	lv_nrml_booked_amt_dr           NUMBER (20, 4);
	lv_penal_booked_amt_dr          NUMBER (20, 4);
	lv_nrml_booked_amt_cr           NUMBER (20, 4);
	lv_nrml_susp_diff		NUMBER (20, 4);
	lv_penal_susp_diff		NUMBER (20, 4);
	lv_bonus_intrst_bookd_tran_id   VARCHAR2 (20);
	lv_bs_intrst_bokd_tdate         tbaadm.eit.last_book_dr_tan_date%TYPE;
	lv_bonus_intrst_bookd_amnt      NUMBER (20, 4);
	lv_temp_amt	                tbaadm.gam.clr_bal_amt%type;
	lv_date_non_accrue		tbaadm.cot.date_non_accrue%type;
	lv_deposit_status		tbaadm.tam.deposit_status%type;
	lv_INT_RECV_BACID               tbaadm.aph.bacid%type;
	lv_INT_RECV_DIFF                NUMBER(20,4);
	lv_INT_PAY_BACID                tbaadm.aph.bacid%type;
	lv_INT_PAY_DIFF                 NUMBER(20,4);
	lv_int_tran_amt_dr		NUMBER(20,4);
	lv_int_tran_amt_cr		NUMBER(20,4);
	lv_pdcoll_int_amt                tbaadm.gam.clr_bal_amt%type;
	lv_pdcoll_penal_int_amt                tbaadm.gam.clr_bal_amt%type;
	lv_chrg_off_flg			tbaadm.la_coht.chrgoff_flg%type;
	lv_dr_adj_amt			tbaadm.eit.CUMM_DR_INT_ADJ_AMT%type;
	lv_cr_adj_amt			tbaadm.eit.CUMM_CR_INT_ADJ_AMT%type;
	iv_rec_count 			NUMBER;

   BEGIN
      tbaadm.basp0099.forminputarr ('&1', outarr);
      iv_bank_id := TRIM (NVL (outarr (0), '54'));
      iv_coll_crncy := TRIM (NVL (outarr (1), 'KES'));
      iv_branch := TRIM (NVL (outarr (2), '000'));
      iv_todate := TO_DATE (outarr (3), 'dd-mm-yyyy');
      --DBMS_OUTPUT.put_line (iv_bank_id);
      --DBMS_OUTPUT.put_line (iv_coll_crncy);
--      iv_bank_id := 'NA';
--      iv_coll_crncy := 'NAD';
--      iv_branch := 'ALL';
--      iv_todate := TO_DATE ('03-11-2013', 'dd-mm-yyyy');
	iv_rec_count := 0;

      for rec in gl_int_rep (iv_bank_id, iv_coll_crncy, iv_branch, iv_todate) loop
      --{

		lv_foracid				:= rec.foracid;
		lv_acctcrncycode			:= rec.acctcrncycode;
		lv_custacid				:= rec.custacid;
		lv_solid				:= rec.solid;
		lv_schmtype				:= rec.schmtype;
		lv_schmcode				:= rec.schmcode;
		lv_balance				:= rec.balance;
		lv_accruptodtdr				:= rec.accruptodtdr;
		lv_accrdramt				:= rec.accrdramt;
		lv_bkduptodtdr				:= rec.bkduptodtdr;
		lv_bkddramt				:= rec.bkddramt;
		lv_intcalcuptodtdr			:= rec.intcalcuptodtdr;
		lv_traniddr				:= rec.traniddr;
		lv_intamtdr				:= rec.intamtdr;
		lv_accruptodtcr				:= rec.accruptodtcr;
		lv_accrcramt				:= rec.accrcramt;
		lv_bkduptodtcr				:= rec.bkduptodtcr;
		lv_bkdcramt				:= rec.bkdcramt;
		lv_intcalcuptodtcr			:= rec.intcalcuptodtcr;
		lv_tranidcr				:= rec.tranidcr;
		lv_intamtcr				:= rec.intamtcr;
		lv_lastbookdrtandt			:= rec.lastbookdrtandt;
		lv_lastbookcrtandt			:= rec.lastbookcrtandt;
		lv_intrate				:= rec.intrate;
		lv_intcollflg				:= rec.intcollflg;
		lv_intpaidflg				:= rec.intpaidflg;
		lv_lastbkdamtdr				:= rec.lastbkdamtdr;
		lv_lastbkdamtcr				:= rec.lastbkdamtcr;
		lv_dr_adj_amt				:= rec.dr_adj_amt;
		lv_cr_adj_amt				:= rec.cr_adj_amt;
		lv_nrml_booked_amt_dr			:= rec.nrml_booked_amt_dr;
		lv_penal_booked_amt_dr			:= rec.penal_booked_amt_dr;
		lv_nrml_booked_amt_cr			:= rec.nrml_booked_amt_cr;


	--For handling IAR entries
	lv_nrml_booked_amt_dr := nvl(lv_nrml_booked_amt_dr,0) + nvl(lv_dr_adj_amt,0);
	lv_nrml_booked_amt_cr := nvl(lv_nrml_booked_amt_cr,0) + nvl(lv_cr_adj_amt,0);


         -- DBMS_OUTPUT.put_line (lv_intcollflg);
         IF (lv_intcollflg = 'Y')
         THEN
            lv_drintrate := lv_intrate;
         END IF;

         IF (lv_intpaidflg = 'Y')
         THEN
            lv_crintrate := lv_intrate;
         END IF;
	lv_rmksdr := ' ';
	lv_rmkscr := ' ';

      BEGIN
         SELECT int_pandl_bacid_dr, int_pandl_bacid_cr,int_coll_bacid,int_paid_bacid
           INTO lv_pandl_bacid_dr, lv_pandl_bacid_cr,lv_INT_RECV_bacid,lv_INT_PAY_bacid
           FROM tbaadm.gsp
          WHERE schm_type = lv_schmtype
            AND schm_code = lv_schmcode
            AND bank_id = iv_bank_id;
      EXCEPTION
         WHEN OTHERS
         THEN
            lv_pandl_bacid_dr := ' ';
            lv_pandl_bacid_cr := ' ';
	    lv_int_recv_bacid := '';
	    lv_int_pay_bacid  := '';
      END;

      BEGIN
         SELECT foracid
           INTO lv_intIncAcct
           FROM tbaadm.gam
          WHERE sol_id = lv_solid 
            AND acct_crncy_code = lv_acctcrncycode 
	    AND bacid =  lv_pandl_bacid_dr
            AND bank_id = iv_bank_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            lv_intIncAcct := ' ';
      END;

      BEGIN
         SELECT foracid
           INTO lv_intExpAcct
           FROM tbaadm.gam
          WHERE sol_id = lv_solid 
            AND acct_crncy_code = lv_acctcrncycode 
	    AND bacid = lv_pandl_bacid_cr 
            AND bank_id = iv_bank_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            lv_intExpAcct := ' ';
	END;

	if(lv_schmtype not in ('TDA','TUA')) then
	--{
		if(lv_schmtype in ('CLA','LAA')) then
			begin
				select 'Y' into lv_chrg_off_flg 
				from tbaadm.cot
				where bank_id=iv_bank_id
				and acid=lv_custacid
				and chrge_off_date=iv_todate-1;
			exception
				when others then
				lv_chrg_off_flg := 'N';	
			end;
		else
			begin
				select 'Y' into lv_chrg_off_flg 
				from tbaadm.ta_cot
				where bank_id=iv_bank_id
				and acid=lv_custacid
				and chrge_off_date=iv_todate-1;

			exception
				when others then
				lv_chrg_off_flg := 'N';	
			end;
		end if;

		if(lv_chrg_off_flg = 'Y') then
		--{
				BEGIN
					SELECT p.int_susp_bacid, d.main_classification_user,
					d.sub_classification_user
					INTO lv_penal_int_susp_bacid, lv_mainclassuser,
					lv_subclassuser
					FROM tbaadm.aip p, tbaadm.gam g,tbaadm.acd d
					WHERE d.b2k_type = 'ACCNT'
					AND d.b2k_id = lv_custacid
					AND d.bank_id = iv_bank_id
					AND g.acid = d.b2k_id
					AND g.bank_id = d.bank_id
					AND p.b2k_type = d.b2k_type
					AND p.schm_code = g.schm_code
					AND p.bank_id = d.bank_id
					and p.int_susp_bacid is NOT NULL
					and rownum =1;
				EXCEPTION
					WHEN OTHERS THEN
						lv_penal_int_susp_bacid := ' ';
						lv_mainclassuser := ' ';
						lv_subclassuser := ' ';
				END;

			Begin
				select nrml_int_suspense_amt_dr,penal_int_suspense_amt_dr
				into lv_nrml_susp_diff,lv_penal_susp_diff
				from custom.c_eit_hist
				where entity_type='ACCNT'
				and entity_id=lv_custacid
				and bod_date=iv_todate-1
				and bank_id=iv_bank_id;

			exception
				when others then
					lv_nrml_susp_diff := 0;
					lv_penal_susp_diff := 0;	
			end;
			lv_INT_RECV_DIFF := nvl(lv_bkddramt,0) - nvl(lv_intamtdr,0) ;
			lv_nrml_susp_diff := nvl(lv_nrml_susp_diff,0) * (-1);
			lv_penal_susp_diff := nvl(lv_penal_susp_diff,0) * (-1);
			lv_nrml_booked_amt_dr := 0;
			lv_penal_booked_amt_dr := 0;

		--}
		else
		--{
			-- Added for FCR01674
			BEGIN
				SELECT dpd_cntr, TO_CHAR (pd_xfer_date, 'dd-mm-yyyy'), pd_flg,to_char(pd_re_xfer_date,'dd-mm-yyyy')
				INTO lv_dpdcntr, lv_pdxferdt, lv_pdflg,lv_re_pdxferdt
				FROM tbaadm.gac
				WHERE acid = lv_custacid AND bank_id = iv_bank_id;
			EXCEPTION
			WHEN OTHERS THEN
				lv_dpdcntr := 0;
				lv_pdxferdt := '';
				lv_pdflg := 'N';
			END;

			if(lv_pdflg = 'Y') then
			--{
				if( lv_schmtype in ('CLA','LAA') ) then
					BEGIN
						SELECT NVL (int_suspense_amt, 0), NVL (penal_int_suspense_amt, 0),date_non_accrue
						INTO lv_int_susp_amt, lv_pen_int_susp_amt,lv_date_non_accrue
						FROM tbaadm.cot
						WHERE acid = lv_custacid AND bank_id = iv_bank_id;
					EXCEPTION
						WHEN OTHERS THEN
							lv_int_susp_amt := 0;
							lv_pen_int_susp_amt := 0;
					END;
				else
					BEGIN
						SELECT NVL (int_suspense_amt, 0), NVL (penal_int_suspense_amt, 0),date_non_accrue
						INTO lv_int_susp_amt, lv_pen_int_susp_amt,lv_date_non_accrue
						FROM tbaadm.ta_cot
						WHERE acid = lv_custacid AND bank_id = iv_bank_id;
					EXCEPTION
						WHEN OTHERS THEN
							lv_int_susp_amt := 0;
							lv_pen_int_susp_amt := 0;
					END;
				end if;


				BEGIN
					SELECT p.int_susp_bacid, d.main_classification_user,
					d.sub_classification_user
					INTO lv_penal_int_susp_bacid, lv_mainclassuser,
					lv_subclassuser
					FROM tbaadm.aip p, tbaadm.gam g,tbaadm.acd d
					WHERE d.b2k_type = 'ACCNT'
					AND d.b2k_id = lv_custacid
					AND d.bank_id = iv_bank_id
					AND g.acid = d.b2k_id
					AND g.bank_id = d.bank_id
					AND p.b2k_type = d.b2k_type
					AND p.schm_code = g.schm_code
					AND p.bank_id = d.bank_id
					and p.int_susp_bacid is NOT NULL
					and rownum =1;
				EXCEPTION
					WHEN OTHERS THEN
						lv_penal_int_susp_bacid := ' ';
						lv_mainclassuser := ' ';
						lv_subclassuser := ' ';
				END;


				if(lv_date_non_accrue = (iv_todate-1)) then
				--{
					lv_nrml_susp_diff  := lv_int_susp_amt;
					lv_penal_susp_diff := lv_pen_int_susp_amt;
					lv_nrml_booked_amt_dr := (lv_int_susp_amt - lv_nrml_booked_amt_dr)*-1 ;
					lv_penal_booked_amt_dr := (lv_pen_int_susp_amt - lv_penal_booked_amt_dr)*-1 ;
				--}
				else
				--{
					if( lv_schmtype in ('CLA','LAA') ) then
					--{
						BEGIN
							select  nvl(sum((interest_amt-penal_interest_amt)),0),nvl(sum(penal_interest_amt),0)
							into lv_pdcoll_int_amt,lv_pdcoll_penal_int_amt
							from tbaadm.ltd,tbaadm.lsp
							where lsp.bank_id=iv_bank_id
							and lsp.schm_code=lv_schmcode
							and lsp.crncy_code=lv_acctcrncycode
							and ltd.bank_id=iv_bank_id
							and ltd.acid=lv_custacid
							and ltd.tran_date=iv_todate-1
							and ltd.flow_id=lsp.pastdue_coll_flow_id
							and ltd.reversal_flg!='Y'
							and ltd.reversed_flg!='Y';
								
						EXCEPTION
							WHEN OTHERS THEN
								lv_pdcoll_int_amt := 0;
								lv_pdcoll_penal_int_amt := 0;
						END;
						lv_nrml_susp_diff  := nvl(lv_nrml_booked_amt_dr,0)-nvl(lv_pdcoll_int_amt,0);
						lv_penal_susp_diff := nvl(lv_penal_booked_amt_dr,0)-nvl(lv_pdcoll_penal_int_amt,0);
						lv_nrml_booked_amt_dr := nvl(lv_pdcoll_int_amt,0);
						lv_penal_booked_amt_dr := nvl(lv_pdcoll_penal_int_amt,0);
					--}
					else
					--{
						lv_nrml_susp_diff  := lv_nrml_booked_amt_dr;
						lv_penal_susp_diff := lv_penal_booked_amt_dr;
						lv_nrml_booked_amt_dr := 0;
						lv_penal_booked_amt_dr := 0;
					--}
					end if;
				--}
				end if;
			--}
			end if;
			if( (lv_pdflg = 'N')  and  (nvl(lv_re_pdxferdt,'31-12-2099') = to_char((iv_todate-1),'dd-mm-yyyy'))  ) then
			--{
				BEGIN
					SELECT p.int_susp_bacid, d.main_classification_user,
					d.sub_classification_user
					INTO lv_penal_int_susp_bacid, lv_mainclassuser,
					lv_subclassuser
					FROM tbaadm.aip p, tbaadm.gam g,tbaadm.acd d
					WHERE d.b2k_type = 'ACCNT'
					AND d.b2k_id = lv_custacid
					AND d.bank_id = iv_bank_id
					AND g.acid = d.b2k_id
					AND g.bank_id = d.bank_id
					AND p.b2k_type = d.b2k_type
					AND p.schm_code = g.schm_code
					AND p.bank_id = d.bank_id
					and p.int_susp_bacid is NOT NULL
					and rownum =1;
				EXCEPTION
					WHEN OTHERS THEN
						lv_penal_int_susp_bacid := ' ';
						lv_mainclassuser := ' ';
						lv_subclassuser := ' ';
				END;

				Begin
					select nrml_int_suspense_amt_dr,penal_int_suspense_amt_dr
					into lv_nrml_susp_diff,lv_penal_susp_diff
					from custom.c_eit_hist
					where entity_type='ACCNT'
					and entity_id=lv_custacid
					and bod_date=iv_todate-1
					and bank_id=iv_bank_id;
				
					lv_nrml_booked_amt_dr := nvl(lv_nrml_booked_amt_dr,0) + nvl(lv_nrml_susp_diff,0);
					lv_penal_booked_amt_dr := nvl(lv_penal_booked_amt_dr,0) + nvl(lv_penal_susp_diff,0);
					lv_nrml_susp_diff := nvl(lv_nrml_susp_diff,0) * (-1);
					lv_penal_susp_diff := nvl(lv_penal_susp_diff,0) * (-1);

				exception
					when others then
						lv_nrml_susp_diff := 0;
						lv_penal_susp_diff := 0;	


				end;
			--}
			end if;
		--}
		end if;

	--}
	else
	--{
		lv_nrml_susp_diff :=0;
		lv_penal_susp_diff :=0;
		lv_penal_int_susp_bacid := ' ';
		lv_mainclassuser := ' ';
		lv_int_susp_amt := 0;
		lv_pen_int_susp_amt := 0;
		lv_dpdcntr := 0;
		lv_pdxferdt := '';
		lv_pdflg := ' ';
	--}
	end if;


	if(lv_schmtype in ('TDA','TUA')) then
	--{

		begin
			select deposit_status into lv_deposit_status 
			from tbaadm.tam
			where bank_id=iv_bank_id
			and acid=lv_custacid;
		exception
			when others then
				lv_deposit_status := ' ';


		end;

		if( (lv_deposit_status = 'R')  OR (lv_deposit_status = 'A') )then
			begin
				select renewal_amount into lv_temp_amt
				from tbaadm.reno
				where reno.bank_id=iv_bank_id
				and reno.acid=lv_custacid
				and reno.renewal_bod=iv_todate-1;

				lv_nrml_booked_amt_cr := nvl(lv_bkdcramt,0); 
				lv_temp_amt := 0;

			exception
				WHEN OTHERS THEN
					NULL;
			end;
		end if;



		BEGIN
			SELECT NVL (tran_id, '-'), tran_date,
			NVL (bonus_bkd_amt, '0')
			INTO lv_bonus_intrst_bookd_tran_id, lv_bs_intrst_bokd_tdate,
			lv_bonus_intrst_bookd_amnt
			FROM custom.c_bib
			WHERE 1 = 1
			AND acid = lv_custacid
			AND bank_id = iv_bank_id
			AND tran_date = iv_todate -1
			AND ROWNUM = 1;
		EXCEPTION
			WHEN OTHERS THEN
				lv_bonus_intrst_bookd_tran_id := '';
				lv_bs_intrst_bokd_tdate := '';
				lv_bonus_intrst_bookd_amnt := 0;
		END;
		BEGIN
			select nvl(sum(bonus_bkd_amt),0)
			into lv_temp_amt
			from custom.c_bib
			where acid=lv_custacid
			and bank_id = iv_bank_id
			and rev_tran_date = iv_todate -1
			and status_flg = 'R';
		EXCEPTION
			WHEN OTHERS THEN
				lv_temp_amt := 0;
		END;
		lv_bonus_intrst_bookd_amnt := lv_bonus_intrst_bookd_amnt - lv_temp_amt;
		lv_temp_amt := 0;

	--}
	else
	--{
		lv_bonus_intrst_bookd_tran_id := '';
		lv_bs_intrst_bokd_tdate := '';
		lv_bonus_intrst_bookd_amnt := 0;

	--}
	end if;
	
--	Logic for Payable and Receivable
	if (lv_intcollflg = 'Y' and nvl(lv_chrg_off_flg,'N')!='Y') then
		begin
			select nvl(sum(decode(cr_or_dr_amt_ind,'D',base_amount,-base_amount)),0)
--			select nvl(sum(base_amount),0)
			into lv_int_tran_amt_dr
			from tbaadm.int_adm
			where acid= lv_custacid
			and bank_id= iv_bank_id
			and entity_cre_flg='Y'
			and del_flg!='Y'
			and record_type='I'
			and interest_run_ind='D'
			and tran_date=iv_todate -1;
		exception
			when others then
				lv_int_tran_amt_dr := 0;
		end;
		lv_INT_RECV_DIFF := nvl(lv_int_tran_amt_dr,0) - nvl(lv_nrml_booked_amt_dr,0) - nvl(lv_penal_booked_amt_dr,0) - nvl(lv_nrml_susp_diff,0) - nvl(lv_penal_susp_diff,0) ;--+ nvl(lv_dr_adj_amt,0);
	end if;
	if (lv_intpaidflg = 'Y') then
		begin
			select nvl(sum(decode(cr_or_dr_amt_ind,'C',base_amount,-base_amount)),0)
--			select nvl(sum(base_amount),0)
			into lv_int_tran_amt_cr
			from tbaadm.int_adm
			where acid= lv_custacid
			and bank_id= iv_bank_id
			and entity_cre_flg='Y'
			and del_flg!='Y'
			and record_type='I'
			and interest_run_ind='C'
			and tran_date=iv_todate -1;
		exception
			when others then
				lv_int_tran_amt_cr := 0;
		end;
		lv_INT_PAY_DIFF  := nvl(lv_int_tran_amt_cr,0) - nvl(lv_nrml_booked_amt_cr,0) - nvl(lv_bonus_intrst_bookd_amnt,0);-- +  nvl(lv_cr_adj_amt,0);
	end if;


--		lv_foracid || '|' || lv_solid || '|' || lv_schmtype || '|' || lv_schmcode || '|' || NVL (lv_balance, 0) || '|' || NVL (lv_drintrate, 0) || '|' || NVL (lv_accruptodtdr, '  ') || '|' || NVL (lv_accrdramt, 0) || '|' || NVL (lv_bkduptodtdr, '  ') || '|' || NVL (lv_bkddramt, 0) || '|' || NVL (lv_intcalcuptodtdr, '  ') || '|' || NVL (lv_traniddr, '  ') || '|' || lv_lastbookdrtandt || '|' || NVL (lv_intamtdr, 0) || '|' || NVL (lv_rmksdr, '  ') || '|' || NVL (lv_crintrate, 0) || '|' || NVL (lv_accruptodtcr, '  ') || '|' || NVL (lv_accrcramt, 0) || '|' || NVL (lv_bkduptodtcr, '  ') || '|' || NVL (lv_bkdcramt, 0) || '|' || NVL (lv_intcalcuptodtcr, '  ') || '|' || NVL (lv_tranidcr, '  ') || '|' || lv_lastbookcrtandt || '|' || NVL (lv_intamtcr, 0) || '|' || NVL (lv_rmkscr, '  ') || '|' || NVL (lv_int_susp_amt, 0) || '|' || NVL (lv_pen_int_susp_amt, 0) || '|' || NVL (lv_pandl_bacid_dr, ' ') || '|' || NVL (lv_pandl_bacid_cr, ' ') || '|' || (case nvl(lv_penal_int_susp_bacid,'NULL') when  'NULL' then NULL when ' ' then ' ' else lv_solid||lv_acctcrncycode||NVL (lv_penal_int_susp_bacid, ' ') end ) || '|' || NVL (lv_dpdcntr, 0) || '|' || NVL (lv_pdxferdt, ' ') || '|' || NVL (lv_pdflg, ' ') || '|' || NVL (lv_mainclassuser, ' ') || '|' || NVL (lv_subclassuser, ' ') || '|' || NVL (lv_nrml_booked_amt_dr, 0) || '|' || NVL (lv_penal_booked_amt_dr, 0) || '|' || NVL (lv_nrml_susp_diff, 0) || '|' || NVL (lv_penal_susp_diff, 0) || '|' || NVL (lv_nrml_booked_amt_cr, 0) || '|' || NVL (lv_bonus_intrst_bookd_tran_id, '  ') || '|' || NVL (lv_bs_intrst_bokd_tdate, '') || '|' || NVL (lv_bonus_intrst_bookd_amnt, 0) || '|' || NVL (lv_pandl_bacid_cr, ' ') || '|' || lv_acctcrncycode || '|' || lv_intIncAcct || '|' || lv_intExpAcct || '|' ||	(case nvl(lv_INT_RECV_BACID,'NULL')  when  'NULL' then NULL when ' ' then NULL else lv_solid||lv_acctcrncycode||NVL (lv_INT_RECV_BACID, ' ') end ) || '|' ||	lv_INT_RECV_DIFF || '|' ||	(case nvl(lv_INT_PAY_BACID,'NULL')  when  'NULL' then NULL when ' ' then NULL else lv_solid||lv_acctcrncycode||NVL (lv_INT_PAY_BACID, ' ') end ) || '|' ||	lv_INT_PAY_DIFF ;





	BEGIN
		INSERT INTO CUSTOM.C_GLIR_EOD_HIST VALUES
		(
			iv_todate-1, lv_foracid ,lv_solid, lv_schmtype ,lv_schmcode,lv_acctcrncycode,lv_balance, lv_dpdcntr,to_date(lv_pdxferdt,'dd-mm-yyyy'),lv_pdflg,lv_mainclassuser,lv_subclassuser,
		lv_pandl_bacid_dr,lv_intIncAcct, 
		(case nvl(lv_INT_RECV_BACID,'NULL')  when  'NULL' then NULL when ' ' then NULL else lv_solid||lv_acctcrncycode||NVL (lv_INT_RECV_BACID, ' ') end ),
		(case nvl(lv_penal_int_susp_bacid,'NULL')  when  'NULL' then NULL when ' ' then NULL else lv_solid||lv_acctcrncycode||NVL (lv_penal_int_susp_bacid, ' ') end ), 
		lv_drintrate,to_date(lv_accruptodtdr,'dd-mm-yyyy'),lv_accrdramt,to_date(lv_bkduptodtdr,'dd-mm-yyyy'),lv_bkddramt,lv_lastbookdrtandt,lv_traniddr,to_date(lv_intcalcuptodtdr,'dd-mm-yyyy'),lv_intamtdr,lv_rmksdr,lv_nrml_booked_amt_dr,lv_penal_booked_amt_dr,lv_int_susp_amt,lv_pen_int_susp_amt,lv_nrml_susp_diff,lv_penal_susp_diff,lv_INT_RECV_DIFF,lv_dr_adj_amt,
		lv_pandl_bacid_cr,lv_intExpAcct,
		(case nvl(lv_INT_PAY_BACID,'NULL')  when  'NULL' then NULL when ' ' then NULL else lv_solid||lv_acctcrncycode||NVL (lv_INT_PAY_BACID, ' ') end ),
		lv_crintrate,to_date(lv_accruptodtcr,'dd-mm-yyyy'),lv_accrcramt,to_date(lv_bkduptodtcr,'dd-mm-yyyy'),lv_bkdcramt,lv_lastbookcrtandt,lv_tranidcr,to_date(lv_intcalcuptodtcr,'dd-mm-yyyy'),lv_intamtcr,lv_rmkscr,lv_nrml_booked_amt_cr,lv_bonus_intrst_bookd_tran_id,lv_bs_intrst_bokd_tdate,lv_bonus_intrst_bookd_amnt,lv_INT_PAY_DIFF, lv_cr_adj_amt,
		'SYSTEM',sysdate,'SYSTEM',sysdate,iv_bank_id
		);
	EXCEPTION
		WHEN OTHERS THEN
		dbms_output.put_line(iv_rec_count||'|'||lv_foracid||'|'||'ERROR'||'|'||SQLCODE||'|'||SQLERRM);
		NULL;
	END;

	iv_rec_count := iv_rec_count + 1;
	IF( iv_rec_count > 999) THEN
		COMMIT;
		dbms_output.put_line('Commiting');
		iv_rec_count := 0;

	END IF;
      --}
      END LOOP;
      COMMIT;
END;
/
