--DROP PACKAGE CUSTOM.GETCHQDETAILDWNLDCAA_56;

CREATE OR REPLACE PACKAGE CUSTOM.Getchqdetaildwnldcaa_56 AS
PROCEDURE Getchqdetaildwnldcaa( inp_str IN VARCHAR2,
            out_retCode OUT NUMBER,
            out_desc OUT VARCHAR2);
END Getchqdetaildwnldcaa_56;
/


GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDWNLDCAA_56 TO TBAADM;

GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDWNLDCAA_56 TO TBAGEN;

GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDWNLDCAA_56 TO TBAUTIL;


DROP PACKAGE BODY CUSTOM.GETCHQDETAILDWNLDCAA_56;

CREATE OR REPLACE PACKAGE BODY CUSTOM.Getchqdetaildwnldcaa_56 AS
CURSOR GET_ACCOUNT (STARTDATE DATE,ENDDATE DATE,SOL VARCHAR2,BID VARCHAR2) IS
    SELECT  DISTINCT CUSTOM_CBR.REQ_ID,CUSTOM_CBR.FORACID,CUSTOM.CUSTOM_CBR.bank_id
    FROM    CUSTOM.CUSTOM_CBR,TBAADM.GAM
    WHERE   REQ_DATE BETWEEN STARTDATE AND ENDDATE
        AND GAM.BANK_ID = BID
    AND        REQ_STATUS = 'A'
    AND GAM.FORACID=CUSTOM_CBR.FORACID
    AND GAM.BANK_ID=CUSTOM_CBR.BANK_ID
    AND GAM.SCHM_TYPE='CAA'
    ORDER BY CUSTOM_CBR.REQ_ID;

StartDate       DATE;
EndDate         DATE;
SOL                TBAADM.GAM.SOL_ID%TYPE;
OutArr          tbaadm.BASP0099.ARRAYTYPE;
DWNLOADID        NUMBER(7);


PROCEDURE Getchqdetaildwnldcaa( inp_str IN VARCHAR2,
                                out_retCode OUT NUMBER,
                                out_desc OUT VARCHAR2) AS

SolId           TBAADM.GAM.SOL_ID%TYPE;
SORTCODE        VARCHAR2(15);
CHQDIGIT        NUMBER;
CHQVDIGIT        CUSTOM.CUSTOM_CCY.CHQ_VCH%TYPE;
CRVDIGIT        CUSTOM.CUSTOM_CCY.CR_VCH%TYPE;
BKSTYLE             CUSTOM.CUSTOM_CCY.BOOK_STYLE%TYPE;
CHQBOOKS        CUSTOM.CUSTOM_CBR.NUM_OF_CHB%TYPE;
CHQSSR            CUSTOM.CUSTOM_CBR.BEGIN_CHQ_NUM%TYPE;
CUSTNAME        TBAADM.CMG.CUST_NAME%TYPE;
BRNAME            TBAADM.BCT.BR_NAME%TYPE;
BRADDRESS        TBAADM.BCT.BR_ADDR_1%TYPE;
RCREID            CUSTOM.CUSTOM_CBR.RCRE_USER_ID%TYPE;
AUTHID            CUSTOM.CUSTOM_CBR.AUTH_USER_ID%TYPE;
FORACID1        TBAADM.GAM.FORACID%TYPE;
BANKCODE        TBAADM.BCT.BANK_CODE%TYPE;
REGIONCODE     TBAADM.BCT.CLG_REF_CODE%TYPE;
REPCODE          TBAADM.BCT.CLG_REP_CODE%TYPE;
BRCODE            TBAADM.BCT.BR_CODE%TYPE;
ACCTCRNCY       TBAADM.GAM.ACCT_CRNCY_CODE%TYPE;
SCHMTYPE        TBAADM.GAM.SCHM_TYPE%TYPE;
CHQLVS          CUSTOM.CUSTOM_CBR.NUM_OF_CHQ_LVS%TYPE;
REQID           CUSTOM.CUSTOM_CBR.REQ_ID%TYPE;
DNLD_ID         CUSTOM.CUSTOM_CBR.Download_id%TYPE;
REQDATE         CUSTOM.CUSTOM_CBR.REQ_DATE%TYPE;
NOOFLVS            NUMBER(8);
vCHSSR            VARCHAR2(8);
vCHQBOOKS        VARCHAR2(2);
vREQID                VARCHAR2(6);
vREQDATE            VARCHAR2(10);
vDNLD_ID            VARCHAR2(6);
vENDNO              NUMBER(8);
vENDNO1            VARCHAR2(8);
SCHMCODE            VARCHAR2(10);
SCHMDESC            VARCHAR2(25);
lenBRADDRESS        NUMBER(2);
lenCUSTNAME        NUMBER(2);
MICR_BRCODE        TBAADM.BCT.BR_CODE%TYPE;
BR_CITY_CODE     TBAADM.BCT.BR_CITY_CODE%TYPE;
BR_CITY_NAME    TBAADM.RCT.REF_DESC%TYPE;
vTrancode        VARCHAR2(2); 
bankID            CUSTOM.CUSTOM_CBR.bank_id%TYPE;
BID                        TBAADM.GAM.bank_id%type;

