DROP PACKAGE CUSTOM.EBKSALPROOF;

CREATE OR REPLACE PACKAGE CUSTOM.ebkSalProof AS
PROCEDURE process(v_emp IN VARCHAR2,v_userid IN VARCHAR2,v_bank_id IN VARCHAR2, v_drAcctCrncy IN VARCHAR2);
PROCEDURE directdebits(v_bank_id1 IN VARCHAR2);
PROCEDURE kbadirectdebits(v_bank_id IN VARCHAR2);
FUNCTION  creditors(v_bacid IN VARCHAR2,v_sol_id IN VARCHAR2,v_bank_id IN VARCHAR2) RETURN VARCHAR2;
END ebkSalProof;
/


GRANT EXECUTE ON CUSTOM.EBKSALPROOF TO TBAADM;

GRANT EXECUTE ON CUSTOM.EBKSALPROOF TO TBAGEN;

GRANT EXECUTE ON CUSTOM.EBKSALPROOF TO TBAUTIL;


DROP PACKAGE BODY CUSTOM.EBKSALPROOF;

CREATE OR REPLACE PACKAGE BODY CUSTOM.Ebksalproof AS
PROCEDURE process(v_emp IN VARCHAR2,v_userid IN VARCHAR2,v_bank_id IN VARCHAR2, v_drAcctCrncy IN VARCHAR2) IS
v_newacct VARCHAR2(16);
v_gamacctname VARCHAR2(80);
v_gamemp_id VARCHAR2(10);
v_invalid   VARCHAR2(2);
v_rmk VARCHAR2(100);
v_bod_date DATE ;
v_new_sol VARCHAR2(8);
v_ownership  VARCHAR2(2);
v_schmtype VARCHAR2(3);
v_err VARCHAR2(1000);
v_crAcctCrncy VARCHAR2(5);
  CURSOR cur IS SELECT EMPLOYER,EMPLOYEE_ID,UPL_ACCT_NO,ACCT_CRNCY_CODE,UPL_ACCT_NAME,SAL_CR_AMT,TRAN_PARTICULAR,
 SOL_ID,FORACID,UPL_KEY,UPL_DATE,UPL_STATUS FROM CUSTOM.C_SUP WHERE
 EMPLOYER =v_emp
 AND RCRE_USER_ID =v_userid
    AND UPL_STATUS IS NULL
    AND DEL_FLG='N'
    AND bank_id = v_bank_id
 AND batch IS NULL;
 --for update;

BEGIN
 SELECT db_stat_date
 INTO v_bod_date
 FROM TBAADM.gct
WHERE bank_id = v_bank_id;

DBMS_OUTPUT.PUT_LINE('v_userid' || v_userid);
DBMS_OUTPUT.PUT_LINE('v_bod_date '||v_bod_date);


 FOR i IN cur LOOP
    ---TRANSLATE THE OLD ACCOUNT NUMBER
    v_gamemp_id    :=NULL;
    v_gamacctname  :=NULL;
    v_newacct      :=NULL;
    v_invalid      :='S';
    v_rmk    :='Success';
    v_new_sol   :=NULL;
    v_ownership   :=NULL;
    v_schmtype   :=NULL;
    v_err :=NULL;
    v_crAcctCrncy := NULL;

