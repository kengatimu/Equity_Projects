SET PAGES 0
SET HEADING OFF
set trims on
set verify off
set feed off
set term off
set linesize 250
set serveroutput on

declare
v_valid		varchar2(1):=null;
v_remarks	varchar2(100):=null;
v_foracid	varchar2(16):=null;
v_sol_id	varchar2(5):=null;
v_acct_cls_flg varchar2(1):=null;
v_frez_code   varchar2(1):=null;
v_del_flg	  varchar2(1):=null;
v_schm		   varchar2(5):=null;
v_crncy_code   varchar2(5):=null;
Begin
	for i in (select CLIENTCDSNO, ACCOUNTNUMBER, AMOUNT, ASATDATE, PAYMENT_DPA from CUSTOM.EXCANRE_TABLE where bank_id = '&2') loop
		v_valid     :='Y';
		v_remarks	:='Success';
		v_foracid	:=null;
		v_sol_id	:=null;
		v_acct_cls_flg :=null;
		v_frez_code  :=null;
		v_del_flg	:=null;
		v_schm	:=null;
		v_crncy_code :=null;
		 
		Begin 
			select gam.sol_id,gam.foracid,schm_type,acct_cls_flg,frez_code,del_flg,acct_crncy_code
			into v_sol_id,v_foracid,v_schm,v_acct_cls_flg,v_frez_code,v_del_flg,v_crncy_code
			from tbaadm.gam, CUSTOM.C_EXCANRE
			where gam.FORACID=C_EXCANRE.ACCOUNTNUMBER
			and C_EXCANRE.CLIENTCDSNO=i.CLIENTCDSNO
			and C_EXCANRE.PAYMENT_DPA=i.PAYMENT_DPA
			and gam.ACCT_OWNERSHIP!='O'
			and  gam.bank_id = C_EXCANRE.bank_id
			and C_EXCANRE.bank_id = '&2';

			EXCEPTION
			
			WHEN NO_DATA_FOUND THEN
			v_valid :='N';
			v_remarks:='Account '||i.ACCOUNTNUMBER||' Not found';
			
			WHEN TOO_MANY_ROWS THEN
			v_valid :='N';
			v_remarks := 'Duplicate Record exists';
			
			WHEN OTHERS THEN
			v_valid :='N';
			v_remarks	:='DATABASE ERROR';
		End;
		
		IF  v_schm = 'LAA' THEN
			BEGIN 
				select gam.sol_id,gam.foracid,schm_type,acct_cls_flg,frez_code,del_flg,acct_crncy_code
				into v_sol_id,v_foracid,v_schm,v_acct_cls_flg,v_frez_code,v_del_flg,v_crncy_code 
				from tbaadm.gam where acid in (select lam.OP_ACID from tbaadm.lam 
				where acid in (select acid from tbaadm.gam, CUSTOM.C_EXCANRE
							where gam.FORACID=C_EXCANRE.ACCOUNTNUMBER
							and C_EXCANRE.CLIENTCDSNO=i.CLIENTCDSNO
							and C_EXCANRE.PAYMENT_DPA=i.PAYMENT_DPA
							and gam.ACCT_OWNERSHIP!='O'
							and gam.bank_id = C_EXCANRE.bank_id
							and  C_EXCANRE.bank_id = '&2')
							and lam.bank_id = '&2')
						and gam.bank_id = '&2';
				
				EXCEPTION
				
				WHEN NO_DATA_FOUND THEN
				v_valid :='N';
				v_remarks:='Account '||i.ACCOUNTNUMBER||' Not found';
				
				WHEN TOO_MANY_ROWS THEN
				v_valid :='N';
				v_remarks := 'Duplicate Record exists';

				
				WHEN OTHERS THEN
				v_valid :='N';
				v_remarks	:='DATABASE ERROR';
		
			END;
			
		END IF ; 
		
		IF v_acct_cls_flg = 'Y' THEN 
			v_valid :='N';
			v_remarks:='Account '||i.ACCOUNTNUMBER||' Closed';
			
		END IF ;
		IF v_frez_code = 'T' THEN 
			v_valid :='N';
			v_remarks:='Account '||i.ACCOUNTNUMBER||' Total Freeze';
			
		END IF ;
		IF v_frez_code = 'C' THEN 
			v_valid :='N';
			v_remarks:='Account '||i.ACCOUNTNUMBER||' Credit Freeze';
			
		END IF ;
		IF v_del_flg = 'Y' THEN 
			v_valid :='N';
			v_remarks:='Account '||i.ACCOUNTNUMBER||' Deleted';
			
		END IF ;
		
		IF v_crncy_code  != '&3' THEN 
			v_valid :='N';
			v_remarks:='Account '||i.ACCOUNTNUMBER||' Foreign Currency';
		END IF ;
		
		 update  CUSTOM.EXCANRE_TABLE
		 set FORACID=v_foracid,SOL_ID=v_sol_id, ACCNT_CRNCY=v_crncy_code,REMARKS=v_remarks,VALID=v_valid
		 where CUSTOM.EXCANRE_TABLE.CLIENTCDSNO=i.CLIENTCDSNO
		 and CUSTOM.EXCANRE_TABLE.PAYMENT_DPA=i.PAYMENT_DPA
		 and bank_id = '&2';
		 
		 commit;
	
	end loop ; 		