BEGIN
    out_desc    :=NULL;
    out_retCode :=0;

    IF NOT Get_Account%ISOPEN THEN
        TBAADM.BASP0099.formInputArr (inp_str,OutArr);
        StartDate         := TO_DATE(OutArr(0),'DD-MM-YYYY');
        EndDate            :=TO_DATE(OutArr(1),'DD-MM-YYYY');
        SOL                := trim(OutArr(2));
        DWNLOADID         := trim(OutArr(3));
        BID                := trim(OutArr(24));
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
        FROM    TBAADM.gam
        WHERE    foracid = FORACID1
        and bank_id = bankID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            SOLID         := NULL;
            ACCTCRNCY     := NULL;
            SCHMTYPE     := NULL;
            SCHMCODE    := NULL;
    END;
    
        SCHMTYPE := trim(SCHMTYPE);
        SCHMCODE := trim(SCHMCODE);
        
    BEGIN
                SELECT  schm_desc
                INTO SCHMDESC
                FROM   TBAADM.gsp
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
        FROM    TBAADM.sol
        WHERE    sol_id = SOLID
        and bank_id = bankID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            BRCODE         := NULL;
            BANKCODE     := NULL;
    END;
    
    BRCODE    := trim(BRCODE);
    BANKCODE:= trim(BANKCODE);
    
    BEGIN
        SELECT    bank_code,br_name,br_addr_1,bct.BR_CITY_CODE,CLG_REF_CODE,CLG_REP_CODE
        INTO    BANKCODE,BRNAME,BRADDRESS,BR_CITY_CODE,REGIONCODE,REPCODE
        FROM    TBAADM.bct
        WHERE    br_code = BRCODE AND bank_code = BANKCODE
        and bank_id = bankID;

        SELECT    RCT.REF_DESC
        INTO    BR_CITY_NAME
        FROM    TBAADM.RCT
        WHERE    RCT.ref_rec_type = '01'
        AND        RCT.ref_code= BR_CITY_CODE
        and bank_id = bankID;

        BR_CITY_NAME := trim(BR_CITY_NAME);
        BRADDRESS := trim(BRADDRESS);
        BRADDRESS := BRADDRESS ;
        lenBRADDRESS := LENGTH(BRADDRESS);
        REGIONCODE   :=  REGIONCODE;
        REPCODE        :=   REPCODE;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            BANKCODE     := NULL;
            BRNAME         := NULL;
            BRADDRESS     := NULL;
    END;
    BEGIN

--  The following section was modified by Peter Gachau on 26-Aug-2006

        SELECT    acct_name
        INTO    CUSTNAME
        FROM    TBAADM.gam
        WHERE    foracid = FORACID1
        and bank_id = bankID;

        CUSTNAME     := trim(CUSTNAME);
        lenCUSTNAME := LENGTH(CUSTNAME);
        EXCEPTION

