--=================================================================================================================*
-- Name                          : 	mbillsupldmn001.sql  
-- Date                          :  17-02-2013
-- Description                   :  This Sql will fetch the details from CUSTOM.C_PAYBILLCOLL and do the validation 
--									and the one spool file is generated which will be passed as a input to MRT 
--									to generate the report, which will pass as a input to TTUM exe.
-- Author                        :  Chethan.S
-- Called Scripts                :  <None>
-- Calling Script                :  <None>
-- Reference                     :
-- Modification History  :
-- <Serial No.>  <Date>         <AuthorName>            <Description>
--------------------------------------------------------------------------
--   1           17-02-2013      Chethan.S               Original Version
-- Using tabSpace 4
--=================================================================================================================*
SET PAGES 0
SET HEADING OFF
set trims on
set verify off
set feed off
set term off
set echo off
set linesize 250
set serveroutput on size 100000

declare

V_VALID    		VARCHAR2(1):=null;
V_REMARKS     	VARCHAR2(100):=null;
V_foracid    	VARCHAR2(100):=null;
V_comm    		VARCHAR2(100):=null;
V_solcomm    	VARCHAR2(100):=null;
V_CRNCYCODE    	VARCHAR2(3):=null;
v_sol_id     	VARCHAR2(3):=null;
v_schm     		VARCHAR2(3):=null;
v_acct_cls_flg 	VARCHAR2(1):=null;
v_frez_code     VARCHAR2(5):=null;
v_del_flg     	VARCHAR2(1):=null;
v_crncy_code   	VARCHAR2(3):=null;
v_name       	VARCHAR2(80):=null;
v_balance     	NUMBER(20,4):=0; 
V_check     	long :=null;
v_chkcount     	NUMBER(20,4):=0;
v_cnt_rec 		number :=0; 
v_bank_id		VARCHAR2(10);
F_recept		VARCHAR2(20);
F_payBill		VARCHAR2(20);
F_details		VARCHAR2(100);
F_amount		VARCHAR2(20);
F_otherpartyinfo	VARCHAR2(20);
F_otherpartyname	VARCHAR2(20);
F_acctNum			VARCHAR2(20);
F_userId			VARCHAR2(20);
F_checkNum			VARCHAR2(220);

CURSOR CUR_CBILCOL is 
SELECT 
	receipt, 
	paybill_date,
	details,
	amount,
	otherpartyinfo,
	otherpartyname,
	TRIM(accountnumber) accountnumber,
	entry_user_id,
	checksum
FROM CUSTOM.C_PAYBILLCOLL
WHERE entry_user_id= '&4'
AND bank_id = '&2';

