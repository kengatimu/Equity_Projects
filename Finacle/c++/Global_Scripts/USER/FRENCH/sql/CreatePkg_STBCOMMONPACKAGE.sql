 DROP PACKAGE CUSTOM.STBCOMMONPACKAGE;

CREATE OR REPLACE PACKAGE CUSTOM.STBCommonpackage is
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
FUNCTION getConvRate(    inp_bank_id  varchar2,
            fixedCrncyCode  varchar2,
                        varCrncyCode    varchar2,
                        Rate_Code       varchar2,
                        inpAsOnDate     date) RETURN NUMBER ;
----------------------------------------------------------------------------
-----------------------------------------------------------------------------
FUNCTION getConvRatefromRTL(   inp_bank_id  varchar2,
            fixedCrncyCode  varchar2,
                        varCrncyCode    varchar2,
                        Rate_Code       varchar2,
                        inpAsOnDate     date) RETURN NUMBER ;
----------------------------------------------------------------------------

END STBCommonpackage;
/

DROP PACKAGE BODY CUSTOM.STBCOMMONPACKAGE;

CREATE OR REPLACE PACKAGE BODY CUSTOM.STBCommonpackage as
--------------------------------------------------------------------------
max_sanct_srl_num      number;
limexpdate             date;
OutArr              tbaadm.basp0099.ArrayType;
glAmt            number(25,7) :=0;
totalGLBal        number(25,7) :=0;
glSubheadCode    varchar2(5);
solId            varchar2(8);
crncyCode        varchar2(3);
rate            number(21,10);
ExRate            number(21,10);
ConvertAmount   number(20,4):=0.00;
EAB_amt             number(20,4):=0.00;
glSubHead_amt   number(20,4):=0.00;
glCode_amt          number(20,4):=0.00;


---------------------------------------------------------------------------------------
FUNCTION getConvRate(   inp_bank_id  varchar2,
            fixedCrncyCode  varchar2,
                        varCrncyCode    varchar2,
                        Rate_Code       varchar2,
                        inpAsOnDate     date) RETURN NUMBER IS
---------------------------------------------------------------------------------------
CURSOR c1(rtcd varchar2) IS
        SELECT (to_number(nvl(var_crncy_units,0)))/(to_number(nvl(fxd_crncy_units,1))) finalrate
        FROM tbaadm.rth r1
     where r1.bank_id = inp_bank_id
       and r1.fxd_crncy_code = fixedCrncyCode
        AND r1.var_crncy_code = varCrncyCode
        AND r1.ratecode = rtcd
        AND r1.del_flg != 'Y'
        AND r1.rtlist_date = (SELECT max(r2.rtlist_date)
                              FROM tbaadm.rth r2
                  where r2.bank_id = inp_bank_id
                              and r2.fxd_crncy_code = fixedCrncyCode
                              AND r2.var_crncy_code = varCrncyCode
                              AND r2.ratecode = rtcd
                              AND r2.rtlist_date <= (to_date(inpAsOnDate))
                              AND r2.del_flg  != 'Y')
        ORDER BY r1.rtlist_num desc;

CURSOR c2(rtcd varchar2) IS
        SELECT (to_number(nvl(var_crncy_units,0)))/(to_number(nvl(fxd_crncy_units,1))) finalrate
        FROM tbaadm.rth r1
        WHERE  r1.bank_id = inp_bank_id
    and r1.fxd_crncy_code = varCrncyCode
        AnD r1.var_crncy_code = fixedCrncyCode
        AND r1.ratecode = rtcd
        and r1.del_flg != 'Y'
        and r1.rtlist_date = (  select max(r2.rtlist_date)
                                from tbaadm.rth r2
                                where  r1.bank_id = inp_bank_id
                and r2.fxd_crncy_code = varCrncyCode
                                and r2.var_crncy_code = fixedCrncyCode
                                and r2.ratecode = rtcd
                                and r2.rtlist_date <= (to_date(inpAsOnDate))
                                and r2.del_flg  != 'Y')
        order by r1.rtlist_num desc;

