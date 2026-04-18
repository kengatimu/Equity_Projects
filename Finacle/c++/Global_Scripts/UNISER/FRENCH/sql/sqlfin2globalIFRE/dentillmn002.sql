REM*****************************************************************************
REM     Report Name             : VAULT POSITION INQUIRY.
REM     File Name               : dentillmn002.sql
REM     Bank			: STANDARD BANK
REM     Calling Script          : NIL.
REM     Packages Used           : NIL.
REM     Tables Used             : TBAADM.GEC,TBAADM.GAM,TBAADM.GET,TBAADM SST,TBAADM SOL,
REM                               CUSTOM.CUST_DENOM_MASTER.
REM
REM     Date                    : 25-JUL-2010
REM     Author                  : Sandeep Patil
REM     Input Parameters        : NIL.
REM
REM     Assumptions/Exception   : NIL.
REM     Modification History
REM              <Serial No.>  <Date>  <Author Name>  <Description>
REM***********************************************************************************

CREATE OR REPLACE PACKAGE custom.FIN_DENVAULT_PACK IS
-------------------------------------------------------------------------------
        PROCEDURE FIN_DENVAULT_PROC
        (       inp_str     IN  VARCHAR2,
                out_retcode OUT NUMBER,
                out_rec     OUT VARCHAR2
        );
-------------------------------------------------------------------------------
End FIN_DENVAULT_PACK;
/

CREATE OR REPLACE PACKAGE body custom.FIN_DENVAULT_PACK AS
----------------------------------------------------------------
-- Declaration of procedure variables
---------------------------------------------------------------
OutArr              TBAADM.basp0099.ArrayType;
lv_crncy_code       VARCHAR2(3Char);
ge_sol_id           VARCHAR2(8Char);
lv_emp_id           VARCHAR2(10Char) :='VAULT';
lv_emp_name			VARCHAR2(40Char) :='VAULT';
lv_acid				TBAADM.GAM.acid%type;
lv_acct_crncy_code	TBAADM.GAM.acct_crncy_code%type;
lv_clr_bal_amt		TBAADM.GAM.clr_bal_amt%type;
lv_clr_bal          TBAADM.GAM.clr_bal_amt%type;
gm_sol_id			TBAADM.GAM.sol_id%type;
lv_bank_id			TBAADM.GAM.bank_id%type;
lv_denom_value		CUSTOM.CUST_DENOM_MASTER.denom_value%type;
lv_teller_id		CUSTOM.CUST_DENOM_MASTER.teller_id%type;
lv_denom_count	    CUSTOM.CUST_DENOM_MASTER.denom_count%type;	
lc_sol_id			CUSTOM.CUST_DENOM_MASTER.sol_id%type;
lv_denom_ind		CUSTOM.CUST_DENOM_MASTER.denom_ind%type;
lv_abbr_br_name     TBAADM.SOL.abbr_br_name%type;
lv_set_id           TBAADM.SST.set_id%type;
rv_cnt				NUMBER := 0;
lv_sol_desc			TBAADM.sol.sol_desc%type;
lv_denom_calc		number := 0;
--lv_denom_calc_home		tbaadm.gam.clr_bal_amt%type :=0;
lv_denom_calc_home			number := 0;
lv_db_stat_date				tbaadm.gct.db_stat_date%TYPE;
lv_home_crncy_code			tbaadm.gct.home_crncy_code%TYPE;
lv_rep_rate_code			tbaadm.gct.report_rate_code%TYPE;
lv_convrate					VARCHAR2 (24);
lv_flg						varchar2(2);
lv_usdconv					number := 0;
--lv_usdconv				TBAADM.GAM.clr_bal_amt%type;
lv_currusdconv				VARCHAR2(3Char);
lv_curflg					varchar2(1);
lv_sol_id					TBAADM.GAM.sol_id%type;
lv_br_cash					number :=0;
lv_br_limit					number :=0;
lv_brn_limit				number :=0;
lv_acct_crn					tbaadm.gam.acct_crncy_code%type;
--tot_brn_cash				tbaadm.gam.clr_bal_amt%type;
tot_brn_cash				number:=0;
lv_flg1						number:=1;
lv_sum_clr_bal              tbaadm.gam.clr_bal_amt%type :=0;
------------------------------------------------------------------------------
------------------------------- START OF CURSOR INQUIRY ----------------------
------------------------------------------------------------------------------
CURSOR inquiry(lv_set_id varchar2,lv_crncy_code varchar2) IS
	SELECT  acid,
		acct_crncy_code,
		clr_bal_amt,
		sol_id,
		bank_id
        FROM
                tbaadm.gam a
        WHERE
		sol_id in ( SELECT sol_id
			FROM    tbaadm.SST
			WHERE   set_id =lv_set_id)
		        AND     a.acct_cls_flg = 'N'
			AND     a.entity_cre_flg = 'Y'
		AND     del_flg = 'N'
		AND     a.acct_crncy_code = decode(lv_crncy_code,'ALL',a.acct_crncy_code,lv_crncy_code)
		AND clr_bal_amt != '0'
		AND bacid in (select cash_bacid from tbaadm.gct );
			