End;
/
--col inp1 new_value v_errorfile noprint
--col inp2 new_value v_sucessfile noprint
--select '&1'||'ErrorReport.txt' inp1 from dual
--/
--select '&1'||'SuccessReport.txt' inp2 from dual
--/
--spool &v_errorfile;

spool &8;
select '                     TRADE REFUNDS ERROR REPORT                              ' from dual
/
select 'CLIENTCDSNO|ACCOUNTNUMBER|AMOUNT|AS AT DATE|FORACID|SOL_ID|ACCNT_CRNCY|REMARKS' from dual

/
select CLIENTCDSNO||'|'||ACCOUNTNUMBER||'|'||AMOUNT||'|'||ASATDATE||'|'||FORACID||'|'||SOL_ID||'|'||ACCNT_CRNCY||'|'||REMARKS
from CUSTOM.C_EXCANRE where valid ='N' and bank_id = '&2'
/
spool off
/
--Spool &v_sucessfile;
Spool &7;
select '                       TRADE REFUNDS SUCESS REPORT                           ' from dual
/
select 'CLIENTCDSNO|ACCOUNTNUMBER|AMOUNT|AS AT DATE|FORACID|SOL_ID|ACCNT_CRNCY|REMARKS' from dual
/
select CLIENTCDSNO||'|'||ACCOUNTNUMBER||'|'||ACCT_NAME||'|'||AMOUNT||'|'||ASATDATE||'|'||C_EXCANRE.FORACID||'|'||C_EXCANRE.SOL_ID||'|'||ACCNT_CRNCY||'|'||REMARKS
from CUSTOM.C_EXCANRE,tbaadm.gam
where  C_EXCANRE.ACCOUNTNUMBER=gam.foracid
and C_EXCANRE.bank_id = gam.bank_id
and C_EXCANRE.bank_id = '&2'
and valid ='Y'
/
spool off
/
--spool ECRUpload.lst
spool &6
SELECT sol_id||'|'||foracid||'|'||abs(amount)||'|'||
DECODE(sign(amount),-1,'D',1,'C')||'|'||'Trade Refunds Ref: '||CLIENTCDSNO||' As At :'||ASATDATE||'|'||'&3'
FROM CUSTOM.C_EXCANRE where valid ='Y' and bank_id = '&2'
UNION ALL
SELECT '&5'||'|'||'&4'||'|'||sum(amount)||'|'||
DECODE(sign(sum(amount)),-1,'C',1,'D')||'|'||'Trade Refunds Ref: '||' As At :'||ASATDATE||'|'||'&3'
FROM CUSTOM.C_EXCANRE where valid ='Y' and bank_id = '&2'
GROUP BY ASATDATE
/
spool off	
exit
