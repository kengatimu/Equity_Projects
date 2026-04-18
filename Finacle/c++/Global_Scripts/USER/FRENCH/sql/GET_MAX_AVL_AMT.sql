DROP FUNCTION CUSTOM.GET_MAX_AVL_AMT;

CREATE OR REPLACE FUNCTION CUSTOM.GET_MAX_AVL_AMT(CATOD_REQ_ID IN CATOD_SANCTION_TABLE.REQUEST_ID%TYPE,
												CATOD_ACCT_NUM IN CATOD_SANCTION_TABLE.ACCT_NUM%TYPE,
												v_bank_id IN VARCHAR2)
												RETURN VARCHAR2
IS
    CATOD_CLR_BAL_AMT 	VARCHAR2(50);
    TOD_AMT 			NUMBER(22,2);
    CATOD_OUT 			VARCHAR2(25):='0';
    TOT_SANCT_AMT 		NUMBER(22,2);
    AVAIBLE_AMT 		NUMBER(22,2);
    dat_clr_bal_amt 	NUMBER(22,2);
    temp_amt 			NUMBER(22,2);
    gam_acid 			tbaadm.gam.acid%type;
BEGIN

	select 
		--sum(req_amt-charge_amt) 
		sum(req_amt) 
	INTO
		TOT_SANCT_AMT 
	from 
		CUSTOM.c_toda 
	where 
		is_deleted='N' 
		and verify_by is not null 
		and verify_date is not null 
		and status_flg='Y' 
		and acct_num = CATOD_ACCT_NUM 
		AND bank_id = v_bank_id;

	SELECT clean_single_tran_lim 
	INTO AVAIBLE_AMT 
	FROM TBAADM.GAM 
	WHERE FORACID = CATOD_ACCT_NUM 
	AND bank_id = v_bank_id;

    BEGIN
    select acid into gam_acid from tbaadm.gam where foracid=CATOD_ACCT_NUM and bank_id=v_bank_id;
        select 
            liab_includ_discret_amt 
        INTO
            dat_clr_bal_amt 
        from 
            tbaadm.dat
        where 
            del_flg='N' 
            and entity_cre_flg = 'Y' 
            and acid = gam_acid
            AND bank_id = v_bank_id
            and discret_advn_srl_num = (select MAX(discret_advn_srl_num)
                                        from 
                                        tbaadm.dat
                                        where 
                                        del_flg='N' 
                                        and entity_cre_flg = 'Y' 
                                        and acid = gam_acid
                                        AND bank_id = v_bank_id );
    END;
    
    if( AVAIBLE_AMT <= TOT_SANCT_AMT) then
        CATOD_OUT := AVAIBLE_AMT;
    else
        temp_amt := AVAIBLE_AMT - dat_clr_bal_amt;
        if (temp_amt <= TOT_SANCT_AMT) then
            CATOD_OUT := temp_amt;
        else
            CATOD_OUT := TOT_SANCT_AMT;
        end if;
    end if;

    RETURN CATOD_OUT;

END GET_MAX_AVL_AMT;
/


DROP SYNONYM CUSTOM.CATOD_GET_MAX_AVL_AMT;

CREATE SYNONYM CUSTOM.CATOD_GET_MAX_AVL_AMT FOR CUSTOM.GET_MAX_AVL_AMT;


GRANT EXECUTE, DEBUG ON CUSTOM.GET_MAX_AVL_AMT TO TBAADM;

GRANT EXECUTE, DEBUG ON CUSTOM.GET_MAX_AVL_AMT TO TBAGEN;

GRANT EXECUTE, DEBUG ON CUSTOM.GET_MAX_AVL_AMT TO TBAUTIL;
