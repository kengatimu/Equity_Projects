--DROP PACKAGE CUSTOM.GETCHQDETAILDUPDWNLD_11;

CREATE OR REPLACE PACKAGE CUSTOM.GETCHQDETAILDUPDWNLD_11 AS
PROCEDURE GETCHQDETAILDUPDWNLD( inp_str IN VARCHAR2,
            out_retCode OUT NUMBER,
            out_desc OUT VARCHAR2);
END GETCHQDETAILDUPDWNLD_11;
/


GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDUPDWNLD_11 TO TBAADM;

GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDUPDWNLD_11 TO TBAGEN;

GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDUPDWNLD_11 TO TBAUTIL;


DROP PACKAGE BODY CUSTOM.GETCHQDETAILDUPDWNLD_11;

CREATE OR REPLACE PACKAGE BODY CUSTOM.GETCHQDETAILDUPDWNLD_11 AS
DWNLOADID       varchar2(5);
SOL                TBAADM.gam.sol_id%type;
OutArr          TBAADM.BASP0099.ArrayType;
SolId           TBAADM.gam.sol_id%type;
CustId          TBAADM.gam.cust_id%type;
SORTCODE        varchar2(15);
custnameNum        number(8);
CHQDIGIT        number(2);
CHQVDIGIT        CUSTOM.CUSTOM_CCY.CHQ_VCH%type;
CRVDIGIT        CUSTOM.CUSTOM_CCY.CR_VCH%type;
BKSTYLE             CUSTOM.CUSTOM_CCY.BOOK_STYLE%type;
CHQBOOKS        CUSTOM.CUSTOM_CBR.NUM_OF_CHB%type;
CHQSSR            CUSTOM.CUSTOM_CBR.begin_chq_num%type;
CUSTNAME        TBAADM.GAM.acct_name%type;
BRNAME            TBAADM.BCT.BR_NAME%type;
BRADDRESS        TBAADM.BCT.BR_ADDR_1%type;
RCREID            CUSTOM.CUSTOM_CBR.RCRE_USER_ID%type;
AUTHID            CUSTOM.CUSTOM_CBR.AUTH_USER_ID%type;
FORACID1        TBAADM.gam.foracid%type;
BANKCODE        TBAADM.bct.bank_code%type;
BRCODE            TBAADM.bct.br_code%type;
ACCTCRNCY       TBAADM.gam.acct_crncy_code%type;
SCHMTYPE        TBAADM.gam.schm_type%type;
CHQLVS          CUSTOM.CUSTOM_CBR.NUM_OF_CHQ_LVS%type;
REQID           CUSTOM.CUSTOM_CBR.req_id%type;
REQDATE         CUSTOM.CUSTOM_CBR.REQ_DATE%TYPE;
DNLD_ID         CUSTOM.CUSTOM_CBR.Download_id%TYPE;
vREQDATE        varchar2(10);
vREQID            varchar2(6);
vDNLD_ID        VARCHAR2(6);
vCHSSR          varchar2(8);
vCHQBOOKS       varchar2(2);
lenBRADDRESS    number(2);
lenCUSTNAME     number(2);
MICR_BRCODE        TBAADM.BCT.BR_CODE%TYPE;
BR_CITY_CODE     TBAADM.BCT.BR_CITY_CODE%TYPE;
BR_CITY_NAME    TBAADM.RCT.REF_DESC%TYPE;
bankID            CUSTOM.CUSTOM_CBR.bank_id%TYPE;
SCMTYPE1           VARCHAR2(10); 
ACTCRNCY1         VARCHAR2(10);
ACTCRNCY2       VARCHAR2(10);
ACTCRNCY3       VARCHAR2(10);
ACTCRNCY4       VARCHAR2(10);
SCMCODE1        VARCHAR2(10);
ACTCRNCY5       VARCHAR2(10);
ACTCRNCY6       VARCHAR2(10);
ACTCRNCY7        VARCHAR2(10);    
ACTCRNCY8        VARCHAR2(10);
SCMTYPE2        VARCHAR2(10);
SCMCODE2        VARCHAR2(10);
ACTCRNCY9        VARCHAR2(10);
ACTCRNCY10      VARCHAR2(10);
ACTCRNCY11        VARCHAR2(10);
ACTCRNCY12      VARCHAR2(10);
ACTCRNCY13        VARCHAR2(10);
ACTCRNCY14      VARCHAR2(10);
ACTCRNCY15        VARCHAR2(10);
ACTCRNCY16        VARCHAR2(10);
refCode        VARCHAR2(10);
micrCode        VARCHAR2(10);
BID            VARCHAR2(8);