i          c1%rowtype;
j          c2%rowtype;
lv_data varchar2(20);
lv_rateCode varchar2(5);
ExRate number(21,10);
----------------------------------------------------------------------------------------
 begin
    Begin
        select  ref_code
    into    lv_rateCode
        from    tbaadm.rct
        where   ref_code=Rate_Code
    and ref_rec_type='67'
        and     del_flg<>'Y' and bank_id =inp_bank_id;
    Exception
        when no_data_found then
            lv_rateCode:=0;
    END;
    IF lv_rateCode IS NULL THEN
        lv_rateCode := 0;
    ELSE
        lv_rateCode := Rate_Code;
    END IF;
    ExRate := 0;

    Begin
        select  'RTL' into lv_data
            FROM tbaadm.rtl r1
            WHERE r1.bank_id = inp_bank_id and r1.fxd_crncy_code = fixedCrncyCode
            AND r1.var_crncy_code = varCrncyCode
            AND r1.ratecode = lv_rateCode
            and r1.del_flg != 'Y'
            and r1.rtlist_date = inpAsOnDate;
    EXCEPTION
    WHEN no_data_found THEN
    lv_data := 'RTH';
    END;

    IF(lv_data = 'RTL') then
    --{
        ExRate := getConvRatefromRTL (inp_bank_id ,fixedCrncyCode,varCrncyCode,Rate_Code,inpAsOnDate);
        return(ExRate);
    --}
    END IF;

    IF varCrncyCode = fixedCrncyCode then
    ExRate := 1;
    return(ExRate);
    END if;

    for i in c1(lv_rateCode)
    loop
    ExRate := i.finalrate;
    exit;
    END loop;

    IF ExRate = 0 then
    begin
        for j in c2(lv_rateCode)
        loop
            IF (nvl(j.finalrate,0) = 0) THEN
            ExRate := 0;
            ELSE
            ExRate := 1/j.finalrate;
            END IF;
        exit;
        END loop;
        END;
    END if;
    IF ExRate = 0 then
    ExRate := 1;
    END if;
    return(ExRate);
END getConvRate;

--#################################################################################
-- FUNCTION getConvRatefromRTL
-- To Get ConvRate from RTL
-- Sandeep Patil
--#################################################################################
---------------------------------------------------------------------------------------
FUNCTION getConvRatefromRTL(   inp_bank_id  varchar2,
            fixedCrncyCode  varchar2,
                        varCrncyCode    varchar2,
                        Rate_Code       varchar2,
                        inpAsOnDate     date) RETURN NUMBER IS
---------------------------------------------------------------------------------------
CURSOR c1(rtcd varchar2) IS
        SELECT (to_number(nvl(var_crncy_units,0)))/(to_number(nvl(fxd_crncy_units,1))) finalrate
        FROM tbaadm.rtl r1
        WHERE r1.bank_id = inp_bank_id and r1.fxd_crncy_code = fixedCrncyCode
        AND r1.var_crncy_code = varCrncyCode
        AND r1.ratecode = rtcd
        AND r1.del_flg != 'Y'
             ORDER BY r1.rtlist_num desc;

CURSOR c2(rtcd varchar2) IS
        SELECT (to_number(nvl(var_crncy_units,0)))/(to_number(nvl(fxd_crncy_units,1))) finalrate
        FROM tbaadm.rtl r1
        WHERE r1.bank_id = inp_bank_id and r1.fxd_crncy_code = varCrncyCode
        AnD r1.var_crncy_code = fixedCrncyCode
        AND r1.ratecode = rtcd
        and r1.del_flg != 'Y'
        order by r1.rtlist_num desc;
i          c1%rowtype;
j          c2%rowtype;
lv_rateCode varchar2(5);
ExRate number(21,10);
----------------------------------------------------------------------------------------
 begin
    Begin
        select  ref_code
    into    lv_rateCode
        from    tbaadm.rct
        where   ref_code=Rate_Code
    and ref_rec_type='67'
        and     del_flg<>'Y' and bank_id =inp_bank_id;
    Exception
        when no_data_found then
            lv_rateCode:=0;
    END;
    IF lv_rateCode IS NULL THEN
        lv_rateCode := 0;
    ELSE
        lv_rateCode := Rate_Code;
    END IF;
    ExRate := 0;

    IF varCrncyCode = fixedCrncyCode then
    ExRate := 1;
    return(ExRate);
    END if;

    for i in c1(lv_rateCode)
    loop
    ExRate := i.finalrate;
    exit;
    END loop;

    IF ExRate = 0 then
    begin
        for j in c2(lv_rateCode)
        loop
            IF (nvl(j.finalrate,0) = 0) THEN
            ExRate := 0;
            ELSE
            ExRate := 1/j.finalrate;
            END IF;
        exit;
        END loop;
        END;
    END if;
    IF ExRate = 0 then
    ExRate := 1;
    END if;
    return(ExRate);
END getConvRatefromRTL;

--------------------------------------------------------------------------------------
-- END of the Package
------------------------
END STBCommonpackage;
/

GRANT EXECUTE ON CUSTOM.STBCOMMONPACKAGE TO ALLTAB;