DBMS_OUTPUT.PUT_LINE('i.sol_id '|| i.sol_id);
DBMS_OUTPUT.PUT_LINE('i.UPL_ACCT_NO '||i.UPL_ACCT_NO);


    BEGIN
      SELECT foracid
   INTO v_newacct
   FROM custom.OLD_ACCT_MAP
   WHERE old_num = (i.UPL_ACCT_NO)
   AND bank_id = v_bank_id
   AND sol_id = (i.sol_id) ;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- no old account
   --- check for new account from gam
   v_newacct :='';
    END;

    BEGIN
      SELECT acct_name,emp_id ,foracid,sol_id,ACCT_OWNERSHIP,SCHM_TYPE, acct_crncy_code
   INTO v_gamacctname,v_gamemp_id,v_newacct,v_new_sol,v_ownership,v_schmtype, v_crAcctCrncy
            FROM tbaadm.gam WHERE
         foracid =   NVL(v_newacct,i.sol_id||i.UPL_ACCT_NO)
   --SUBSTR(foracid,4) = i.UPL_ACCT_NO
   AND acct_cls_flg ='N'
   AND FREZ_CODE NOT IN ('T','C')
            AND del_flg='N'
    AND bank_id = v_bank_id
   AND acct_ownership IN ('E','C') ;
        EXCEPTION
       WHEN NO_DATA_FOUND THEN
    ---Inavlid account number
     v_invalid :='Y';
   v_newacct :='0';
   v_new_sol := i.sol_id;
   v_rmk :='Account Closed/Frozen/Deleted/Office';
    WHEN TOO_MANY_ROWS THEN
      v_invalid :='Y';
   v_newacct :='0';
   v_new_sol := i.sol_id;
   v_rmk :='Duplicate account exists';
   v_err := SQLERRM(SQLCODE);
   --raise_application_error(-20000,'1 acctnum='||i.UPL_ACCT_NO||' too many rows, db error = '||v_err);
   WHEN OTHERS THEN
   v_invalid :='Y';
   v_newacct :='0';
   v_new_sol := i.sol_id;
   v_err := SQLERRM(SQLCODE);
   v_rmk :='DB Error='||SUBSTR(v_err,1,90);
   --raise_application_error(-20000,'1 acctnum='||i.UPL_ACCT_NO||' db error = '||v_err);
   END;

   --#----Valid account number

   --#----Ensuring that the account is not a lonn account
   IF  (v_schmtype  NOT IN ('SBA','CAA')) THEN
   --Acount not in proper GL or scheme
    IF ( v_invalid = 'S' ) THEN
        v_invalid := 'Y';
        v_rmk :='Wrong Scheme Type';
    END IF;
   END IF;

   --#----checking the orginal a/c name with upload file a/c name
  IF (i.UPL_ACCT_NAME != NVL(v_gamacctname,' ') ) THEN
    --Account name mismatch"
    IF ( v_invalid = 'S' ) THEN
        v_invalid := 'N';
        v_rmk :='Emp ID or Account Name Mis-Match';
    END IF;
  END IF;

   --#----Ensuring that dr and cr accounts currencys are same
   IF  ( v_crAcctCrncy != v_drAcctCrncy ) THEN
   --Acount crncy is different
    v_invalid := 'C';
    v_rmk :='Account belogs to diffrent currency';
   END IF;

    BEGIN
     --update the record status
     UPDATE CUSTOM.C_SUP SET foracid=v_newacct
        ,UPL_DATE=v_bod_date
        ,UPL_STATUS='P'
        ,LCHG_USER_ID=v_userid
        ,LCHG_TIME=v_bod_date
        --,RCRE_USER_ID=v_userid
        ,RCRE_TIME=v_bod_date
   ,DEL_FLG='N' ,
   INVALID =v_invalid,
   RMK =v_rmk,
   GAM_ACCT =v_gamacctname,
   GAM_EMP_ID=v_gamemp_id,
   gam_sol_id =v_new_sol
         WHERE EMPLOYER=i.EMPLOYER
         AND UPL_ACCT_NO=i.UPL_ACCT_NO
    AND bank_id = v_bank_id
         AND SOL_ID=i.sol_id;
  EXCEPTION
  WHEN
TOO_MANY_ROWS THEN
  v_err := SQLERRM(SQLCODE);
  RAISE_APPLICATION_ERROR(-20000,'2 acctnum='||i.UPL_ACCT_NO||' too many rows, db error = '||v_err);
  WHEN OTHERS THEN
  v_err := SQLERRM(SQLCODE);
  RAISE_APPLICATION_ERROR(-20000,'2 acctnum='||i.UPL_ACCT_NO||' db error = '||v_err);
    END;

    COMMIT;

 END LOOP;
END process;

FUNCTION  creditors(v_bacid IN VARCHAR2,v_sol_id IN VARCHAR2,v_bank_id IN VARCHAR2) RETURN VARCHAR2 IS
v_acct VARCHAR2(16);
BEGIN
  SELECT foracid
 INTO v_acct
 FROM TBAADM.gam
 WHERE bacid=v_bacid
 AND bank_id = v_bank_id
 AND sol_id =v_sol_id;
 RETURN (v_acct);