cursor Get_Account1 (downloadid varchar,SOL varchar,BID varchar) is
    select  distinct CUSTOM_CBR.req_id,CUSTOM_CBR.foracid,bank_id 
    from    CUSTOM.CUSTOM_CBR
    where   trim(download_id) = trim(downloadid)
--    and        trim(branch_id) = trim(SOL)
      and CUSTOM.CUSTOM_CBR.bank_id = BID
    order by CUSTOM_CBR.req_id;

        
PROCEDURE GETCHQDETAILDUPDWNLD( inp_str IN VARCHAR2,
out_retCode OUT NUMBER,
out_desc OUT VARCHAR2) AS
BEGIN
    out_desc    :=NULL;
    out_retCode :=0;
    TBAADm.BASP0099.formInputArr (inp_str,OutArr);
        DWNLOADID         := trim(OutArr(0));
        SOL            := OutArr(1);
        BID             := OutArr(2);


    IF NOT Get_Account1%ISOPEN then
    dbms_output.put_line('out_desc ');
        OPEN Get_Account1(DWNLOADID,SOL,BID);
    END IF;

    FETCH Get_Account1 into  REQID,FORACID1,bankID;

    IF Get_Account1%NOTFOUND then
        Close Get_Account1;
        out_retCode :=1;
    END IF;
    REQID    :=trim(REQID);

    FORACID1    := trim(FORACID1);

begin
    select    cust_id,sol_id,acct_crncy_code,schm_type
    into    CUSTID,SOLID,ACCTCRNCY,SCHMTYPE
    from    TBAADM.gam
    where    foracid = FORACID1
    and bank_id = bankID;
    exception
        when no_data_found then
        CUSTID        := null;
        SOLID         := null;
        ACCTCRNCY     := null;
        SCHMTYPE     := null;
end;

    SOLID        := trim(SOLID);
    ACCTCRNCY    := trim(ACCTCRNCY);
    SCHMTYPE    := trim(SCHMTYPE);

begin
    select    br_code,bank_code
    into    BRCODE,BANKCODE
    from    TBAADM.sol
    where    sol_id = SOLID;
    exception
        when no_data_found then
        BRCODE         := null;
        BANKCODE     := null;
