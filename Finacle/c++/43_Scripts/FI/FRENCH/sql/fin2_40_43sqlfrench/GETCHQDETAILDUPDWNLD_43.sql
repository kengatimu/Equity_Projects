 CREATE OR REPLACE PACKAGE BODY CUSTOM.GETCHQDETAILDUPDWNLD_43
AS
   DWNLOADID      VARCHAR2 (5);
   SOL            TBAADM.gam.sol_id%TYPE;
   OutArr         TBAADM.BASP0099.ArrayType;
   SolId          TBAADM.gam.sol_id%TYPE;
   CustId         TBAADM.gam.cust_id%TYPE;
   SORTCODE       VARCHAR2 (15);
   custnameNum    NUMBER (8);
   CHQDIGIT       NUMBER (2);
   CHQVDIGIT      CUSTOM.CUSTOM_CCY.CHQ_VCH%TYPE;
   CRVDIGIT       CUSTOM.CUSTOM_CCY.CR_VCH%TYPE;
   BKSTYLE        CUSTOM.CUSTOM_CCY.BOOK_STYLE%TYPE;
   CHQBOOKS       CUSTOM.CUSTOM_CBR.NUM_OF_CHB%TYPE;
   CHQSSR         CUSTOM.CUSTOM_CBR.begin_chq_num%TYPE;
   CUSTNAME       TBAADM.GAM.acct_name%TYPE;
   BRNAME         TBAADM.BCT.BR_NAME%TYPE;
   BRADDRESS      TBAADM.BCT.BR_ADDR_1%TYPE;
   RCREID         CUSTOM.CUSTOM_CBR.RCRE_USER_ID%TYPE;
   AUTHID         CUSTOM.CUSTOM_CBR.AUTH_USER_ID%TYPE;
   FORACID1       TBAADM.gam.foracid%TYPE;
   BANKCODE       TBAADM.bct.bank_code%TYPE;
   BRCODE         TBAADM.bct.br_code%TYPE;
   ACCTCRNCY      TBAADM.gam.acct_crncy_code%TYPE;
   SCHMTYPE       TBAADM.gam.schm_type%TYPE;
   CHQLVS         CUSTOM.CUSTOM_CBR.NUM_OF_CHQ_LVS%TYPE;
   REQID          CUSTOM.CUSTOM_CBR.req_id%TYPE;
   REQDATE        CUSTOM.CUSTOM_CBR.REQ_DATE%TYPE;
   DNLD_ID        CUSTOM.CUSTOM_CBR.Download_id%TYPE;
   vREQDATE       VARCHAR2 (10);
   vREQID         VARCHAR2 (6);
   vDNLD_ID       VARCHAR2 (6);
   vCHSSR         VARCHAR2 (8);
   vCHQBOOKS      VARCHAR2 (2);
   lenBRADDRESS   NUMBER (2);
   lenCUSTNAME    NUMBER (2);
   MICR_BRCODE    TBAADM.BCT.BR_CODE%TYPE;
   BR_CITY_CODE   TBAADM.BCT.BR_CITY_CODE%TYPE;
   BR_CITY_NAME   TBAADM.RCT.REF_DESC%TYPE;
   bankID         CUSTOM.CUSTOM_CBR.bank_id%TYPE;
   SCMTYPE1       VARCHAR2 (10);
   ACTCRNCY1      VARCHAR2 (10);
   ACTCRNCY2      VARCHAR2 (10);
   ACTCRNCY3      VARCHAR2 (10);
   ACTCRNCY4      VARCHAR2 (10);
   SCMCODE1       VARCHAR2 (10);
   ACTCRNCY5      VARCHAR2 (10);
   ACTCRNCY6      VARCHAR2 (10);
   ACTCRNCY7      VARCHAR2 (10);
   ACTCRNCY8      VARCHAR2 (10);
   SCMTYPE2       VARCHAR2 (10);
   SCMCODE2       VARCHAR2 (10);
   ACTCRNCY9      VARCHAR2 (10);
   ACTCRNCY10     VARCHAR2 (10);
   ACTCRNCY11     VARCHAR2 (10);
   ACTCRNCY12     VARCHAR2 (10);
   ACTCRNCY13     VARCHAR2 (10);
   ACTCRNCY14     VARCHAR2 (10);
   ACTCRNCY15     VARCHAR2 (10);
   ACTCRNCY16     VARCHAR2 (10);
   refCode        VARCHAR2 (10);
   micrCode       VARCHAR2 (10);
   BID            VARCHAR2 (8);
   NUMBEROFREC    NUMBER (10);
   FOOTERCNT NUMBER(5);
   FOOTER VARCHAR2 (200);
   HEADERFORFILE VARCHAR2 (200);
   ORDERREC NUMBER(6) DEFAULT 0;
   CHQBKORDERED NUMBER(6) DEFAULT 0;
   BIDFORHEADER VARCHAR2(2);

   CURSOR Get_Account1 (
      downloadid    VARCHAR,
      SOL           VARCHAR,
      BID           VARCHAR)
   IS
        SELECT DISTINCT CUSTOM_CBR.req_id, CUSTOM_CBR.foracid, bank_id
          FROM CUSTOM.CUSTOM_CBR
         WHERE TRIM (download_id) = TRIM (downloadid) --    and        trim(branch_id) = trim(SOL)
               AND CUSTOM.CUSTOM_CBR.bank_id = BID
      ORDER BY CUSTOM_CBR.req_id;
      
   PROCEDURE GETCHQDETAILDUPDWNLD (inp_str       IN     VARCHAR2,
                                   out_retCode      OUT NUMBER,
                                   out_desc         OUT VARCHAR2)
   AS
   BEGIN
      out_desc := NULL;
      out_retCode := 0;
      TBAADm.BASP0099.formInputArr (inp_str, OutArr);
      DWNLOADID := TRIM (OutArr (0));
      SOL := OutArr (1);
      BID := OutArr (2);
      
      SELECT COUNT(*)  INTO FOOTERCNT FROM (
      SELECT DISTINCT CUSTOM_CBR.req_id, CUSTOM_CBR.foracid, bank_id
          FROM CUSTOM.CUSTOM_CBR
         WHERE TRIM (download_id) = TRIM (DWNLOADID) --    and        trim(branch_id) = trim(SOL)
               AND CUSTOM.CUSTOM_CBR.bank_id = BID
      ORDER BY CUSTOM_CBR.req_id);

		if (BID = '50') then
			BIDFORHEADER := '85';
		else
			BIDFORHEADER := '30';
		end if;
		
		SELECT RPAD(BIDFORHEADER||'0' || TO_CHAR(SYSDATE,'DD/MM/YY') || 'TD' || DWNLOADID,200,' ') INTO HEADERFORFILE FROM DUAL;
     
      IF NOT Get_Account1%ISOPEN
      THEN
         DBMS_OUTPUT.put_line ('out_desc ');

         OPEN Get_Account1 (DWNLOADID, SOL, BID);
      END IF;


      FETCH Get_Account1
      INTO REQID, FORACID1, bankID;

      IF Get_Account1%FOUND
      THEN
         NUMBEROFREC := Get_Account1%ROWCOUNT;
      END IF;

      IF Get_Account1%NOTFOUND
      THEN
         CLOSE Get_Account1;

         out_retCode := 1;
      END IF;



      REQID := TRIM (REQID);

      FORACID1 := TRIM (FORACID1);

      BEGIN
         SELECT cust_id,
                sol_id,
                acct_crncy_code,
                schm_type
           INTO CUSTID,
                SOLID,
                ACCTCRNCY,
                SCHMTYPE
           FROM TBAADM.gam
          WHERE foracid = FORACID1 AND bank_id = bankID;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            CUSTID := NULL;
            SOLID := NULL;
            ACCTCRNCY := NULL;
            SCHMTYPE := NULL;
      END;

      SOLID := TRIM (SOLID);
      ACCTCRNCY := TRIM (ACCTCRNCY);
      SCHMTYPE := TRIM (SCHMTYPE);

      BEGIN
         SELECT br_code, bank_code
           INTO BRCODE, BANKCODE
           FROM TBAADM.sol
          WHERE sol_id = SOLID;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            BRCODE := NULL;
            BANKCODE := NULL;
      END;

      BRCODE := TRIM (BRCODE);
      BANKCODE := TRIM (BANKCODE);

      SELECT CUSTOM.getCparamValue ('REFCODE', 'CHQBKMNCE', bankID),
             CUSTOM.getCparamValue ('MICRBR', 'CHQBKMNCE', bankID),
             CUSTOM.getCparamValue ('CUSTNAME1', 'CHQBKMNCE', bankID)
        INTO refCode, micrCode, custnameNum
        FROM DUAL;

      BEGIN
         SELECT bank_code,
                br_name,
                br_addr_1,
                bct.BR_CITY_CODE
           INTO BANKCODE,
                BRNAME,
                BRADDRESS,
                BR_CITY_CODE
           FROM TBAADM.bct
          WHERE     br_code = BRCODE
                AND bank_code = BANKCODE
                AND bank_id = bankID;

         SELECT RCT.REF_DESC
           INTO BR_CITY_NAME
           FROM TBAADM.RCT
          WHERE     RCT.ref_rec_type = refCode
                AND RCT.ref_code = BR_CITY_CODE
                AND bank_id = bankID;

         BR_CITY_NAME := TRIM (BR_CITY_NAME);
         BRADDRESS := TRIM (BRADDRESS);
         BRADDRESS := BRADDRESS || ' ' || BR_CITY_NAME;
         lenBRADDRESS := LENGTH (BRADDRESS);
      --------------------------------------------------------------------------------
      -- If address more than 30 characters, truncate it.
      --------------------------------------------------------------------------------
      --    IF (lenBRADDRESS > 30) then
      --        BRADDRESS := substr(BRADDRESS,1,30);
      --    END IF;

      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            BANKCODE := NULL;
            BRNAME := NULL;
            BRADDRESS := NULL;
      END;

      BEGIN
         SELECT acct_name
           INTO CUSTNAME
           FROM TBAADM.gam
          WHERE foracid = FORACID1 AND bank_id = bankID;

         CUSTNAME := TRIM (CUSTNAME);
         lenCUSTNAME := LENGTH (CUSTNAME);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            CUSTNAME := NULL;
      END;

      IF (lenCUSTNAME >= custnameNum)
      THEN
         BEGIN
            SELECT acct_short_name
              INTO CUSTNAME
              FROM TBAADM.gam
             WHERE foracid = FORACID1 AND bank_id = bankID;

            CUSTNAME := TRIM (CUSTNAME);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               CUSTNAME := NULL;
         END;
      END IF;

      BEGIN
         SELECT RCRE_USER_ID,
                AUTH_USER_ID,
                LPAD (NUM_OF_CHQ_LVS, 3, 0),
                NUM_OF_CHB,
                BEGIN_CHQ_NUM,
                REQ_DATE,
                DOWNLOAD_ID
           INTO RCREID,
                AUTHID,
                CHQLVS,
                CHQBOOKS,
                vCHSSR,
                REQDATE,
                DNLD_ID
           FROM CUSTOM.CUSTOM_CBR
          WHERE req_id = REQID AND bank_id = bankID;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RCREID := NULL;
            AUTHID := NULL;
            CHQLVS := NULL;
            CHQBOOKS := NULL;
            REQDATE := NULL;
            DNLD_ID := NULL;
      END;

      CHQLVS := TRIM (CHQLVS);
      REQDATE := TRIM (REQDATE);
      CHQBKORDERED := CHQBKORDERED + CHQBOOKS;

      BEGIN
         SELECT book_style, chq_vch, cr_vch
           INTO BKSTYLE, CHQVDIGIT, CRVDIGIT
           FROM CUSTOM.CUSTOM_CCY
          WHERE     crncy_code = ACCTCRNCY
                AND schm_type = SCHMTYPE
                AND bank_id = bankID
                AND no_of_lvs = CHQLVS;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            BKSTYLE := NULL;
            CHQVDIGIT := NULL;
            CRVDIGIT := NULL;
      END;

      BEGIN
         SELECT MICR_BRANCH_CODE
           INTO MICR_BRCODE
           FROM TBAADM.BCT
          WHERE     BCT.BR_CODE = BRCODE
                AND BCT.BANK_CODE = BANKCODE
                AND bank_id = bankID;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            MICR_BRCODE := micrCode;
      END;

      SORTCODE := BANKCODE || '' || MICR_BRCODE;
      -----------------------------------------------------------------------------------
      -- Gets the cheque digit.
      -----------------------------------------------------------------------------------

      EQUITYCommonPack.GETCHQDIGIT (FORACID1, SORTCODE, CHQDIGIT);

      --    FORACID1    := substr(FORACID1,4,9);

      vCHQBOOKS := CHQBOOKS;
      --    vREQID      :=  REQID;
      --    vREQID      :=  trim(vREQID);
      --    vREQID      :=  lpad(vREQID,6,'0');
      vDNLD_ID := DNLD_ID;
      vDNLD_ID := TRIM (vDNLD_ID);
      vDNLD_ID := LPAD (vDNLD_ID, 6, '0');
      FORACID1 := SUBSTR (FORACID1, 4, 10);
      FORACID1 := LPAD (FORACID1, 10, ' ');
      SORTCODE := RPAD (SORTCODE, 5, ' ');
      CHQDIGIT := RPAD (CHQDIGIT, 1, ' ');
      CHQVDIGIT := RPAD (CHQVDIGIT, 2, ' ');
      CRVDIGIT := RPAD (CRVDIGIT, 2, ' ');
      BKSTYLE := RPAD (BKSTYLE, 3, ' ');
      vCHQBOOKS := LPAD (CHQBOOKS, 1, '0');
      --    vCHSSR      :=  rpad(vCHSSR,6,'0');
      vCHSSR := LPAD (vCHSSR, 6, '0');
      CUSTNAME := RPAD (CUSTNAME, 45, ' ');
      BRNAME := RPAD (BRNAME, 25, ' ');
      BRADDRESS := RPAD (BRADDRESS, 23, ' ');
      RCREID := RPAD (RCREID, 8, ' ');
      AUTHID := RPAD (AUTHID, 8, ' ');
      vREQDATE := SUBSTR (REQDATE, 1, 6) || SUBSTR (REQDATE, 8, 3);

      --------------------------------------------------------------------------------
      -- Write to the file in the specified format.
      --------------------------------------------------------------------------------
      --    out_desc := FORACID1||'01'||'1'||'1'||SORTCODE||FORACID1||CHQDIGIT||CHQVDIGIT||CRVDIGIT||BKSTYLE||vCHQBOOKS||vCHSSR||'000000'||CUSTNAME||BRNAME||BRADDRESS||'0'||RCREID||AUTHID||'A'||' ';

      --    out_desc := FORACID1||'|'||CUSTNAME||'|'||BRCODE||'|'||BRNAME||'|'||BRADDRESS||'|'||vCHQBOOKS||'|'||vCHSSR||'|'||CHQLVS ;
      IF (NUMBEROFREC = 1)
      THEN
          out_desc := HEADERFORFILE || chr(10) ||  vCHQBOOKS||' '||BKSTYLE||' '||vCHSSR||'    '||BANKCODE||BRCODE||CHQDIGIT||' '||FORACID1||' '||CUSTNAME||BANKCODE||BRCODE||' '||BRNAME||BRADDRESS||'  '||vREQDATE||' '||vDNLD_ID||'  ' ;
         ELSE 
          out_desc :=  vCHQBOOKS||' '||BKSTYLE||' '||vCHSSR||'    '||BANKCODE||BRCODE||CHQDIGIT||' '||FORACID1||' '||CUSTNAME||BANKCODE||BRCODE||' '||BRNAME||BRADDRESS||'  '||vREQDATE||' '||vDNLD_ID||'  ' ;
      END IF;
      IF(NUMBEROFREC = FOOTERCNT)
      THEN
          ORDERREC:=NUMBEROFREC;
          SELECT RPAD(BIDFORHEADER||'4' || LPAD(ORDERREC,6,0) || LPAD(CHQBKORDERED,6,0),200,' ') INTO FOOTER FROM DUAL;
          out_desc := out_desc || chr(10)  || FOOTER;
      END IF;
      
   END GETCHQDETAILDUPDWNLD;
END GETCHQDETAILDUPDWNLD_43;
/