END creditors;

PROCEDURE directdebits (v_bank_id1 IN VARCHAR2) IS
CURSOR cur IS SELECT * FROM custom.c_dds WHERE bank_id = v_bank_id1;
v_cnt NUMBER :=0;
v_acct_exists VARCHAR2(1);
v_acct_frozen VARCHAR2(1);
v_acct_cls VARCHAR2(1);
v_bal_pass VARCHAR2(1);
v_acid VARCHAR2(15);
v_mandate_pass VARCHAR2(1);
v_sol_id VARCHAR2(5);
v_bank_id VARCHAR2(20);
v_policy VARCHAR2(40);
BEGIN
FOR i IN cur LOOP
 --validate account
 v_acct_exists :='N';
 v_acct_frozen :=NULL;
 v_acct_cls :=NULL;
 v_cnt :=0;
 v_bal_pass :=NULL;
 v_acid :=NULL;
 v_mandate_pass :=NULL;
 v_sol_id :=NULL;
    v_bank_id := NULL;
 v_policy :=NULL;

 BEGIN
   SELECT 'Y',NVL(acct_cls_flg,'N'),DECODE(SIGN(clr_bal_amt - NVL(i.AMOUNT,0)),-1,'N','Y'),acid,sol_id,REFERENCE_ID_1,gam.bank_id
   INTO v_acct_exists,v_acct_cls,v_bal_pass,v_acid,v_sol_id,v_policy,v_bank_id
   FROM TBAADM.gam,TBAADM.emd
   WHERE gam.acid=emd.B2K_ID
   AND foracid=(i.CLIENTACNO)
    AND GAM.bank_id = emd.bank_id