BEGIN
--(
	
	IF (NOT CUR_CBILCOL%ISOPEN) THEN
	--{
		DBMS_OUTPUT.PUT_LINE('Hi');
		OPEN CUR_CBILCOL;
	--}
	END IF;

	DBMS_OUTPUT.PUT_LINE('entry_user_id is &4');

	LOOP
	--(
		V_VALID 			:='Y';
		V_REMARKS 			:=null;
		V_CRNCYCODE 		:=null;
		v_sol_id 			:=null;
		v_schm    			:=null;
		v_acct_cls_flg     	:=null;
		v_frez_code 		:=null;
		v_del_flg 			:=null;
		v_crncy_code 		:=null; 
		v_name 				:=null; 
		v_balance     		:=0; 
		v_check     		:=null;
		v_cnt_rec 			:=NVL(v_cnt_rec,0)+ 1;
		v_bank_id			:=null;


		FETCH CUR_CBILCOL INTO
		F_recept,
		F_payBill,
		F_details,
		F_amount,
		F_otherpartyinfo,
		F_otherpartyname,
		F_acctNum,
		F_userId,
		F_checkNum;

		DBMS_OUTPUT.PUT_LINE('acct Number is ' || F_acctNum);
		DBMS_OUTPUT.PUT_LINE('paybill_date is ' || F_payBill);

		IF (CUR_CBILCOL%NOTFOUND) THEN
		--{
			CLOSE CUR_CBILCOL;
			EXIT;
		--}
		END IF;

		BEGIN
				
			SELECT sol_id,acct_name,acct_crncy_code,FREZ_CODE,acct_cls_flg,bank_id
            INTO v_sol_id,v_name,v_crncy_code,v_frez_code,v_acct_cls_flg,v_bank_id
            FROM TBAADM.GAM  
            WHERE foracid=F_acctNum
            AND schm_type in ('LAA','CAA','SBA')
			AND bank_id = '&2';
        
            EXCEPTION
            
            WHEN NO_DATA_FOUND THEN
            V_VALID :='N';
            V_REMARKS    :='INVALID ACCOUNT NUMBER';
      
            
            WHEN OTHERS THEN
            V_VALID :='N';
            V_REMARKS    :='DATABASE ERROR';
        End;

		DBMS_OUTPUT.PUT_LINE('Sol Id is '||v_sol_id);

        IF v_crncy_code  != '&3' THEN 
            v_valid :='N';
            v_remarks:='Account '||F_acctNum||' Foreign Currency';
        END IF ;
        
        IF v_frez_code = 'C' THEN 
            v_valid :='N';
            v_remarks:='Account '||F_acctNum||' Credit Freeze';

        END IF ;
        
        IF v_frez_code = 'T' THEN 
            v_valid :='N';
            v_remarks:='Account '||F_acctNum||' Total Freeze';

        END IF ;
        IF v_acct_cls_flg = 'Y' THEN 
            v_valid :='N';
            v_remarks:='Account '||F_acctNum||' Closed';

        END IF ;

        begin
		SELECT custom.getmd5_8bit(amount||otherpartyinfo||accountnumber||entry_user_id)
		INTO v_check 
		FROM CUSTOM.C_PAYBILLCOLL
            WHERE C_PAYBILLCOLL.receipt=F_recept
            AND C_PAYBILLCOLL.accountnumber=F_acctNum
            --AND C_PAYBILLCOLL.otherpartyinfo=F_otherpartyinfo
            AND C_PAYBILLCOLL.entry_user_id='&4'
			AND bank_id = '&2';
         EXCEPTION
         WHEN NO_DATA_FOUND THEN
	  null;
         WHEN OTHERS THEN
	  null;
     
        END;

		DBMS_OUTPUT.PUT_LINE('checkSum from Query is '|| v_check);
		DBMS_OUTPUT.PUT_LINE('CheckSUm from Input is '||F_checkNum);
        
        IF v_check = F_checkNum THEN
			v_valid := v_valid;
			v_remarks := v_remarks;
		ELSE
		DBMS_OUTPUT.PUT_LINE('INside');
            v_valid :='C';
            v_remarks:='Error unauthorised file update';
        END IF;

      BEGIN
        UPDATE CUSTOM.C_PAYBILLCOLL SET remarks=v_remarks,valid=v_valid
        WHERE C_PAYBILLCOLL.receipt=F_recept
        AND C_PAYBILLCOLL.accountnumber=F_acctNum
        --AND C_PAYBILLCOLL.otherpartyinfo=F_otherpartyinfo
	AND C_PAYBILLCOLL.entry_user_id='&4'
	AND bank_id = '&2';
     
      EXCEPTION
      WHEN OTHERS THEN
        null;
      END;

		DBMS_OUTPUT.PUT_LINE('commiting');
        COMMIT;
        
    END LOOP;

	SELECT COUNT(1)
        INTO v_chkcount
        FROM CUSTOM.C_PAYBILLCOLL
        WHERE entry_user_id=F_userId
        AND bank_id = '&2'
        AND valid ='C';

    IF v_chkcount>0 THEN

        UPDATE CUSTOM.C_PAYBILLCOLL
                SET remarks='Error unauthorised file update',VALID='N'
                WHERE ENTRY_USER_ID=F_userId
                AND bank_id = '&2'
                AND valid ='C';
        COMMIT;

    END IF;

end;
/
show err
/
spool off
/
spool &1

SELECT GAM.sol_id||'|'||TRIM(C_PAYBILLCOLL.ACCOUNTNUMBER)||'|'||
'C'||'|'||C_PAYBILLCOLL.amount||'|'||GAM.acct_crncy_code||'|'||
SUBSTR(('MPESA-'||TRIM(otherpartyinfo)||' '||C_PAYBILLCOLL.receipt||' '||C_PAYBILLCOLL.otherpartyname),0,50)
FROM CUSTOM.C_PAYBILLCOLL,TBAADM.GAM 
WHERE GAM.foracid=C_PAYBILLCOLL.accountnumber
AND valid ='Y'
AND C_PAYBILLCOLL.entry_user_id='&4'
AND C_PAYBILLCOLL.bank_id = '&2'
UNION ALL
SELECT GAM.sol_id||'|'||'&5'||'|'||
'D'||'|'||C_PAYBILLCOLL.amount||'|'||'&3'||'|'||
SUBSTR(('MPESA-'||TRIM(otherpartyinfo)||' '||C_PAYBILLCOLL.receipt||' '||C_PAYBILLCOLL.otherpartyname),0,50)
FROM CUSTOM.C_PAYBILLCOLL,TBAADM.GAM 
WHERE GAM.foracid=C_PAYBILLCOLL.accountnumber
AND valid ='Y'
AND C_PAYBILLCOLL.entry_user_id='&4'
AND C_PAYBILLCOLL.bank_id = '&2'
/
spool off
/
spool &7;

SELECT 'RECEIPT|ACCOUNTNUMBER|OTHERPARTYINFO|OTHERPARTYNAME|DETAILS|AMOUNT|VALID|REMARKS' from dual
/
SELECT receipt||'|'||TRIM(accountnumber)||'|'||otherpartyinfo||'|'||otherpartyname||'|'||details||'|'||amount||'|'||valid||'|'||remarks
FROM CUSTOM.C_PAYBILLCOLL
WHERE valid ='N' 
AND C_PAYBILLCOLL.entry_user_id='&4'
AND bank_id = '&2'
/
spool off
/
Spool &6;
select 'RECEIPT|ACCOUNTNUMBER|OTHERPARTYINFO|OTHERPARTYNAME|DETAILS|AMOUNT|VALID|REMARKS' from dual
/
Select receipt||'|'||TRIM(accountnumber)||'|'||otherpartyinfo||'|'||otherpartyname||'|'||details||'|'||amount||'|'||valid||'|'||remarks
FROM CUSTOM.C_PAYBILLCOLL
WHERE valid= 'Y'
AND C_PAYBILLCOLL.entry_user_id='&4'
AND bank_id = '&2'
/
spool off
/