-- End of modification by Gachau

            WHEN NO_DATA_FOUND THEN
            CUSTNAME := NULL;
    END;

    IF (lenCUSTNAME > 80) THEN
    BEGIN
        SELECT acct_short_name
        INTO CUSTNAME
        FROM TBAADM.gam
        WHERE   foracid  = FORACID1
        and bank_id = bankID;
        CUSTNAME := trim(CUSTNAME);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        CUSTNAME := NULL;
    END;
    END IF;


    BEGIN
        SELECT    RCRE_USER_ID,AUTH_USER_ID,LPAD(NUM_OF_CHQ_LVS,3,0),NUM_OF_CHB,REQ_DATE
        INTO    RCREID,AUTHID,CHQLVS,CHQBOOKS,REQDATE
        FROM    CUSTOM.CUSTOM_CBR
        WHERE    req_id = REQID
        and bank_id = bankID;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            RCREID     := NULL;
            AUTHID     := NULL;
            CHQLVS     := NULL;
            CHQBOOKS:= NULL;
            REQDATE:= NULL;
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
    ---Start inculusions by eric for delarue customization
   IF (SCHMTYPE ='SBA') THEN
        vTrancode :='10';
        IF (ACCTCRNCY='UGX') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '01';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '05';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '09';
            END IF ;
        END IF;
        
        IF (ACCTCRNCY='KES') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '46';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '50';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '54';
            END IF ;
        END IF;
        IF (ACCTCRNCY='USD') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '02';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '06';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '10';
            END IF ;
        END IF;
        IF (ACCTCRNCY='GBP') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '04';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '08';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '12';
            END IF ;
        END IF;
        IF (ACCTCRNCY='EUR') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '03';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '07';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '11';
            END IF ;
        END IF;
        IF (SCHMCODE = 'SB190') THEN
             vTrancode    :='10';
             IF (ACCTCRNCY='UGX') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '01';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '05';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '09';
            END IF ;
        END IF;
        
        IF (ACCTCRNCY='KES') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '46';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '50';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '54';
            END IF ;
        END IF;
        IF (ACCTCRNCY='USD') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '02';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '06';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '10';
            END IF ;
        END IF;
        IF (ACCTCRNCY='GBP') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '04';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '08';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '12';
            END IF ;
        END IF;
        IF (ACCTCRNCY='EUR') THEN
            IF (CHQLVS ='25') THEN
               BKSTYLE := '03';
            END IF ;
            IF (CHQLVS ='50') THEN
               BKSTYLE := '07';
            END IF ;
            IF (CHQLVS ='100') THEN
               BKSTYLE := '11';
            END IF ;
        END IF;
    END IF;
    END IF;
    IF (SCHMTYPE ='CAA') THEN
       IF (SCHMCODE = 'CA201') THEN
             vTrancode    :='11';
          IF (ACCTCRNCY='UGX') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE := '01';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE := '05';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '09';
             END IF;
          END IF;
             IF (ACCTCRNCY='KES') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE := '21';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE := '22';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '24';
             END IF;
          END IF;
          IF (ACCTCRNCY='EUR') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE :='03';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE := '07';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '11';
             END IF;
          END IF;
          IF (ACCTCRNCY='GBP') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE := '04';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE :='08';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '12';
             END IF;
          END IF;
          IF (ACCTCRNCY='USD') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE := '02';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE := '06';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '10';
             END IF;
         END IF;
       ELSE
             vTrancode    :='11';
          IF (ACCTCRNCY='UGX') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE := '01';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE := '05';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '13';
             END IF;
          END IF;
             IF (ACCTCRNCY='KES') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE := '21';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE := '22';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '24';
             END IF;
          END IF;
          IF (ACCTCRNCY='EUR') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE :='03';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE := '07';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '15';
             END IF;
          END IF;
          IF (ACCTCRNCY='GBP') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE := '04';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE :='08';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '16';
             END IF;
          END IF;
          IF (ACCTCRNCY='USD') THEN
               IF (CHQLVS ='25') THEN
                 BKSTYLE := '02';
             END IF;
             IF (CHQLVS ='50') THEN
                 BKSTYLE := '06';
             END IF;
             IF (CHQLVS ='100') THEN
                 BKSTYLE := '14';
             END IF;
         END IF;
    END IF;