end;

    BRCODE        := trim(BRCODE);
    BANKCODE     := trim(BANKCODE);
    SELECT 
       CUSTOM.getCparamValue('REFCODE','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('MICRBR','CHQBKMNCE',bankID),
       CUSTOM.getCparamValue('CUSTNAME1','CHQBKMNCE',bankID)

    INTO
       refCode,
       micrCode,
       custnameNum

    FROM DUAL;

begin
    select    bank_code,br_name,br_addr_1,bct.BR_CITY_CODE
    into    BANKCODE,BRNAME,BRADDRESS,BR_CITY_CODE
    from    TBAADM.bct
    where    br_code = BRCODE and bank_code = BANKCODE
       and bank_id = bankID;
     
    SELECT    RCT.REF_DESC
    INTO    BR_CITY_NAME
    FROM    TBAADM.RCT
    WHERE    RCT.ref_rec_type = refCode
    AND        RCT.ref_code= BR_CITY_CODE
      and bank_id = bankID ;

    BR_CITY_NAME := trim(BR_CITY_NAME);
    BRADDRESS := trim(BRADDRESS);
    BRADDRESS := BRADDRESS ||' '||BR_CITY_NAME;
    lenBRADDRESS     := length(BRADDRESS);

--------------------------------------------------------------------------------
-- If address more than 30 characters, truncate it.
--------------------------------------------------------------------------------
--    IF (lenBRADDRESS > 30) then
--        BRADDRESS := substr(BRADDRESS,1,30);
--    END IF;

    exception
        when no_data_found then
        BANKCODE     := null;
        BRNAME         := null;
        BRADDRESS     := null;
end;

begin
    select    acct_name
    into    CUSTNAME
    from    TBAADM.gam
    where    foracid = FORACID1
    and bank_id = bankID;

    CUSTNAME     := trim(CUSTNAME);
    lenCUSTNAME := length(CUSTNAME);
    exception
        when no_data_found then
        CUSTNAME := null;
end;

IF (lenCUSTNAME >= custnameNum) then
begin
    select acct_short_name
    into CUSTNAME
    from TBAADM.gam
    where   foracid = FORACID1
    and bank_id = bankID;

    CUSTNAME := trim(CUSTNAME);
    exception
        when no_data_found then
        CUSTNAME := null;
        end;
END IF;

begin
    select    RCRE_USER_ID,AUTH_USER_ID,lpad(NUM_OF_CHQ_LVS,3,0),NUM_OF_CHB,BEGIN_CHQ_NUM,REQ_DATE,DOWNLOAD_ID
    into    RCREID,AUTHID,CHQLVS,CHQBOOKS,vCHSSR,REQDATE,DNLD_ID
    from    CUSTOM.CUSTOM_CBR
    where    req_id = REQID
    and bank_id = bankID;
    exception
        when no_data_found then
        RCREID     := null;
        AUTHID     := null;
        CHQLVS     := null;
        CHQBOOKS:= null;
        REQDATE:= null;
        DNLD_ID := null;
end;

    CHQLVS := trim(CHQLVS);
    REQDATE := trim(REQDATE);

begin
    select    book_style,chq_vch,cr_vch
    into    BKSTYLE,CHQVDIGIT,CRVDIGIT
    from    CUSTOM.CUSTOM_CCY
    where    crncy_code=ACCTCRNCY
    and     schm_type = SCHMTYPE
    and bank_id = bankID
    and    no_of_lvs=CHQLVS;
    exception
        when no_data_found then
        BKSTYLE        := null;
        CHQVDIGIT    := null;
        CRVDIGIT    := null;
end;
    BEGIN
        SELECT    MICR_BRANCH_CODE
        INTO    MICR_BRCODE
        FROM    TBAADM.BCT
        WHERE    BCT.BR_CODE = BRCODE
        AND        BCT.BANK_CODE = BANKCODE
        and bank_id = bankID;
    EXCEPTION
        WHEN no_data_found then
            MICR_BRCODE := micrCode;
    END;

    SORTCODE    := BANKCODE||''||MICR_BRCODE;
-----------------------------------------------------------------------------------
-- Gets the cheque digit.
-----------------------------------------------------------------------------------

     EQUITYCommonPack.GETCHQDIGIT(FORACID1,SORTCODE,CHQDIGIT);

--    FORACID1    := substr(FORACID1,4,9);

    vCHQBOOKS      :=     CHQBOOKS;
--    vREQID      :=  REQID;
--    vREQID      :=  trim(vREQID);
--    vREQID      :=  lpad(vREQID,6,'0');
    vDNLD_ID    :=  DNLD_ID;
    vDNLD_ID    :=  trim(vDNLD_ID);
    vDNLD_ID    :=  lpad(vDNLD_ID,6,'0');
    FORACID1    :=  substr(FORACID1,4,10);
    FORACID1    :=  lpad(FORACID1,10,' ');
    SORTCODE    :=  rpad(SORTCODE,5,' ');
    CHQDIGIT    :=  rpad(CHQDIGIT,1,' ');
    CHQVDIGIT   :=  rpad(CHQVDIGIT,2,' ');
    CRVDIGIT    :=  rpad(CRVDIGIT,2,' ');
    BKSTYLE     :=  rpad(BKSTYLE,3,' ');
    vCHQBOOKS   :=  lpad(CHQBOOKS,1,'0');
--    vCHSSR      :=  rpad(vCHSSR,6,'0');
    vCHSSR      :=  lpad(vCHSSR,6,'0');
    CUSTNAME    :=  rpad(CUSTNAME,45,' ');
    BRNAME      :=  rpad(BRNAME,25,' ');
    BRADDRESS   :=  rpad(BRADDRESS,23,' ');
    RCREID      :=  rpad(RCREID,8,' ');
    AUTHID      :=  rpad(AUTHID,8,' ');
    vREQDATE    :=  substr(REQDATE,1,6)||substr(REQDATE,8,3);

--------------------------------------------------------------------------------
-- Write to the file in the specified format.
--------------------------------------------------------------------------------
--    out_desc := FORACID1||'01'||'1'||'1'||SORTCODE||FORACID1||CHQDIGIT||CHQVDIGIT||CRVDIGIT||BKSTYLE||vCHQBOOKS||vCHSSR||'000000'||CUSTNAME||BRNAME||BRADDRESS||'0'||RCREID||AUTHID||'A'||' ';

--    out_desc := FORACID1||'|'||CUSTNAME||'|'||BRCODE||'|'||BRNAME||'|'||BRADDRESS||'|'||vCHQBOOKS||'|'||vCHSSR||'|'||CHQLVS ;
    out_desc := vCHQBOOKS||' '||BKSTYLE||' '||vCHSSR||'    '||BANKCODE||BRCODE||CHQDIGIT||' '||FORACID1||' '||CUSTNAME||BANKCODE||BRCODE||' '||BRNAME||BRADDRESS||'  '||vREQDATE||' '||vDNLD_ID||'  ' ;

END GETCHQDETAILDUPDWNLD;
End GETCHQDETAILDUPDWNLD_11;
/


GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDUPDWNLD_11 TO TBAADM;

GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDUPDWNLD_11 TO TBAGEN;

GRANT EXECUTE, DEBUG ON CUSTOM.GETCHQDETAILDUPDWNLD_11 TO TBAUTIL;
