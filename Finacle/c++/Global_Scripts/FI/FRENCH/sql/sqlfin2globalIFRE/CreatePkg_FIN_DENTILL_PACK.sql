DROP PACKAGE CUSTOM.FIN_DENTILL_PACK;

CREATE OR REPLACE PACKAGE CUSTOM.FIN_DENTILL_PACK IS
-------------------------------------------------------------------------------
        PROCEDURE FIN_DENTILL_PROC
        (
        inp_str     IN  VARCHAR2,
        out_retcode OUT NUMBER,
        out_rec     OUT VARCHAR2
        );
-------------------------------------------------------------------------------
End FIN_DENTILL_PACK;
/

DROP PACKAGE BODY CUSTOM.FIN_DENTILL_PACK;

CREATE OR REPLACE PACKAGE BODY CUSTOM.FIN_DENTILL_PACK AS
----------------------------------------------------------------
-- Declaration of procedure variables
---------------------------------------------------------------
OutArr              TBAADM.basp0099.ArrayType;
lv_crncy_code       VARCHAR2(3Char);
ge_sol_id           VARCHAR2(8Char);
lv_emp_id           VARCHAR2(10Char);
lv_emp_name         VARCHAR2(40Char);
lv_acid             TBAADM.GAM.acid%type;
lv_acct_crncy_code  TBAADM.GAM.acct_crncy_code%type;
lv_clr_bal_amt      TBAADM.GAM.clr_bal_amt%type;
gm_sol_id           TBAADM.GAM.sol_id%type;
lv_bank_id          TBAADM.GAM.bank_id%type;
lv_denom_value      CUSTOM.CUST_DENOM_MASTER.denom_value%type;
lv_teller_id        CUSTOM.CUST_DENOM_MASTER.teller_id%type;
lv_denom_count      CUSTOM.CUST_DENOM_MASTER.denom_count%type;
lc_sol_id           CUSTOM.CUST_DENOM_MASTER.sol_id%type;
lv_denom_ind        CUSTOM.CUST_DENOM_MASTER.denom_ind%type;
lv_abbr_br_name     TBAADM.SOL.abbr_br_name%type;
lv_set_id           TBAADM.SST.set_id%type;
rv_cnt              NUMBER := 0;
lv_sol_desc         TBAADM.sol.sol_desc%type;
lv_denom_calc       number(20,4) := 0;
lv_denom_calc_home            TBAADM.GAM.clr_bal_amt%type :=0;
lv_db_stat_date                tbaadm.gct.db_stat_date%TYPE;
lv_home_crncy_code            tbaadm.gct.home_crncy_code%TYPE;
lv_rep_rate_code            tbaadm.gct.report_rate_code%TYPE;
lv_convrate                    VARCHAR2 (24);
lv_flg                        varchar2(2);
lv_usdconv                    TBAADM.GAM.clr_bal_amt%type;
lv_currusdconv                VARCHAR2(3Char);
lv_curflg                    varchar2(1);
lv_sol_id                    TBAADM.GAM.sol_id%type;
------------------------------------------------------------------------------
------------------------------- START OF CURSOR INQUIRY ----------------------
------------------------------------------------------------------------------
CURSOR inquiry(lv_set_id varchar2,lv_teller_id varchar2,lv_crncy_code varchar2) IS

    SELECT  GAM.acid,
        GAM.acct_crncy_code,
        GAM.clr_bal_amt,
        GAM.sol_id,
        GAM.bank_id,
        GEC.emp_id,
        GEC.sol_id,
        GEC.crncy_code,
        GET.emp_name
    FROM
        TBAADM.GEC GEC,
        TBAADM.GAM GAM,
        TBAADM.GET GET
    WHERE
        GEC.emp_cash_acct   = GAM.bacid
        AND     GAM.acct_crncy_code = GEC.crncy_code
        AND     GAM.acct_crncy_code    =decode(lv_crncy_code,'ALL',GAM.acct_crncy_code,lv_crncy_code)
        AND     GAM.sol_id          = GEC.sol_id
        AND     GAM.bank_id         = GEC.bank_id
        AND     GET.emp_id          = GEC.emp_id
        AND     GAM.sol_id in ( SELECT sol_id
                    FROM    TBAADM.SST
                    WHERE   set_id =lv_set_id)
        AND     GEC.emp_id    like   decode(lv_teller_id,'ALL',GEC.emp_id,' ',GEC.emp_id,lv_teller_id)
        AND     GAM.acct_cls_flg = 'N'
        AND     GAM.entity_cre_flg = 'Y'
        AND     GAM.del_flg = 'N'
        AND     GEC.entity_cre_flg = 'Y'
        AND     GEC.del_flg = 'N'
        AND GAM.clr_bal_amt < 0;

------------------------------------------------------------------------------
------------------------------- START OF CURSOR DENOM ----------------------
------------------------------------------------------------------------------
CURSOR denom(lv_emp_id varchar2, ge_sol_id varchar2,lv_crncy_code varchar2) IS
    SELECT    CDM.denom_value,
        CDM.denom_ind,
        CDM.denom_count,
        (cdm.denom_count * cdm.denom_value)
    FROM    CUSTOM.CUST_DENOM_MASTER CDM
    WHERE    CDM.teller_id       = lv_emp_id
        AND CDM.teller_id    like     teller_id
        AND CDM.crncy_code = lv_crncy_code
        AND CDM.del_flg = 'N'
        AND CDM.sol_id = ge_sol_id;

------------------------------------------------------------------------
------------------------------------ PROCEDURES ------------------------
------------------------------------------------------------------------

