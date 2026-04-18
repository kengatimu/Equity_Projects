DROP PACKAGE CUSTOM.GETICHQDETAILDWNLD;

CREATE OR REPLACE PACKAGE CUSTOM.Getichqdetaildwnld AS
PROCEDURE Getichqdetaildwnld( inp_str IN VARCHAR2,
            out_retCode OUT NUMBER,
            out_desc OUT VARCHAR2);
END Getichqdetaildwnld;
/


DROP PACKAGE BODY CUSTOM.GETICHQDETAILDWNLD;

CREATE OR REPLACE PACKAGE BODY CUSTOM.Getichqdetaildwnld AS
PROCEDURE Getichqdetaildwnld( inp_str IN VARCHAR2,
                                out_retCode OUT NUMBER,
                                out_desc OUT VARCHAR2) AS

SolId           TBAADM.GAM.SOL_ID%TYPE;
--CustId          GAM.CUST_ID%TYPE;
SORTCODE        VARCHAR2(15);
CHQDIGIT        NUMBER;
CHQVDIGIT        CUSTOM.CUSTOM_CCY.CHQ_VCH%TYPE;
CRVDIGIT        CUSTOM.CUSTOM_CCY.CR_VCH%TYPE;
BKSTYLE             CUSTOM.CUSTOM_CCY.BOOK_STYLE%TYPE;
CHQBOOKS        CUSTOM.C_ICBM.NUM_OF_CHB%TYPE;                     
CHQTYPE            CUSTOM.C_ICBM.INST_TYPE%TYPE;
-- CHQSSR            CUSTOM.CUSTOM_CBN.CHQ_NUM%TYPE;
CHQSSR            CUSTOM.C_ICBM.BEGIN_CHQ_NUM%TYPE;
CUSTNAME        TBAADM.gam.acct_NAME%TYPE;
BRNAME            TBAADM.BCT.BR_NAME%TYPE;
custnameNum        NUMBER;
BRADDRESS        TBAADM.BCT.BR_ADDR_1%TYPE;
RCREID            CUSTOM.C_ICBM.RCRE_USER_ID%TYPE;
AUTHID            CUSTOM.C_ICBM.AUTH_USER_ID%TYPE;
FORACID1        TBAADM.GAM.FORACID%TYPE;
BANKCODE        TBAADM.BCT.BANK_CODE%TYPE;
BRCODE            TBAADM.BCT.BR_CODE%TYPE;
ACCTCRNCY       TBAADM.GAM.ACCT_CRNCY_CODE%TYPE;
SCHMTYPE        TBAADM.GAM.SCHM_TYPE%TYPE;
CHQLVS          CUSTOM.C_ICBM.NUM_OF_CHQ_LVS%TYPE;
REQID           CUSTOM.C_ICBM.REQ_ID%TYPE;
DNLD_ID         CUSTOM.C_ICBM.Download_id%TYPE;
REQDATE         CUSTOM.C_ICBM.REQ_DATE%TYPE;
NOOFLVS            NUMBER(8);
vCHSSR            VARCHAR2(8);
vCHQTYPE        VARCHAR2(6);
vCHQBOOKS        VARCHAR2(2);
vREQID            VARCHAR2(6);
vREQDATE        VARCHAR2(10);
vDNLD_ID        VARCHAR2(6);
vENDNO              NUMBER(8);
vENDNO1            VARCHAR2(8);
SCHMCODE            VARCHAR2(10);
SCHMDESC                VARCHAR2(25);
lenBRADDRESS    NUMBER(2);
lenCUSTNAME        NUMBER(2);
MICR_BRCODE        TBAADM.BCT.BR_CODE%TYPE;
BR_CITY_CODE     TBAADM.BCT.BR_CITY_CODE%TYPE;
BR_CITY_NAME    TBAADM.RCT.REF_DESC%TYPE;
vTrancode        VARCHAR2(2);
bankID            CUSTOM.C_ICBM.bank_id%TYPE;
SCMTYPE1                VARCHAR2(10);
ACTCRNCY1               VARCHAR2(10);
ACTCRNCY2       VARCHAR2(10);
ACTCRNCY3       VARCHAR2(10);
ACTCRNCY4       VARCHAR2(10);
SCMCODE1                VARCHAR2(10);
ACTCRNCY5       VARCHAR2(10);
ACTCRNCY6       VARCHAR2(10);
ACTCRNCY7               VARCHAR2(10);
ACTCRNCY8               VARCHAR2(10);
SCMTYPE2                VARCHAR2(10);
SCMCODE2                VARCHAR2(10);
ACTCRNCY9               VARCHAR2(10);
ACTCRNCY10      VARCHAR2(10);
ACTCRNCY11              VARCHAR2(10);
ACTCRNCY12      VARCHAR2(10);
ACTCRNCY13              VARCHAR2(10);
ACTCRNCY14      VARCHAR2(10);
ACTCRNCY15              VARCHAR2(10);
ACTCRNCY16              VARCHAR2(10);
CHQLVS1         VARCHAR2(10); 
CHQLVS2          VARCHAR2(10);
CHQLVS3          VARCHAR2(10);
BKSTYLE1         VARCHAR2(10);
BKSTYLE2         VARCHAR2(10);
BKSTYLE3         VARCHAR2(10);
BKSTYLE4         VARCHAR2(10);
BKSTYLE5         VARCHAR2(10);
BKSTYLE6         VARCHAR2(10);
BKSTYLE7         VARCHAR2(10);
BKSTYLE8         VARCHAR2(10);
BKSTYLE9         VARCHAR2(10);
BKSTYLE10        VARCHAR2(10);
BKSTYLE11        VARCHAR2(10);
BKSTYLE12        VARCHAR2(10);
BKSTYLE13        VARCHAR2(10);
BKSTYLE14        VARCHAR2(10);
BKSTYLE15        VARCHAR2(10);
BKSTYLE16        VARCHAR2(10);
BKSTYLE17        VARCHAR2(10);
BKSTYLE18        VARCHAR2(10);
BKSTYLE19        VARCHAR2(10);
BKSTYLE20        VARCHAR2(10);
BKSTYLE21        VARCHAR2(10);
BKSTYLE22        VARCHAR2(10);
BKSTYLE23        VARCHAR2(10);
BKSTYLE24        VARCHAR2(10);
BKSTYLE25        VARCHAR2(10);
BKSTYLE26        VARCHAR2(10);
BKSTYLE27        VARCHAR2(10);
BKSTYLE28        VARCHAR2(10);
BKSTYLE29        VARCHAR2(10);
BKSTYLE30        VARCHAR2(10);
BKSTYLE31        VARCHAR2(10);
BKSTYLE32        VARCHAR2(10);
BKSTYLE33        VARCHAR2(10);
BKSTYLE34        VARCHAR2(10);
BKSTYLE35        VARCHAR2(10);
BKSTYLE36        VARCHAR2(10);
BKSTYLE37        VARCHAR2(10);
BKSTYLE38        VARCHAR2(10);
BKSTYLE39        VARCHAR2(10);
BKSTYLE40        VARCHAR2(10);
BKSTYLE41        VARCHAR2(10);
BKSTYLE42        VARCHAR2(10);
BKSTYLE43        VARCHAR2(10);
BKSTYLE44        VARCHAR2(10);
BKSTYLE45        VARCHAR2(10);
BKSTYLE46        VARCHAR2(10);
BKSTYLE47        VARCHAR2(10);
BKSTYLE48        VARCHAR2(10);
vTran1          VARCHAR2(10);
vTran2            VARCHAR2(10);
vTran3            VARCHAR2(10);
vTran4            VARCHAR2(10);
vTran5            VARCHAR2(10);
vTran6            VARCHAR2(10);
refCode        VARCHAR2(10);
micrCode        VARCHAR2(10);
hardcode1                VARCHAR2(10);
hardcode2               VARCHAR2(10);
BID            VARCHAR2(8);



 
CURSOR GET_ACCOUNT (STARTDATE VARCHAR2,ENDDATE VARCHAR2,SOL VARCHAR2,BID VARCHAR2) IS
SELECT  DISTINCT C_ICBM.REQ_ID,C_ICBM.FORACID,C_ICBM.bank_id
FROM    CUSTOM.C_ICBM,TBAADM.GAM
WHERE   REQ_DATE BETWEEN STARTDATE AND ENDDATE
--    AND        REQ_STATUS = 'A' AND TRIM(BRANCH_ID) = SOL
AND     REQ_STATUS = 'A'
AND GAM.FORACID=C_ICBM.FORACID
AND GAM.bank_id = BID
AND GAM.bank_id = CUSTOM.C_ICBM.bank_id
AND GAM.SCHM_TYPE='SBA'
ORDER BY C_ICBM.REQ_ID;

