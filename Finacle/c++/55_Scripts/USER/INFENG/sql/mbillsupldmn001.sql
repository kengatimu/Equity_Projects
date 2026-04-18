--=================================================================================================================*
-- Name                          : 	mbillsupldmn001.sql  
-- Date                          :  17-02-2013
-- Description                   :  This Sql will fetch the details from CUSTOM.C_PAYBILL and do the validation 
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
--   2           08-08-2013      Bharath                 Datatype length changed
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
set serveroutput on size 10000000

declare

V_VALID    		VARCHAR2(1):=null;
V_REMARKS     	VARCHAR2(100):=null;
V_foracid    	VARCHAR2(100):=null;
V_comm    		VARCHAR2(100):=null;
V_solcomm    	VARCHAR2(100):=null;
V_CRNCYCODE    	VARCHAR2(3):=null;
v_sol_id     	VARCHAR2(8):=null;
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
F_payBill 	VARCHAR2(50);
F_details 	VARCHAR2(255);
F_amount 	number(10,2);
F_otherpartyinfo 	VARCHAR2(100);
F_otherpartyname 	VARCHAR2(100);
F_acctNum 	VARCHAR2(100);
F_userId 	VARCHAR2(20);
F_checkNum 	LONG;

CURSOR CUR_CBILPAY is 
SELECT 
	receipt, 
	paybill_date,
	details,amount,
	otherpartyinfo,
	otherpartyname,
	TRIM(accountnumber) accountnumber,
	entry_user_id,
	checksum
FROM CUSTOM.C_PAYBILL
WHERE entry_user_id= '&4'
AND bank_id = '&2';

BEGIN
--(
	
	IF (NOT CUR_CBILPAY%ISOPEN) THEN
	--{
		DBMS_OUTPUT.PUT_LINE('Hi');
		OPEN CUR_CBILPAY;
	--}
	END IF;

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

		FETCH CUR_CBILPAY INTO
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

		IF (CUR_CBILPAY%NOTFOUND) THEN
		--{
			CLOSE CUR_CBILPAY;
			EXIT;
		--}
		END IF;

		V_VALID  := 'Y';

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
            V_REMARKS :='INVALID ACCOUNT NUMBER';
      
            
            WHEN OTHERS THEN
            V_VALID :='N';
            V_REMARKS    :='DATABASE ERROR';
        End;

		DBMS_OUTPUT.PUT_LINE('Sol Id is '||v_sol_id);

        IF (v_crncy_code  != '&3') THEN 
		--(
            v_valid :='N';
            v_remarks:='Account '||F_acctNum||' Foreign Currency';
		--)
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
		FROM CUSTOM.C_PAYBILL
            WHERE C_PAYBILL.receipt=F_recept
            AND trim(C_PAYBILL.accountnumber)=F_acctNum
            AND C_PAYBILL.otherpartyinfo=F_otherpartyinfo
			AND bank_id = '&2'
            and C_PAYBILL.entry_user_id=F_userId;
         exception
         when no_data_found then
	  null;
         when others then
	  null;
     
        end;

		DBMS_OUTPUT.PUT_LINE('checkSum from Query is '|| v_check);
		DBMS_OUTPUT.PUT_LINE('CheckSUm from Input is '||F_checkNum);
        
        IF v_check = F_checkNum THEN
			v_valid := v_valid;
			v_remarks := v_remarks;
		ELSE
            v_valid :='C';
            v_remarks:='Error unauthorised file update';
        END IF;

	--	<<SUB1>>

      BEGIN
        UPDATE CUSTOM.C_PAYBILL SET remarks=v_remarks,valid=v_valid
        WHERE C_PAYBILL.receipt=F_recept
        AND trim(C_PAYBILL.accountnumber)=F_acctNum
		AND bank_id = '&2'
        AND C_PAYBILL.otherpartyinfo=F_otherpartyinfo
		and C_PAYBILL.entry_user_id=F_userId;
     
      EXCEPTION
      WHEN OTHERS THEN
        null;
      END;

		DBMS_OUTPUT.PUT_LINE('commiting');
        COMMIT;
        
    END LOOP;

    SELECT COUNT(1)  
	INTO v_chkcount 
	FROM CUSTOM.C_PAYBILL  
	WHERE C_PAYBILL.entry_user_id=F_userId
	AND bank_id = '&2'
	AND valid ='C';
       
    IF v_chkcount>0 THEN 
        
        UPDATE CUSTOM.C_PAYBILL 
		SET remarks='Error unauthorised file update',VALID='N'
		WHERE C_PAYBILL.ENTRY_USER_ID=F_userId
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

select gam.sol_id||'|'||trim(c_paybill.ACCOUNTNUMBER)||'|'||
'C'||'|'||c_paybill.amount||'|'||gam.ACCT_CRNCY_CODE||'|'||
substr(('MPESA-'||trim(OTHERPARTYINFO)||' '||c_paybill.RECEIPT||' '||c_paybill.OTHERPARTYNAME),0,50)
from custom.c_paybill,tbaadm.gam where gam.foracid=trim(c_paybill.accountnumber)
and gam.bank_id = c_paybill.bank_id
and valid ='Y'
and C_PAYBILL.ENTRY_USER_ID='&4'
AND C_PAYBILL.bank_id = '&2'
union all
select gam.sol_id||'|'||'&5'||'|'||
'D'||'|'||c_paybill.amount||'|'||'&3'||'|'||
substr(('MPESA-'||trim(OTHERPARTYINFO)||' '||c_paybill.RECEIPT||' '||c_paybill.OTHERPARTYNAME),0,50)
from custom.c_paybill,tbaadm.gam where gam.foracid=trim(c_paybill.accountnumber)
and gam.bank_id = c_paybill.bank_id
and valid ='Y'
and C_PAYBILL.ENTRY_USER_ID='&4'
AND C_PAYBILL.bank_id = '&2'
/
spool off
/
spool &7;

select 'RECEIPT|ACCOUNTNUMBER|OTHERPARTYINFO|OTHERPARTYNAME|DETAILS|AMOUNT|VALID|REMARKS' from dual
/
Select RECEIPT||'|'||trim(ACCOUNTNUMBER)||'|'||OTHERPARTYINFO||'|'||OTHERPARTYNAME||'|'||DETAILS||'|'||AMOUNT||'|'||VALID||'|'||REMARKS
from custom.c_paybill
where (valid ='N' )
and C_PAYBILL.ENTRY_USER_ID='&4'
AND bank_id = '&2'
/
spool off
/
Spool &6;
select 'RECEIPT|ACCOUNTNUMBER|OTHERPARTYINFO|OTHERPARTYNAME|DETAILS|AMOUNT|VALID|REMARKS' from dual
/
Select RECEIPT||'|'||trim(ACCOUNTNUMBER)||'|'||OTHERPARTYINFO||'|'||OTHERPARTYNAME||'|'||DETAILS||'|'||AMOUNT||'|'||VALID||'|'||REMARKS
from custom.c_paybill
where valid= 'Y'
and C_PAYBILL.ENTRY_USER_ID='&4'
AND bank_id = '&2'
/
spool off
/
exit;