PROCEDURE FIN_DENTILL_PROC
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
         lv_teller_id:= outArr(1);
         lv_sol_id := outArr(2);
         lv_crncy_code := outArr(3);
         out_retcode :=0 ;


    IF(lv_teller_id !='ALL') THEN
--{
    IF not INQUIRY%ISOPEN THEN
        --{
        OPEN INQUIRY(lv_set_id,lv_teller_id,lv_crncy_code);
        lv_curflg := 'O';
    --}
        END IF;
--}
    ELSE
--{
    lv_teller_id := 'ALL';
        IF not INQUIRY%ISOPEN THEN
        --{
             OPEN INQUIRY(lv_set_id,lv_teller_id,lv_crncy_code);
            lv_curflg := 'O';
    --}
    END IF;

--}
    END IF;

    IF(lv_curflg = 'O') THEN
       FETCH INQUIRY
       INTO
        lv_acid,
        lv_acct_crncy_code,
        lv_clr_bal_amt,
        gm_sol_id,
        lv_bank_id,
        lv_emp_id,
        ge_sol_id,
        lv_crncy_code,
        lv_emp_name;

------------------------------------------------------------------------------
------------------------------  CLOSE CURSOR INQUIRY1 ------------------------
------------------------------------------------------------------------------
        IF INQUIRY%NOTFOUND THEN
            IF INQUIRY%ROWCOUNT = 0 THEN
            gm_sol_id := lv_sol_id;
            BEGIN
                SELECT
                    abbr_br_name,
                    sol_desc
                    into
                    lv_abbr_br_name,
                    lv_sol_desc
                FROM    tbaadm.sol
                WHERE    sol_id = lv_sol_id;
--Changed by Manoj for QC 3414 start
                    BEGIN
                        SELECT
                            emp_name
                        into
                            lv_emp_name
                        FROM    TBAADM.GET
                        WHERE   emp_id = lv_teller_id
                        and     sol_id =lv_sol_id;
                        --and     bank_id = lv_bank_id;
                    EXCEPTION
                        when others then
                        lv_emp_name := '';
                    END;
--end
            EXCEPTION
                when others then
                lv_abbr_br_name := '';
                gm_sol_id  := '';
            END;
            rv_cnt := rv_cnt+1;
            lv_flg:= 'N';
--Changed by Manoj for QC 3414 start
            out_rec :=    lv_emp_name            ||'|'||
            lv_crncy_code          ||'|'||
            lv_clr_bal_amt        ||'|'||
            lv_denom_value        ||'|'||
            lv_denom_ind        ||'|'||
            lv_denom_count        ||'|'||
            gm_sol_id        ||'|'||
            lv_teller_id        ||'|'||
            gm_sol_id        ||'|'||
            lv_abbr_br_name        ||'|'||
            lv_sol_desc        ||'|'||
            lv_denom_calc_home    ||'|'||
            lv_denom_calc        ||'|'||
            lv_flg            ||'|'||
--end
            lv_home_crncy_code;
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
------------------------------  FETCHING DENOM DETAILS ------------------------
------------------------------------------------------------------------------

    IF not DENOM%ISOPEN THEN
    --{
            OPEN DENOM(lv_emp_id , ge_sol_id ,lv_crncy_code);
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
        ELSE lv_curflg := 'I';
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
                    (lv_bank_id,lv_acct_crncy_code,
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
        WHERE   SOL.sol_id = gm_sol_id
            AND SOL.bank_id = lv_bank_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        lv_abbr_br_name := '';
    END;
------------------------------------------------------------------------------
------------------------------  PRINTING THE VALUES  -------------------------
------------------------------------------------------------------------------
    lv_flg := 'Y';
    out_rec :=      lv_emp_name            ||'|'||
            lv_acct_crncy_code     ||'|'||
            lv_clr_bal_amt        ||'|'||
            lv_denom_value        ||'|'||
            lv_denom_ind        ||'|'||
            lv_denom_count        ||'|'||
            ge_sol_id        ||'|'||
            lv_emp_id        ||'|'||
            gm_sol_id        ||'|'||
            lv_abbr_br_name        ||'|'||
            lv_sol_desc        ||'|'||
            lv_denom_calc_home    ||'|'||
            lv_denom_calc        ||'|'||
            lv_flg            ||'|'||
            lv_home_crncy_code;
    IF (lv_curflg = 'I') THEN
    --{
    FETCH DENOM
    INTO
        lv_denom_value,
        lv_denom_ind,
        lv_denom_count,
        lv_denom_calc;
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
------------------------------ END OF PROCEDURE FIN_DENTILL -----------------
END FIN_DENTILL_PROC;
------------------------------------------------------------------------------
------------------------------ END OF PACKAGE --------------------------------
END FIN_DENTILL_PACK;
/


DROP SYNONYM TBAGEN.FIN_DENTILL_PACK;

CREATE SYNONYM TBAGEN.FIN_DENTILL_PACK FOR CUSTOM.FIN_DENTILL_PACK;

DROP SYNONYM TBAUTIL.FIN_DENTILL_PACK;

CREATE SYNONYM TBAUTIL.FIN_DENTILL_PACK FOR CUSTOM.FIN_DENTILL_PACK;

GRANT EXECUTE ON CUSTOM.FIN_DENTILL_PACK TO ALLTAB;

GRANT EXECUTE ON CUSTOM.FIN_DENTILL_PACK TO TBAGEN;

GRANT EXECUTE ON CUSTOM.FIN_DENTILL_PACK TO TBAUTIL;