StartDate       VARCHAR2(10);
EndDate         VARCHAR(10);
SOL                TBAADM.GAM.SOL_ID%TYPE;
OutArr          tbaadm.BASP0099.ARRAYTYPE;
DWNLOADID        NUMBER(7);


BEGIN
    out_desc    :=NULL;
    out_retCode :=0;

    
        tbaadm.basp0099.formInputArr (inp_str,OutArr);
        StartDate         := TO_DATE(OutArr(0),'DD-MM-YYYY');
        EndDate            := TO_DATE(OutArr(1),'DD-MM-YYYY');
        SOL                := trim(OutArr(2));
        DWNLOADID         := trim(OutArr(3));
        SCMTYPE1           := trim(OutArr(4)); 
        ACTCRNCY1         := trim(OutArr(5));
        ACTCRNCY2       := trim(OutArr(6));
        ACTCRNCY3       := trim(OutArr(7));
        ACTCRNCY4       := trim(OutArr(8));
        SCMCODE1        := trim(OutArr(9));
        ACTCRNCY5       := trim(OutArr(10));
        ACTCRNCY6       := trim(OutArr(11));
        ACTCRNCY7        := trim(OutArr(12));
        ACTCRNCY8        := trim(OutArr(13));
        SCMTYPE2        := trim(OutArr(14));
        SCMCODE2        := trim(OutArr(15));    
        ACTCRNCY9        := trim(OutArr(16));
        ACTCRNCY10      := trim(OutArr(17));
        ACTCRNCY11        := trim(OutArr(18));
        ACTCRNCY12      := trim(OutArr(19));
        ACTCRNCY13        := trim(OutArr(20));
        ACTCRNCY14      := trim(OutArr(21));
        ACTCRNCY15        := trim(OutArr(22));
        ACTCRNCY16        := trim(OutArr(23));
        BID            := trim(OutArr(24));
    IF NOT Get_Account%ISOPEN THEN
        OPEN Get_Account(StartDate,EndDate,SOL,BID);
    END IF;

    FETCH Get_Account INTO  REQID,FORACID1,bankID;
    IF Get_Account%NOTFOUND THEN
        CLOSE Get_Account;
        out_retCode :=1;
        RETURN;
    END IF;

    REQID        :=    trim(REQID);
    FORACID1    :=     trim(FORACID1);

    BEGIN
                -- select  cust_id,sol_id,acct_crncy_code,schm_type
        SELECT    sol_id,acct_crncy_code,schm_type,schm_code
        INTO    SOLID,ACCTCRNCY,SCHMTYPE,SCHMCODE
        FROM    tbaadm.gam
        WHERE    foracid = FORACID1
        and bank_id = bankID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
    --        CUSTID         := null;
            SOLID         := NULL;
            ACCTCRNCY     := NULL;
            SCHMTYPE     := NULL;
            SCHMCODE        := NULL;
    END;
    SCHMTYPE := trim(SCHMTYPE);
        SCHMCODE := trim(SCHMCODE);
        BEGIN
                SELECT  schm_desc
                INTO SCHMDESC
                FROM   tbaadm.gsp
                WHERE   schm_code = SCHMCODE AND schm_type = SCHMTYPE 
                and bank_id = bankID;

                EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        SCHMDESC        :=NULL;
        END;
    SOLID    := trim(SOLID);
    ACCTCRNCY    := trim(ACCTCRNCY);
    SCHMTYPE    := trim(SCHMTYPE);
    BEGIN
        SELECT    br_code,bank_code
        INTO    BRCODE,BANKCODE
        FROM    tbaadm.sol
        WHERE    sol_id = SOLID
        and bank_id = bankID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            BRCODE         := NULL;
            BANKCODE     := NULL;
    END;
    BRCODE    := trim(BRCODE);
    BANKCODE:= trim(BANKCODE);
    SELECT 
       CUSTOM.getCparamValue('REFCODE','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('MICRBR','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('HARDCODE1','CHQBKMNCE',bankID),
           CUSTOM.getCparamValue('HARDCODE2','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('CUSTNAME','CHQBKMNCE',bankID)

    INTO
       refCode,
       micrCode,
       hardcode1,
           hardcode2,
       custnameNum

    FROM DUAL;

    BEGIN
        SELECT    bank_code,br_name,br_addr_1,bct.BR_CITY_CODE
        INTO    BANKCODE,BRNAME,BRADDRESS,BR_CITY_CODE
        FROM    tbaadm.bct
        WHERE    br_code = BRCODE AND bank_code = BANKCODE 
        and bank_id = bankID;

         SELECT    RCT.REF_DESC
        INTO    BR_CITY_NAME
        FROM    tbaadm.RCT
        WHERE    RCT.ref_rec_type = refCode
        AND        RCT.ref_code= BR_CITY_CODE
        and bank_id = bankID;

        BR_CITY_NAME := trim(BR_CITY_NAME);
        BRADDRESS := trim(BRADDRESS);
        BRADDRESS := BRADDRESS;
                lenBRADDRESS := LENGTH(BRADDRESS);
--------------------------------------------------------------------------------
-- If the length of the Address is more than 30 characters, it will be truncated
--------------------------------------------------------------------------------
--        IF (lenBRADDRESS > 30) then
--            BRADDRESS := substr(BRADDRESS,1,30);
--        END IF;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            BANKCODE     := NULL;
            BRNAME         := NULL;
            BRADDRESS     := NULL;
    END;
    BEGIN


        SELECT    acct_name
        INTO    CUSTNAME
        FROM    tbaadm.gam
        WHERE    foracid = FORACID1
        and bank_id = bankID;

        CUSTNAME     := trim(CUSTNAME);
        lenCUSTNAME := LENGTH(CUSTNAME);
        EXCEPTION


            WHEN NO_DATA_FOUND THEN
            CUSTNAME := NULL;
    END;
--------------------------------------------------------------------------------
-- If the Customers name is greater than 36 characters, the short name of that
-- customer would be selected.
-- This logic is not working since the short name has since beeen Replaced with
-- old account number (changed to
--------------------------------------------------------------------------------

    IF (lenCUSTNAME > custnameNum) THEN
    BEGIN
        SELECT acct_short_name
        INTO CUSTNAME
        FROM tbaadm.gam
        WHERE   foracid  = FORACID1
        and bank_id = bankID;
        CUSTNAME := trim(CUSTNAME);
-- End of modification by Gachau

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CUSTNAME := NULL;
    END;
    END IF;


    BEGIN
        SELECT    RCRE_USER_ID,AUTH_USER_ID,LPAD(NUM_OF_CHQ_LVS,3,0),NUM_OF_CHB,REQ_DATE,INST_TYPE
        INTO    RCREID,AUTHID,CHQLVS,CHQBOOKS,REQDATE,CHQTYPE
        FROM    CUSTOM.C_ICBM
        WHERE    req_id = REQID
        and bank_id = bankID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            RCREID     := NULL;
            AUTHID     := NULL;
            CHQLVS     := NULL;
            CHQBOOKS:= NULL;
            REQDATE:= NULL;
            CHQTYPE := NULL;
    END;
        CHQLVS := trim(CHQLVS);
        REQDATE := trim(REQDATE);

    BEGIN
        SELECT    book_style,chq_vch,cr_vch
        INTO    BKSTYLE,CHQVDIGIT,CRVDIGIT
        FROM    CUSTOM.CUSTOM_CCY
        WHERE    crncy_code=ACCTCRNCY
        AND        schm_type = SCHMTYPE
        AND        no_of_lvs =CHQLVS
        and bank_id = bankID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            BKSTYLE     := NULL;
            CHQVDIGIT     := NULL;
            CRVDIGIT     := NULL;
    END;
    SELECT 
       CUSTOM.getCparamValue('CHQLVS1','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('CHQLVS2','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('CHQLVS3','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE1','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE2','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE3 ','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE4','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE5','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE6','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE7','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE8','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE9','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE10','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE11','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE12','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE13','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE14','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE15','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE16','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE17','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE18','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE19','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE20','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE21 ','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE22','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE23','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE24','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE25','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE26','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE27','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE28','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE29','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE30','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE31','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE32','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE33','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE34','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE35','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE36','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE37','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE38','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE39','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE40','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE41','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE42','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE43','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE44','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE45','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE46','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE47','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('BKSTYLE48','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('vTran1','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('vTran2','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('vTran3','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('vTran4','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('vTran5','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('vTran5','CHQBKMNCE',bankID)
INTO
    CHQLVS1,  
    CHQLVS2,   
        CHQLVS3, 
        BKSTYLE1,
        BKSTYLE2,
        BKSTYLE3,
        BKSTYLE4,
        BKSTYLE5,
        BKSTYLE6,
        BKSTYLE7,
        BKSTYLE8,
        BKSTYLE9,
        BKSTYLE10,
        BKSTYLE11,
        BKSTYLE12,
        BKSTYLE13,
        BKSTYLE14,
        BKSTYLE15,
        BKSTYLE16,
        BKSTYLE17,
        BKSTYLE18,
        BKSTYLE19,
        BKSTYLE20,
        BKSTYLE21,
        BKSTYLE22,
        BKSTYLE23,
        BKSTYLE24,
        BKSTYLE25,
        BKSTYLE26,
        BKSTYLE27,
        BKSTYLE28,
        BKSTYLE29,
        BKSTYLE30,
        BKSTYLE31,
        BKSTYLE32,
        BKSTYLE33,
        BKSTYLE34,
        BKSTYLE35,
        BKSTYLE36,
        BKSTYLE37,
        BKSTYLE38,
        BKSTYLE39,
        BKSTYLE40,
        BKSTYLE41,
        BKSTYLE42,
        BKSTYLE43,
        BKSTYLE44,
        BKSTYLE45,
        BKSTYLE46,
        BKSTYLE47,
        BKSTYLE48,
    vTran1 ,
        vTran2,
        vTran3,
        vTran4,
        vTran5,
        vTran6    
        
FROM DUAL;
    ---Start inculusions by eric for delarue customization
    IF (SCHMTYPE =SCMTYPE1) THEN
        vTrancode := vTran1;
        IF (ACCTCRNCY= ACTCRNCY1) THEN
            IF (CHQLVS =CHQLVS1) THEN
               BKSTYLE := BKSTYLE1;
            END IF ;
            IF (CHQLVS =CHQLVS2) THEN
               BKSTYLE := BKSTYLE2;
            END IF ;
            IF (CHQLVS =CHQLVS3) THEN
               BKSTYLE := BKSTYLE3;
            END IF ;
        END IF;
        IF (ACCTCRNCY= ACTCRNCY2) THEN
            IF (CHQLVS =CHQLVS1) THEN
               BKSTYLE := BKSTYLE4;
            END IF ;
            IF (CHQLVS =CHQLVS2) THEN
               BKSTYLE := BKSTYLE5;
            END IF ;
            IF (CHQLVS =CHQLVS3) THEN
               BKSTYLE := BKSTYLE6;
            END IF ;
        END IF;
        IF (ACCTCRNCY= ACTCRNCY3) THEN
            IF (CHQLVS =CHQLVS1) THEN
               BKSTYLE := BKSTYLE7;
            END IF ;
            IF (CHQLVS =CHQLVS2) THEN
               BKSTYLE := BKSTYLE8;
            END IF ;
            IF (CHQLVS =CHQLVS3) THEN
               BKSTYLE := BKSTYLE9;
            END IF ;
        END IF;
        IF (ACCTCRNCY= ACTCRNCY4 ) THEN
            IF (CHQLVS =CHQLVS1) THEN
               BKSTYLE := BKSTYLE10;
            END IF ;
            IF (CHQLVS =CHQLVS2) THEN
               BKSTYLE := BKSTYLE11;
            END IF ;
            IF (CHQLVS =CHQLVS3) THEN
               BKSTYLE := BKSTYLE12;
            END IF ;
        END IF;
        IF (SCHMCODE = SCMCODE1) THEN
             vTrancode    := vTran2;
             IF (ACCTCRNCY= ACTCRNCY5) THEN
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE13;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE14;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE15;
             END IF;
          END IF;
          IF (ACCTCRNCY= ACTCRNCY6) THEN
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE :=BKSTYLE16;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE17;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE18;
             END IF;
          END IF;
          IF (ACCTCRNCY= ACTCRNCY7) THEN
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE19;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE :=BKSTYLE20;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE21;
             END IF;
          END IF;
          IF (ACCTCRNCY= ACTCRNCY8) THEN
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE22;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE23;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE24;
             END IF;
         END IF;
        END IF ;
    END IF;
    IF (SCHMTYPE = SCMTYPE2) THEN
       IF (SCHMCODE = SCMCODE2) THEN
             IF (ACCTCRNCY= ACTCRNCY9) THEN
               vTrancode    := vTran2;
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE25;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE26;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE27;
             END IF;
          END IF;
          IF (ACCTCRNCY= ACTCRNCY10) THEN
               vTrancode    := vTran3;
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE :=BKSTYLE28;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE29;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE30;
             END IF;
          END IF;
          IF (ACCTCRNCY= ACTCRNCY11) THEN
               vTrancode    := vTran4;          
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE31;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE :=BKSTYLE32;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE33;
             END IF;
          END IF;
          IF (ACCTCRNCY= ACTCRNCY12) THEN
               vTrancode    := vTran5;          
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE34;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE35;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE36;
             END IF;
         END IF;
       ELSE
          IF (ACCTCRNCY= ACTCRNCY13) THEN
               vTrancode    := vTran6;
                  IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE37;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE38;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE39;
             END IF;                
          END IF;
          IF (ACCTCRNCY= ACTCRNCY14) THEN
               vTrancode    := vTran3;
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE40;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE41;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE42;
             END IF;
          END IF;
          IF (ACCTCRNCY= ACTCRNCY15) THEN
               vTrancode    := vTran4;
               IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE43;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE44;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE45;
             END IF;
          END IF;
          IF (ACCTCRNCY= ACTCRNCY16) THEN
             vTrancode    := vTran5;              
           IF (CHQLVS =CHQLVS1) THEN
                 BKSTYLE := BKSTYLE46;
             END IF;
             IF (CHQLVS =CHQLVS2) THEN
                 BKSTYLE := BKSTYLE47;
             END IF;
             IF (CHQLVS =CHQLVS3) THEN
                 BKSTYLE := BKSTYLE48;
             END IF;
          END IF;
       END IF ;
    END IF;
        ---END  inculusions by eric for delarue customization

    UPDATE CUSTOM.C_ICBM SET DOWNLOAD_ID = DWNLOADID,req_status = 'S' WHERE req_id = REQID and bank_id = bankID;
    COMMIT;

    BEGIN
        SELECT LPAD(BEGIN_CHQ_NUM,6,0),DOWNLOAD_ID
        INTO    CHQSSR,DNLD_ID
        FROM    CUSTOM.C_ICBM
        WHERE     REQ_ID=REQID
        and bank_id = bankID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            CHQSSR := NULL;
            DNLD_ID := NULL;
    END;
    BEGIN
        SELECT ((NUM_OF_CHB*NUM_OF_CHQ_LVS) + BEGIN_CHQ_NUM) - 1
        INTO vENDNO
        FROM CUSTOM.C_ICBM
        WHERE REQ_ID=REQID
        and bank_id = bankID;
        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        vENDNO := NULL;
    END;
    BEGIN
        SELECT    MICR_BRANCH_CODE
        INTO    MICR_BRCODE
        FROM    TBAADM.BCT
        WHERE    BCT.BR_CODE = BRCODE
        AND        BCT.BANK_CODE = BANKCODE
        and bank_id = bankID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            MICR_BRCODE := micrCode;
    END;


    SORTCODE    := BANKCODE||MICR_BRCODE;
    NOOFLVS        := CHQSSR + CHQBOOKS * CHQLVS;

    EQUITYCommonPack.GETCHQDIGIT(FORACID1,SORTCODE,CHQDIGIT);

--    FORACID1        := substr(FORACID1,4,9);
--    update C_ICBM set DOWNLOAD_ID = DWNLOADID,req_status = 'S' where req_id = REQID;
--    commit;

    vCHSSR         :=    RPAD(CHQSSR,6,' ');
    vCHQTYPE    :=    RPAD(CHQTYPE,6,' ');
--    vREQID        :=  REQID;
--    vREQID        :=  trim(vREQID);
--    vREQID         :=    lpad(vREQID,6,'0');
    vDNLD_ID    :=  DNLD_ID;
    vDNLD_ID        :=  trim(vDNLD_ID);
    vDNLD_ID        :=  LPAD(vDNLD_ID,6,'0');
    vCHQBOOKS      :=  CHQBOOKS;
--    FORACID1     :=     substr(FORACID1,4,10);
--    FORACID1     :=     lpad(FORACID1,10,' ');
    SORTCODE     :=     RPAD(SORTCODE,5,' ');
    CHQDIGIT     :=     RPAD(CHQDIGIT,1,' ');
    CHQVDIGIT     :=     RPAD(CHQVDIGIT,2,' ');
    CRVDIGIT     :=  RPAD(CRVDIGIT,2,' ');
    BKSTYLE     :=  RPAD(BKSTYLE,3,' ');
    vCHQBOOKS     :=  LPAD(CHQBOOKS,2,'0');
    vENDNO1        :=  LPAD(vENDNO,6,'0');
--    vCHSSR         :=  lpad(vCHSSR,6,'0');
--    vCHSSR         :=  CHQSSR;
    --CUSTNAME     :=  RPAD(CUSTNAME,45,' ');
    CUSTNAME        :=  trim(CUSTNAME);
    BRNAME         :=  RPAD(BRNAME,25,' ');
    BRADDRESS     :=  RPAD(BRADDRESS,23,' ');
    RCREID         :=  RPAD(RCREID,8,' ');
    AUTHID         :=  RPAD(AUTHID,8,' ');
--    vREQDATE    :=  substr(REQDATE,1,6)||substr(REQDATE,8,3);
    vREQDATE        :=  SUBSTR(REQDATE,7,4)||SUBSTR(REQDATE,3,3)||'-'||SUBSTR(REQDATE,1,2);

    --out_desc := '|68'||'|'||BRCODE||'|'||FORACID1||'|'||CUSTNAME||'|'||SCHMDESC||'|'||ACCTCRNCY||'|'||vCHQTYPE||'|'||vCHQBOOKS||'|'||CHQLVS||'|'||vCHSSR||'|'||vENDNO1||'|'||vREQDATE||'|' ;
    --out_desc := '|68'||'|'||BRCODE||'|'||FORACID1||'|'||CUSTNAME||'|'||SCHMDESC||'|'||ACCTCRNCY||'|'||vCHQBOOKS||'|'||CHQLVS||'|'||vCHSSR||'|'||vENDNO1||'|'||vREQDATE||'|' ;
    out_desc := hardcode1||' '||hardcode2||RPAD(solid||''||SUBSTR(FORACID1,4),13,' ')||CHQDIGIT||vTrancode||trim(BKSTYLE)||vCHQBOOKS||RPAD(vCHSSR,6,' ')||RPAD(CUSTNAME,80,' ')||RPAD(BRNAME,30,' ')||RPAD(BRADDRESS,30,' ')||RPAD(FORACID1,15,' ');
    
END Getichqdetaildwnld;

END Getichqdetaildwnld;
/


GRANT EXECUTE ON CUSTOM.GETICHQDETAILDWNLD TO ALLTAB;

GRANT EXECUTE ON CUSTOM.GETICHQDETAILDWNLD TO TBAADM;

GRANT EXECUTE ON CUSTOM.GETICHQDETAILDWNLD TO TBAGEN;

GRANT EXECUTE ON CUSTOM.GETICHQDETAILDWNLD TO TBAUTIL;