--    AND foracid = '0301100300435';
   AND emd.B2K_TYPE ='ACCNT'
   --AND emd.B2K_ID =v_acid
   --AND emd.IN_OUT_IND ='O'
   AND emd.DR_CR_IND ='D'
    AND REFERENCE_ID_1 = (i.policyno)
    AND GAM.bank_id = v_bank_id1
   AND emd.TRANSACTION_CODE ='40';
      EXCEPTION
   WHEN NO_DATA_FOUND THEN
   v_acct_exists :='N';
   UPDATE c_dds
   SET status='RNK',remarks='Rejected Account not known'
   WHERE CLIENTACNO=i.CLIENTACNO
    AND bank_id = v_bank_id1;
 END ;

   IF ((v_acct_exists ='Y') AND (v_acct_cls !='Y') AND (v_bal_pass='Y')) THEN
    --(
    UPDATE c_dds
    SET status='ACC',remarks='Request accepted'
    WHERE CLIENTACNO=i.CLIENTACNO
    AND bank_id = v_bank_id1
    AND (POLICYNO)=(v_policy);
   END IF;

   IF  (v_acct_cls ='Y' ) THEN
    UPDATE c_dds
    SET status='RAC',remarks='Rejected Account closed'
    WHERE CLIENTACNO=i.CLIENTACNO
    AND bank_id = v_bank_id1
    AND (POLICYNO)=(v_policy);
   END IF;

   IF ( v_bal_pass !='Y' ) THEN
    UPDATE c_dds
    SET status='RIF',remarks='Rejected Inadequate funds'
    WHERE CLIENTACNO=i.CLIENTACNO
    AND bank_id = v_bank_id1
    AND (POLICYNO)=(v_policy);
   END IF;

 IF (NVL(v_acct_exists,'N') = 'Y') THEN

  BEGIN
    SELECT 'Y'
    INTO v_mandate_pass
    FROM TBAADM.emd
    WHERE emd.B2K_TYPE ='ACCNT'
    AND emd.B2K_ID =v_acid
    AND emd.IN_OUT_IND ='O'
    AND emd.DR_CR_IND ='D'
    AND emd.TRANSACTION_CODE ='40'
    AND bank_id = v_bank_id1
    AND (i.DUEDATE BETWEEN emd.START_DATE AND emd.END_DATE)
    AND DECODE (emd.MANDATE_AMOUNT_TYPE,'F',NVL(emd.AMOUNT,0),0) = DECODE (emd.MANDATE_AMOUNT_TYPE,'F',NVL(i.AMOUNT,0),0)
    AND DECODE (emd.MANDATE_AMOUNT_TYPE,'M',NVL(emd.AMOUNT,0),0) >= DECODE (emd.MANDATE_AMOUNT_TYPE,'M',NVL(i.AMOUNT,0),0)
    --and ( i.DUEDATE not between NVL(SUSPEND_MANDATE_FROM,i.DUEDATE + 1) and  NVL(SUSPEND_MANDATE_TO,i.DUEDATE + 1))
    AND (i.POLICYNO)=(v_policy);
 exception
  when others then
  v_mandate_pass :='N';
    update c_dds
    set status='RNM',remarks='Rejected No Mandate'
    where CLIENTACNO=i.CLIENTACNO
    AND bank_id = v_bank_id1
    and (i.POLICYNO)=(v_policy);
  END;
 END IF;

 IF (NVL(v_acct_exists,'N') ='Y') THEN
  BEGIN
     SELECT FREZ_CODE
    INTO v_acct_frozen
             FROM TBAADM.gam WHERE
          foracid =   (i.CLIENTACNO)
    AND bank_id = v_bank_id1
    AND FREZ_CODE  IN ('T','D')
             AND del_flg !='Y' ;
  EXCEPTION
   WHEN NO_DATA_FOUND THEN
   v_acct_frozen :='N';
  END;
  IF ( NVL(v_acct_frozen,'N') IN ('T','D') )THEN
   UPDATE c_dds
      SET status='REE',remarks='Rejected Exemptions Encountered'
      WHERE CLIENTACNO=i.CLIENTACNO
    AND bank_id = v_bank_id1;
END IF;
 ELSE
   v_acct_exists :='N';
 END IF;

 UPDATE c_dds
 SET upl_status='P',sol_id=v_sol_id,del_flg = 'N'
 WHERE CLIENTACNO=i.CLIENTACNO
    AND bank_id = v_bank_id1;
 COMMIT;
END LOOP;
END directdebits;

PROCEDURE kbadirectdebits(v_bank_id IN VARCHAR2) IS
CURSOR cur IS SELECT * FROM custom.C_KBADDS WHERE bank_id = v_bank_id;
v_cnt NUMBER :=0;
v_acct_exists VARCHAR2(1);
v_acct_frozen VARCHAR2(1);
v_acct_cls VARCHAR2(1);
v_bal_pass VARCHAR2(1);
v_acid VARCHAR2(15);
v_mandate_pass VARCHAR2(1);
v_sol_id VARCHAR2(5);
v_account_cnt NUMBER;
v_mandate_cnt NUMBER;
v_proceed VARCHAR2(1);
v_acct_status VARCHAR2(1);
v_eff_bal VARCHAR2(1);

BEGIN

    DBMS_OUTPUT.PUT_LINE('v_bank_id is '||v_bank_id);

    FOR i IN cur LOOP
    v_acct_exists :='N';
    v_acct_frozen :=NULL;
    v_acct_cls :=NULL;
    v_cnt :=0;
    v_bal_pass :=NULL;
    v_acid :=NULL;
    v_mandate_pass :=NULL;
    v_sol_id :=NULL;
    v_proceed:='Y';
    v_acct_status :=NULL;
    v_eff_bal :=NULL;

    BEGIN

        --Checking if account is valid
        SELECT COUNT(1)
        INTO v_account_cnt
        FROM tbaadm.gam
        WHERE foracid=(i.DEBITACCTNUM)
        AND bank_id = v_bank_id;
        IF v_account_cnt =0 THEN
            v_acct_exists :='N';
            v_proceed:='N';
            UPDATE c_kbadds
            SET status='69',remarks='Invalid Account Number'
            WHERE DEBITACCTNUM=i.DEBITACCTNUM
            AND bank_id = v_bank_id
            AND ORIGINATOR_REF=i.ORIGINATOR_REF;
        ELSE
            UPDATE c_kbadds
            SET status='RA',remarks='Request Accepted'
            WHERE DEBITACCTNUM=i.DEBITACCTNUM
            AND bank_id = v_bank_id
            AND ORIGINATOR_REF=i.ORIGINATOR_REF;
        END IF;

        ---Checking if account is closed
        IF v_proceed='Y' THEN
            SELECT sol_id,acct_cls_flg INTO v_sol_id,v_acct_cls FROM tbaadm.gam
            WHERE foracid=(i.DEBITACCTNUM)
            AND bank_id = v_bank_id;
            IF  v_acct_cls ='Y'  THEN
                v_proceed:='N';
                UPDATE c_kbadds
                SET status='74',remarks='Account Closed'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            ELSE
                UPDATE c_kbadds
                SET status='RA',remarks='Request Accepted'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            END IF;
        END IF;

        --checking for mandate
        IF v_proceed='Y' THEN
            SELECT COUNT(1)
            INTO v_mandate_cnt
            FROM tbaadm.gam ,tbaadm.emd
            WHERE foracid=(i.DEBITACCTNUM)
            AND gam.acid=emd.b2k_id
            AND gam.bank_id = emd.bank_id
            AND gam.bank_id = v_bank_id
            AND EMD.ENTITY_CRE_FLG='Y'
            AND EMD.DEL_FLG ='N';
                IF v_mandate_cnt=0 THEN
                v_mandate_pass:='N';
                v_proceed:='N';
                UPDATE c_kbadds
                SET status='81',remarks='No Mandate'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            ELSE
                UPDATE c_kbadds
                SET status='RA',remarks='Request Accepted'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            END IF;

        END IF;

        ---Checking if account is Dormant
        IF v_proceed='Y' THEN
            SELECT smt.ACCT_STATUS INTO v_acct_status FROM tbaadm.gam,tbaadm.smt
            WHERE gam.acid=smt.acid
            AND gam.bank_id = v_bank_id
            AND gam.bank_id = smt.bank_id
            AND foracid=(i.DEBITACCTNUM);
            IF  (v_acct_status='I' OR v_acct_status='D' ) THEN
                v_proceed:='N';
                UPDATE c_kbadds
                SET status='64',remarks='Account Inactive/Dormant'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                    AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            ELSE
                UPDATE c_kbadds
                SET status='RA',remarks='Request Accepted'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                    AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            END IF;
        END IF;

        ---Checking if account is frozen
        IF v_proceed='Y' THEN
            SELECT FREZ_CODE INTO v_acct_frozen
            FROM tbaadm.gam WHERE foracid=(i.DEBITACCTNUM)
            AND gam.bank_id = v_bank_id;
            IF  (v_acct_frozen='T' OR v_acct_frozen='D' ) THEN
                v_proceed:='N';
                UPDATE c_kbadds
                SET status='77',remarks='Account Frozen'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            ELSE
                UPDATE c_kbadds
                SET status='RA',remarks='Request Accepted'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            END IF;
        END IF;

        ---Checking if account has sufficent funds
        IF v_proceed='Y' THEN
            SELECT DECODE(SIGN((clr_bal_amt-lien_amt-SYSTEM_RESERVED_AMT+SANCT_LIM) - NVL(i.AMOUNT,0)),-1,'N','Y') into v_eff_bal
            from tbaadm.gam where foracid=(i.DEBITACCTNUM)
            AND gam.bank_id = v_bank_id;
            IF  (v_eff_bal='N') THEN
                v_proceed:='N';
                UPDATE c_kbadds
                SET status='63',remarks='Insufficient funds-RD'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            ELSE
                UPDATE c_kbadds
                SET status='RA',remarks='Request Accepted'
                WHERE DEBITACCTNUM=i.DEBITACCTNUM
                AND bank_id = v_bank_id
                AND ORIGINATOR_REF=i.ORIGINATOR_REF;
            END IF;
        END IF;

        ---updating the record as processed
        UPDATE c_kbadds
        SET upl_status='P',sol_id=v_sol_id
        WHERE DEBITACCTNUM=i.DEBITACCTNUM
        AND bank_id = v_bank_id
        AND ORIGINATOR_REF=i.ORIGINATOR_REF;
        COMMIT;

        END;

    END LOOP;
END kbadirectdebits;
END Ebksalproof;
/


GRANT EXECUTE ON CUSTOM.EBKSALPROOF TO TBAADM;

GRANT EXECUTE ON CUSTOM.EBKSALPROOF TO TBAGEN;

GRANT EXECUTE ON CUSTOM.EBKSALPROOF TO TBAUTIL;