------------------------------------------------------------------------------
------------------------------- START OF CURSOR DENOM ----------------------
------------------------------------------------------------------------------
CURSOR denom( ge_sol_id varchar2,lv_acct_crncy_code varchar2) IS
	SELECT CDM.denom_value,
		CDM.denom_ind,
		CDM.denom_count,
		(cdm.denom_count * cdm.denom_value)
	FROM CUSTOM.CUST_DENOM_MASTER CDM
	WHERE CDM.teller_id       =  'VAULT'
	AND	CDM.crncy_code = lv_acct_crncy_code
	AND	CDM.del_flg = 'N'
	AND	CDM.sol_id = ge_sol_id;
		
------------------------------------------------------------------------
------------------------------------ PROCEDURES ------------------------
------------------------------------------------------------------------

PROCEDURE FIN_DENVAULT_PROC
(       inp_str     IN  VARCHAR2,
        out_retcode OUT NUMBER,
        out_rec     OUT VARCHAR2
) AS
-------------------------------------------------------------------------
-------------------------------- FETCHING THE DATA   --------------------
-------------------------------------------------------------------------
BEGIN
tbaadm.basp0099.formInputArr(inp_str,outArr);
 		 lv_set_id   := outArr(0);
		  lv_sol_id:= outArr(1);
		  lv_crncy_code:= outArr(2);
		  lv_bank_id:= outArr(3);
			out_retcode :=0 ;  
	IF not INQUIRY%ISOPEN THEN
	--{
        		OPEN INQUIRY(lv_set_id,lv_crncy_code);
			lv_curflg := 'O';
	--}		
	END IF;
	

	IF(lv_curflg = 'O') THEN
		FETCH INQUIRY 
		INTO
			lv_acid,					
			lv_acct_crncy_code,
			lv_clr_bal_amt,
			ge_sol_id,
			lv_bank_id;
	dbms_output.put_line(lv_acct_crncy_code);

		begin
			select consol_vault_limit_in_hc into lv_brn_limit from tbaadm.sol where sol_id = ge_sol_id;
		exception
			when others then
				lv_brn_limit := null;
		end;	



	
------------------------------------------------------------------------------
------------------------------  CLOSE CURSOR INQUIRY1 ------------------------
------------------------------------------------------------------------------
		IF INQUIRY%NOTFOUND THEN
			IF INQUIRY%ROWCOUNT = 0 THEN
			gm_sol_id := lv_sol_id;
			BEGIN
				select 
					abbr_br_name,
					sol_desc
				into
					lv_abbr_br_name,
					lv_sol_desc
				from 	tbaadm.sol
				where
					sol_id = lv_sol_id;
			exception
				when others then
				lv_abbr_br_name := '';
				gm_sol_id  := '';
			END;
				rv_cnt := rv_cnt+1;
				lv_flg:= 'N';
				out_rec :=	--lv_emp_name			 ||'|'||
							lv_br_cash			 ||'|'||
							lv_acct_crncy_code		 ||'|'||
							lv_clr_bal_amt			 ||'|'||
							lv_denom_value			 ||'|'||
							lv_denom_ind			 ||'|'||
							lv_denom_count			 ||'|'||
							ge_sol_id				 ||'|'||
							--lv_emp_id				 ||'|'||
							lv_br_limit				 ||'|'||
							ge_sol_id				 ||'|'||
							lv_abbr_br_name		 	||'|'||
							lv_sol_desc				 ||'|'||
							lv_denom_calc_home	 	||'|'||
							lv_denom_calc			 ||'|'||
							lv_flg					 ||'|'||
							lv_home_crncy_code||'||';
							IF rv_cnt = 2 then
								out_retcode :=1;
							END IF;
							return;
			END IF;
				out_retcode := 1;
				CLOSE INQUIRY;
				RETURN;
		END IF;
	END IF;
------------------------------------------------------------------------------
------------------------------  FETCHING DENOM DETAILS  ------------------------
------------------------------------------------------------------------------

	IF not DENOM%ISOPEN THEN
	--{
          	 OPEN DENOM( ge_sol_id ,lv_acct_crncy_code);
		dbms_output.put_line('inside denom' ||tot_brn_cash);
	 	FETCH DENOM 
		INTO
		lv_denom_value,
		lv_denom_ind,
		lv_denom_count,
		lv_denom_calc
		;

------------------------------------------------------------------------------
------------------------------  CLOSE CURSOR DENOM ------------------------
------------------------------------------------------------------------------
		IF DENOM%NOTFOUND THEN
			IF DENOM%ROWCOUNT = 0 THEN
				lv_denom_value := 0;
				lv_denom_ind := NULL;
				lv_denom_count := 0;
				lv_denom_calc := 0;
				
			END IF;
			CLOSE DENOM;
			lv_curflg := 'O';
		ELSE
			lv_curflg := 'I';
		END IF;

	--}	
	END IF;