END IF;

        ---END  inculusions by eric for delarue customization

    UPDATE CUSTOM.CUSTOM_CBR SET DOWNLOAD_ID = DWNLOADID,req_status = 'S' WHERE req_id = REQID and bank_id = bankID;
    COMMIT;

    BEGIN
        SELECT LPAD(BEGIN_CHQ_NUM,6,0),DOWNLOAD_ID
        INTO    CHQSSR,DNLD_ID
        FROM    CUSTOM.CUSTOM_CBR
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
        FROM CUSTOM.custom_cbr
        WHERE REQ_ID=REQID
        and bank_id = bankID;
        EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        vENDNO := NULL;
    END;
    BEGIN
        SELECT    SUBSTR(MICR_BRANCH_CODE,2,'2')
        INTO    MICR_BRCODE
        FROM    TBAADM.BCT
        WHERE    BCT.BR_CODE = BRCODE
        AND        BCT.BANK_CODE = BANKCODE
        and bank_id = bankID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            MICR_BRCODE := '000';
    END;


    SORTCODE    := REGIONCODE||'1'||BANKCODE||'1'||MICR_BRCODE;
    NOOFLVS        := CHQSSR + CHQBOOKS * CHQLVS;

    EQUITYCommonPack.GETCHQDIGIT(FORACID1,SORTCODE,CHQDIGIT);

    vCHSSR         :=    RPAD(CHQSSR,6,' ');
    vDNLD_ID    :=  DNLD_ID;
    vDNLD_ID    :=  trim(vDNLD_ID);
    vDNLD_ID    :=  LPAD(vDNLD_ID,6,'0');
    vCHQBOOKS      :=  CHQBOOKS;
    SORTCODE     :=     RPAD(SORTCODE,5,' ');
    CHQDIGIT     :=     LPAD(CHQDIGIT,2,'0');
    CHQVDIGIT     :=     RPAD(CHQVDIGIT,2,' ');
    CRVDIGIT     :=  RPAD(CRVDIGIT,2,' ');
    BKSTYLE     :=  RPAD(BKSTYLE,3,' ');
    vCHQBOOKS     :=  LPAD(CHQBOOKS,2,'0');
    vENDNO1        :=  LPAD(vENDNO,6,'0');
    CUSTNAME    :=  trim(CUSTNAME);
    BRNAME         :=  RPAD(BRNAME,25,' ');
    BRADDRESS     :=  RPAD(BRADDRESS,23,' ');
    RCREID         :=  RPAD(RCREID,8,' ');
    AUTHID         :=  RPAD(AUTHID,8,' ');
    vREQDATE    :=  SUBSTR(REQDATE,7,4)||SUBSTR(REQDATE,3,3)||'-'||SUBSTR(REQDATE,1,2);

--    out_desc := '681'||' '||'68'||RPAD(solid||''||SUBSTR(FORACID1,4),13,' ')||CHQDIGIT||vTrancode||trim(BKSTYLE)||vCHQBOOKS||RPAD(vCHSSR,6,' ')||RPAD(CUSTNAME,80,' ')||RPAD(BRNAME,30,' ')||RPAD(BRADDRESS,30,' ')||RPAD(FORACID1,15,' ');
--    out_desc := '471'||'  '||REGIONCODE||'47'||SUBSTR(solid,3,'2')||SUBSTR(FORACID1,4)||REPCODE||vTrancode||trim(BKSTYLE)||vCHQBOOKS||RPAD(vCHSSR,6,' ')||RPAD(CUSTNAME,80,' ')||RPAD(BRNAME,30,' ')||RPAD(BRADDRESS,30,' ')||RPAD(FORACID1,15,' ')||'        ';
--    out_desc := '301'||'|'||'30'||'|'||SUBSTR(solid,3)||'|'||REGIONCODE||'|'||SUBSTR(FORACID1,4)||'|'||LPAD(CHQDIGIT,2,'0')||'|'||vTrancode||'|'||trim(BKSTYLE)||'|'||vCHQBOOKS||'|'||RPAD(vCHSSR,6,' ')||'|'||RPAD(CUSTNAME,80,' ')||'|'||RPAD(BRNAME,30,' ')||'|'||RPAD(BRADDRESS,30,' ')||'|'||RPAD(FORACID1,15,' ');
    out_desc := '301'||' '||'30'||SUBSTR(solid,3)||REGIONCODE||SUBSTR(FORACID1,4)||LPAD(CHQDIGIT,2,'0')||vTrancode||trim(BKSTYLE)||vCHQBOOKS||RPAD(vCHSSR,6,' ')||RPAD(CUSTNAME,80,' ')||RPAD(BRNAME,30,' ')||RPAD(BRADDRESS,30,' ')||RPAD(FORACID1,15,' ');
END Getchqdetaildwnldcaa;

END Getchqdetaildwnldcaa_56;
/
GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDWNLDCAA_56 TO TBAADM;
GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDWNLDCAA_56 TO TBAGEN;
GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDWNLDCAA_56 TO TBAUTIL;