----------------------------------------------------------------------
-------------- To get the details from GCT table  --------------------
----------------------------------------------------------------------
            BEGIN
               SELECT db_stat_date, home_crncy_code, report_rate_code
               INTO lv_db_stat_date, lv_home_crncy_code, lv_rep_rate_code
               FROM tbaadm.gct
               WHERE bank_id = lv_bank_id AND del_flg = 'N';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  lv_db_stat_date := NULL;
                  lv_home_crncy_code := NULL;
                  lv_rep_rate_code := NULL;
            END;
	

------------------------------------------------------------------------
---------------------- To Get the amount in local currency -------------
-----------------------------------------------------------------------
                lv_convrate := STBCommonpackage.getconvrate
                        (lv_bank_id,
						lv_acct_crncy_code,
                        lv_home_crncy_code,
                        lv_rep_rate_code,
                        lv_db_stat_date);

                lv_denom_calc_home := lv_denom_calc * lv_convrate;

------------------------------------------------------------------------
--------------------------  To Get the sol mnemonic ---------------------
-------------------------------------------------------------------------
    BEGIN
        SELECT  SOL.abbr_br_name,
		SOL.sol_desc
        INTO    lv_abbr_br_name,
		lv_sol_desc
        FROM    TBAADM.SOL SOL
        WHERE   SOL.sol_id = ge_sol_id
                AND SOL.bank_id = lv_bank_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        lv_abbr_br_name := '';
    END;

-----------------------------------------------------------------
BEGIN
	SELECT SUM ((clr_bal_amt)* custom.stbcommonpackage.getconvrate (lv_bank_id,acct_crncy_code,lv_home_crncy_code,lv_rep_rate_code,lv_db_stat_date))
	into tot_brn_cash
  	FROM tbaadm.gam
 	WHERE bacid IN (SELECT bacid
                   FROM tbaadm.aph
                  WHERE placeholder_type = 'C')
   	AND sol_id in (select sol_id from tbaadm.sst where set_id = lv_set_id)
   	AND clr_bal_amt != 0;
	dbms_output.put_line('insideloop'||tot_brn_cash);
EXCEPTION
	when no_data_found then
		tot_brn_cash := 0 ;
END;	
------------------------------------------------------------------------------
------------------------------  PRINTING THE VALUES  -------------------------
------------------------------------------------------------------------------
            lv_flg := 'Y'; 
		dbms_output.put_line('before out rec' || tot_brn_cash);
	
		out_rec :=	  		 
							 lv_br_cash			||'|'||
						   	 lv_acct_crncy_code		||'|'||
							 lv_clr_bal_amt			||'|'||
							 lv_denom_value			||'|'||
							 lv_denom_ind			||'|'||
							 lv_denom_count			||'|'||  	
                       		 			 ge_sol_id			||'|'||
							 lv_br_limit			||'|'||
                       		 			 ge_sol_id			||'|'||
							 lv_abbr_br_name		||'|'||
							 lv_sol_desc			||'|'||
							 lv_denom_calc_home		||'|'||
							 lv_denom_calc			||'|'|| 
							 lv_flg				||'|'||
							lv_home_crncy_code		||'|'||
							lv_brn_limit			||'|'||
							tot_brn_cash;
	IF (lv_curflg = 'I') THEN
	--{
	 	FETCH DENOM 
		INTO
		lv_denom_value,
		lv_denom_ind,
		lv_denom_count,
		lv_denom_calc
		;
		dbms_output.put_line('inside denom'||tot_brn_cash);
------------------------------------------------------------------------------
------------------------------  CLOSE CURSOR DENOM ------------------------
------------------------------------------------------------------------------
		IF DENOM%NOTFOUND THEN
			CLOSE DENOM;
			lv_curflg := 'O';
		END IF;
	--}
	END IF;
------------------------------------------------------------------------------
------------------------------ END OF PROCEDURE FIN_DENVAULT -----------------
END FIN_DENVAULT_PROC;
------------------------------------------------------------------------------
------------------------------ END OF PACKAGE --------------------------------
END FIN_DENVAULT_PACK;
/
------------------------------------------------------------------------------
------------------------------- CREATION OF PUBLIC SYNONYM -------------------
create or replace synonym tbautil.FIN_DENVAULT_PACK for custom.FIN_DENVAULT_PACK
/
create or replace synonym tbagen.FIN_DENVAULT_PACK for custom.FIN_DENVAULT_PACK
/
------------------------------------------------------------------------------
------------------------------ GRANTING PERMISSION TO SCHEMAS ----------------
grant execute,debug on custom.FIN_DENVAULT_PACK to tbagen,tbaadm,tbautil
/
------------------------------------------------------------------------------
------------------------------ END OF FILE  ----------------------------------
show errors
/



