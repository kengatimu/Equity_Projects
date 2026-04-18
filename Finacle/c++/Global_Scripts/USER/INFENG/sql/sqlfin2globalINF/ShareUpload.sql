-----------------------------------------------------------------------------------    
--	Name			: ShareUpload.sql
--	Description		: The file is used to upload the Share trading transaction.  
--	Date			: 05-03-2013
--	Author			: GOKULKRISHNA
--	Input			: NA
--	Output			: NA
--	Called Script	: 
--	Calling Scrip	: NA
--	Menu Option		: CSTTM
--	Srl. No			Date			Author			Description.   
--	-------			---------		-------			---------------			
--	1.0			05-03-2013		GOKULKRISHNA		Original Version
--	2.0			08-07-2013		Bharath Reddy		lst filename changed and bank id added
--	3.0			28-08-2013		Priyanka T		Appended 'N' to data text - TOL - 369541
------------------------------------------------------------------------------------

set pages 0
set echo off
SET HEADING OFF
set trims on
set verify off
set feed off
set term off
set head off

set linesize 1000
set serveroutput on

col inp1 new_value v_errorfile noprint
col inp2 new_value v_sucessfile noprint
col inp3 new_value v_psalefile noprint
col inp4 new_value v_nsalefile noprint
col inp5 new_value v_tesfile noprint

select '&1'||'ErrorReport.txt' inp1 from dual
/
select '&1'||'SuccessReport.txt' inp2 from dual
/
select '&1'||'Propmtsales.txt' inp3 from dual
/
select '&1'||'Normalsales.txt' inp4 from dual
/
select '&1'||'tes.txt' inp5 from dual
/


spool &v_tesfile;
declare

V_VALID    VARCHAR2(1):=null;
V_REMARKS	 VARCHAR2(100):=null;
V_foracid    VARCHAR2(100):=null;
V_comm    VARCHAR2(100):=null;
V_solcomm    VARCHAR2(100):=null;
V_CRNCYCODE    VARCHAR2(3):=null;
v_sol_id	 VARCHAR2(3):=null;
v_schm	 VARCHAR2(3):=null;
v_acct_cls_flg	 VARCHAR2(1):=null;
v_frez_code	 VARCHAR2(5):=null;
v_del_flg	 VARCHAR2(1):=null;
v_crncy_code	 VARCHAR2(3):=null; 
v_balance	 NUMBER(20,4):=0; 

Begin
	for i in (select CUSTODIKNOWCODE,ACCOUNTNUMBER,CLIENTCDSNO,SECURITYCODE,     
	ORDERTYPE,LOTQTY,LOTPRICE,AMOUNT,BANKCOMMISSON,NSE,
	CMA,CDSC,CDSCGUARANTEE,CMACOMP,CONTRACTNUMBER,CONTRACTDATE,
	CDSREF,BROKER,BROKERACOUNT,BROKERCOMMISSION,REVENUESTAMP,
	SETTLEMENT_DATE ,SETTLEMENT_STATUS from CUSTOM.TRADING_TABLE where bank_id = '&2') loop

		V_VALID :='Y';
		V_REMARKS :=null;
		V_CRNCYCODE :=null;
		v_sol_id :=null;
		v_schm	:=null;
		v_acct_cls_flg	 :=null;
		v_frez_code :=null;
		v_del_flg :=null;
		v_crncy_code :=null; 
		v_balance	 :=0; 
			DBMS_OUTPUT.PUT_LINE(i.ACCOUNTNUMBER||'|'|| i.ordertype||'|'||i.SECURITYCODE||'|'||i.AMOUNT||'|'||i.BROKERACOUNT||'|'||i.SETTLEMENT_STATUS);

		IF (i.ordertype = 'Purchase') Then
			Begin
			DBMS_OUTPUT.PUT_LINE('i.ordertype inside ' || i.ordertype);
				insert into CUSTOM.TRADING_TRAN_TABLE(CUSTODIKNOWCODE, CLIENTCDSNO, CONTRACTNUMBER,CONTRACTDATE, BRANCHCODE, 
				DRCRACCOUNT, AMOUNT, DRCRIND,REMARKS,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,BANK_ID)
				select CUSTODIKNOWCODE,CLIENTCDSNO,CONTRACTNUMBER,CONTRACTDATE,'&3','&4',
				AMOUNT+(BANKCOMMISSON+CDSC+CDSCGUARANTEE+BROKERCOMMISSION+ NSE+CMA+ CMACOMP + REVENUESTAMP),
				'D',LOTQTY||''||SECURITYCODE||'@'||LOTPRICE||'/'||to_number(substr(CLIENTCDSNO,0,13))||substr(CLIENTCDSNO,14,3)||'/'||CONTRACTDATE,
				CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,'&2'
				from CUSTOM.TRADING_TABLE
				where  TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
				and bank_id = '&2';
				COMMIT;
			End;
		END IF;
		Begin
			DBMS_OUTPUT.PUT_LINE('i.ordertype is ' || i.ordertype);
			Begin
				select sol_id,foracid into V_comm,V_solcomm
				from TBAADM.gam where bacid ='&5' 
				and sol_id in (select sol_id from TBAADM.gam,CUSTOM.TRADING_TABLE where 
				gam.FORACID=TRADING_TABLE.ACCOUNTNUMBER
				and TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
				and gam.bank_id=TRADING_TABLE.bank_id
				and gam.bank_id= '&2')
				and bank_id = '&2';
				--and rownum =1;

				EXCEPTION

				WHEN NO_DATA_FOUND THEN
				V_VALID :='N';
				V_REMARKS	:='SECURITIES TRADE COMMSISSION A/C NOT SETUP FOR THE BRANCH';

				WHEN OTHERS THEN
				V_VALID :='N';
				V_REMARKS	:='DATABASE ERROR';
			End;

				DBMS_OUTPUT.PUT_LINE('i.CONTRACTNUMBER is ' || i.CONTRACTNUMBER);
				insert into CUSTOM.TRADING_TRAN_TABLE (CUSTODIKNOWCODE, CLIENTCDSNO, CONTRACTNUMBER,CONTRACTDATE, BRANCHCODE, 
				DRCRACCOUNT, AMOUNT, DRCRIND,REMARKS,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,BANK_ID)  select CUSTODIKNOWCODE,CLIENTCDSNO,CONTRACTNUMBER,CONTRACTDATE,V_comm,V_solcomm,BANKCOMMISSON,'C'
				,LOTQTY||''||SECURITYCODE||'@'||LOTPRICE||'/'||to_number(substr(CLIENTCDSNO,0,13))||substr(CLIENTCDSNO,14,3)||'/'||
				CONTRACTDATE,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,'&2'
				from CUSTOM.TRADING_TABLE	
				where TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
				and bank_id = '&2';
				COMMIT;
		End;
		Begin
			insert into CUSTOM.TRADING_TRAN_TABLE (CUSTODIKNOWCODE, CLIENTCDSNO, CONTRACTNUMBER,CONTRACTDATE, BRANCHCODE, 
			DRCRACCOUNT, AMOUNT, DRCRIND,REMARKS,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,BANK_ID) select CUSTODIKNOWCODE,CLIENTCDSNO,CONTRACTNUMBER,CONTRACTDATE,'&6','&7',CDSC,'C'
			,LOTQTY||''||SECURITYCODE||'@'||LOTPRICE||'/'||to_number(substr(CLIENTCDSNO,0,13))||substr(CLIENTCDSNO,14,3)||'/'||
			CONTRACTDATE,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,'&2' 
			from CUSTOM.TRADING_TABLE	
			where TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
			and bank_id = '&2';
			COMMIT;

		End;
		Begin
			insert into CUSTOM.TRADING_TRAN_TABLE (CUSTODIKNOWCODE, CLIENTCDSNO, CONTRACTNUMBER,CONTRACTDATE, BRANCHCODE, 
			DRCRACCOUNT, AMOUNT, DRCRIND,REMARKS,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,BANK_ID ) select CUSTODIKNOWCODE,CLIENTCDSNO,CONTRACTNUMBER,CONTRACTDATE,'&8','&9',CDSCGUARANTEE,'C'
			,LOTQTY||''||SECURITYCODE||'@'||LOTPRICE||'/'||to_number(substr(CLIENTCDSNO,0,13))||substr(CLIENTCDSNO,14,3)||'/'||
			CONTRACTDATE,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,'&2'
			from CUSTOM.TRADING_TABLE	
			where TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
			and bank_id = '&2';
			COMMIT;
		End;

		begin
			Begin
				select foracid into v_foracid from TBAADM.gam, CUSTOM.TRADING_TABLE
				where gam.FORACID=TRADING_TABLE.BROKERACOUNT
				and gam.bank_id=TRADING_TABLE.bank_id
				and TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
				and acct_cls_flg ='N' 
				and FREZ_CODE not in ('T','C')
				and del_flg='N'
				and gam.bank_id = '&2';

				EXCEPTION

				WHEN NO_DATA_FOUND THEN
				V_VALID :='N';
				V_REMARKS	:='Account '||i.BROKERACOUNT||' Closed/Frozen/Deleted/Broker Unknown';

				WHEN OTHERS THEN
				V_VALID :='N';
				V_REMARKS	:='DATABASE ERROR';
			End;
			insert into CUSTOM.TRADING_TRAN_TABLE (CUSTODIKNOWCODE, CLIENTCDSNO, CONTRACTNUMBER,CONTRACTDATE, BRANCHCODE, 
			DRCRACCOUNT, AMOUNT, DRCRIND,REMARKS,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,BANK_ID ) select CUSTODIKNOWCODE,CLIENTCDSNO,CONTRACTNUMBER,CONTRACTDATE,'&10',
			BROKERACOUNT,(BROKERCOMMISSION+ NSE+CMA+ CMACOMP + REVENUESTAMP)
			,'C',LOTQTY||''||SECURITYCODE||'@'||LOTPRICE||'/'||to_number(substr(CLIENTCDSNO,0,13))||substr(CLIENTCDSNO,14,3)||'/'||
			CONTRACTDATE,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,'&2'
			from CUSTOM.TRADING_TABLE,TBAADM.gam
			where gam.FORACID=TRADING_TABLE.BROKERACOUNT
			and gam.bank_id=TRADING_TABLE.bank_id
			and TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
			and acct_cls_flg ='N' 
			and FREZ_CODE not in ('T','C')
			and del_flg='N'
			and gam.bank_id = '&2';
			COMMIT;
		End;

		begin
			 IF i.ordertype='Purchase' THEN 
				insert into CUSTOM.TRADING_TRAN_TABLE (CUSTODIKNOWCODE, CLIENTCDSNO, CONTRACTNUMBER,CONTRACTDATE, BRANCHCODE, 
				DRCRACCOUNT, AMOUNT, DRCRIND,REMARKS,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,BANK_ID ) select CUSTODIKNOWCODE,CLIENTCDSNO,CONTRACTNUMBER,CONTRACTDATE,
				'&11','&12',AMOUNT,'C',LOTQTY||''||SECURITYCODE||'@'||LOTPRICE||'/'||to_number(substr(CLIENTCDSNO,0,13))||substr(CLIENTCDSNO,14,3)||'/'||
				CONTRACTDATE,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,'&2' 
				from CUSTOM.TRADING_TABLE
				where TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
				and bank_id = '&2';
				COMMIT;
			ELSE
				Begin
					select gam.sol_id,gam.foracid,schm_type,acct_cls_flg,frez_code,del_flg,acct_crncy_code,clr_bal_amt
					into v_sol_id,v_foracid,v_schm,v_acct_cls_flg,v_frez_code,v_del_flg,v_crncy_code,v_balance
					--select FORACID,acct_crncy_code into v_foracid,V_CRNCYCODE
					from TBAADM.gam, CUSTOM.TRADING_TABLE 
					where gam.FORACID=TRADING_TABLE.ACCOUNTNUMBER
					and gam.bank_id=TRADING_TABLE.bank_id
					and TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
					and gam.bank_id = '&2';

					EXCEPTION

					WHEN NO_DATA_FOUND THEN
					v_valid :='N';
					v_remarks :='Account '||i.ACCOUNTNUMBER||' Not found';

					WHEN TOO_MANY_ROWS THEN
					v_valid :='N';
					v_remarks := 'Duplicate Record exists';

					WHEN OTHERS THEN
					v_valid :='N';
					v_remarks	:='DATABASE ERROR';
				End;

				IF v_acct_cls_flg = 'Y' THEN 
					IF v_schm='LAA' THEN
						select gam.sol_id,gam.foracid,schm_type,acct_cls_flg,frez_code,del_flg,acct_crncy_code
						into v_sol_id,v_foracid,v_schm,v_acct_cls_flg,v_frez_code,v_del_flg,v_crncy_code 
						from TBAADM.gam where acid in (select lam.OP_ACID from TBAADM.lam 
						where acid in (select acid from TBAADM.gam where gam.FORACID=v_foracid ))
						and bank_id = '&2';

						update CUSTOM.TRADING_TABLE set ACCOUNTNUMBER=v_foracid
						where TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
						and TRADING_TABLE.ACCOUNTNUMBER=i.ACCOUNTNUMBER
						and bank_id = '&2';

						commit;
					ELSE
						v_valid :='N';
						v_remarks:='Account '||i.ACCOUNTNUMBER||' Closed';
					END IF;
				END IF ;

				IF v_schm='LAA' THEN
					IF v_balance=0 THEN

						select gam.sol_id,gam.foracid,schm_type,acct_cls_flg,frez_code,del_flg,acct_crncy_code
						into v_sol_id,v_foracid,v_schm,v_acct_cls_flg,v_frez_code,v_del_flg,v_crncy_code 
						from TBAADM.gam where acid in (select lam.OP_ACID from TBAADM.lam 
						where acid in (select acid from TBAADM.gam where gam.FORACID=v_foracid and bank_id = '&2'))
						and bank_id = '&2';

						update CUSTOM.TRADING_TABLE set ACCOUNTNUMBER=v_foracid
						where TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
						and TRADING_TABLE.ACCOUNTNUMBER=i.ACCOUNTNUMBER
						and bank_id = '&2';

						commit;
					END IF;
				END IF;

				IF v_crncy_code  != '&13' THEN 
					v_valid :='N';
					v_remarks:='Account '||i.ACCOUNTNUMBER||' Foreign Currency';
				END IF ;

				IF v_frez_code = 'C' THEN 
					v_valid :='N';
					v_remarks:='Account '||i.ACCOUNTNUMBER||' Credit Freeze';

				END IF ;

				IF v_frez_code = 'T' THEN 
					v_valid :='N';
					v_remarks:='Account '||i.ACCOUNTNUMBER||' Total Freeze';
				END IF ;

				IF v_del_flg = 'Y' THEN 
					v_valid :='N';
					v_remarks:='Account '||i.ACCOUNTNUMBER||' Deleted';

				END IF ;

				insert into CUSTOM.TRADING_TRAN_TABLE (CUSTODIKNOWCODE, CLIENTCDSNO, CONTRACTNUMBER,CONTRACTDATE, BRANCHCODE, 
				DRCRACCOUNT, AMOUNT, DRCRIND,REMARKS,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,BANK_ID) select CUSTODIKNOWCODE,CLIENTCDSNO,CONTRACTNUMBER,CONTRACTDATE,
				gam.sol_id,gam.foracid,
				AMOUNT-(BANKCOMMISSON+CDSC+CDSCGUARANTEE+BROKERCOMMISSION+ NSE+CMA+ CMACOMP + REVENUESTAMP)
				,'C',LOTQTY||''||SECURITYCODE||'@'||LOTPRICE||'/'||to_number(substr(CLIENTCDSNO,0,13))||substr(CLIENTCDSNO,14,3)||'/'||
				CONTRACTDATE,CDSREF,ORDERTYPE,SETTLEMENT_DATE,SETTLEMENT_STATUS,'&2' 
				from CUSTOM.TRADING_TABLE,TBAADM.gam	
				where gam.FORACID=TRADING_TABLE.ACCOUNTNUMBER
				and gam.bank_id=TRADING_TABLE.bank_id
				and TRADING_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
				and acct_cls_flg ='N' 
				and FREZ_CODE not in ('T','C')
				and del_flg='N'
				and gam.bank_id = '&2';
				COMMIT;
			END IF;

				IF V_VALID ='N' THEN
					 Update CUSTOM.TRADING_TRAN_TABLE 
					 set REMARKS=V_REMARKS,STATUS=V_VALID 
					 where TRADING_TRAN_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
					 and bank_id = '&2';
					 commit;
				ELSE
					Update CUSTOM.TRADING_TRAN_TABLE set STATUS=V_VALID 
					where TRADING_TRAN_TABLE.CONTRACTNUMBER=i.CONTRACTNUMBER
					and bank_id = '&2';
					commit;
				END IF ;				  
		End;
		commit;
	end loop;
end;
/
spool off
/

spool &v_errorfile;
select 'CUSTODIKNOWCODE| ACCOUNTNUMBER| CLIENTCDSNO| SECURITYCODE| ORDERTYPE| LOTQTY| LOTPRICE| AMOUNT| BANKCOMMISSON| NSE| CMA| CDSC| CDSCGUARANTEE| CMACOMP| CONTRACTNUMBER| CONTRACTDATE| CDSREF| BROKER| BROKERACOUNT| BROKERCOMMISSION| REVENUESTAMP|SETTLEMENT_DATE|SETTLEMENT_STATUS|REMARKS' from dual
/
Select distinct TRADING_TABLE.CUSTODIKNOWCODE||'|'||TRADING_TABLE.ACCOUNTNUMBER||'|'||TRADING_TABLE.CLIENTCDSNO||'|'||
TRADING_TABLE. SECURITYCODE||'|'||TRADING_TABLE.ORDERTYPE||'|'||TRADING_TABLE.LOTQTY||'|'||TRADING_TABLE.LOTPRICE||'|'||
TRADING_TABLE. AMOUNT||'|'||TRADING_TABLE.BANKCOMMISSON||'|'||TRADING_TABLE.NSE||'|'||TRADING_TABLE.CMA||'|'||TRADING_TABLE.CDSC
||'|'||TRADING_TABLE.CDSCGUARANTEE||'|'||TRADING_TABLE.CMACOMP||'|'||TRADING_TABLE.CONTRACTNUMBER||'|'||
TRADING_TABLE.CONTRACTDATE||'|'||TRADING_TABLE.CDSREF||'|'||TRADING_TABLE.BROKER||'|'||TRADING_TABLE.BROKERACOUNT
||'|'||TRADING_TABLE.BROKERCOMMISSION||'|'||TRADING_TABLE.REVENUESTAMP||'|'||TRADING_TABLE.SETTLEMENT_DATE||'|'||TRADING_TABLE.SETTLEMENT_STATUS||'|'||TRADING_TRAN_TABLE.remarks
from CUSTOM.TRADING_TABLE,CUSTOM.TRADING_TRAN_TABLE
where TRADING_TRAN_TABLE.CONTRACTNUMBER=TRADING_TABLE.CONTRACTNUMBER
and TRADING_TRAN_TABLE.bank_id=TRADING_TABLE.bank_id
and TRADING_TRAN_TABLE.status='N'
and TRADING_TRAN_TABLE.bank_id = '&2'
/
spool off
/
Spool &v_sucessfile;
select 'CONTRACTNUMBER|LOTDATE|BROKERCODE|BROKERNAME|ACCOUNTNUMBER|CLIENTCDSNO|REMARKS|GROSS|LEVIES|NETVALUE|SETTLEMENT_DATE|SETTLEMENT_STATUS' from dual
/
select distinct decode(TRADING_TABLE.ORDERTYPE,'Sale','S','Purchase','P')||TRADING_TRAN_TABLE.CONTRACTNUMBER||'|'||
TRADING_TRAN_TABLE.CONTRACTDATE||'|'||CUSTOM.TRADING_TABLE.BROKER||'|'||acct_name||'|'||TRADING_TABLE.ACCOUNTNUMBER||'|'||
TRADING_TABLE.CLIENTCDSNO||'|'||TRADING_TRAN_TABLE.REMARKS||'|'||TRADING_TABLE.AMOUNT||'|'||
(TRADING_TABLE.BANKCOMMISSON+ TRADING_TABLE.NSE+ TRADING_TABLE.CMA+TRADING_TABLE.CDSC+ TRADING_TABLE.CDSCGUARANTEE+ TRADING_TABLE.CMACOMP+TRADING_TABLE.REVENUESTAMP)||'|'||
decode (TRADING_TABLE.ordertype,'Sale',TRADING_TABLE.AMOUNT-(TRADING_TABLE.BANKCOMMISSON+ TRADING_TABLE.NSE+ TRADING_TABLE.CMA+ TRADING_TABLE.CDSC+ TRADING_TABLE.CDSCGUARANTEE+ TRADING_TABLE.CMACOMP+TRADING_TABLE.REVENUESTAMP),
'Purchase',TRADING_TABLE.AMOUNT+(TRADING_TABLE.BANKCOMMISSON+ TRADING_TABLE.NSE+ TRADING_TABLE.CMA+ TRADING_TABLE.CDSC+ TRADING_TABLE.CDSCGUARANTEE+ TRADING_TABLE.CMACOMP+TRADING_TABLE.REVENUESTAMP)),TRADING_TABLE.SETTLEMENT_DATE,TRADING_TABLE.SETTLEMENT_STATUS
from CUSTOM.TRADING_TRAN_TABLE,CUSTOM.TRADING_TABLE,TBAADM.gam
where TRADING_TRAN_TABLE.CONTRACTNUMBER=TRADING_TABLE.CONTRACTNUMBER
and TRADING_TRAN_TABLE.bank_id=TRADING_TABLE.bank_id
and TRADING_TABLE.ACCOUNTNUMBER=gam.foracid
and TRADING_TABLE.bank_id=gam.bank_id
and TRADING_TRAN_TABLE.status='Y'
and TRADING_TRAN_TABLE.bank_id ='&2'
/
spool off
/
Spool &v_psalefile;
select rpad(TRADING_TRAN_TABLE.DRCRACCOUNT,16,' ')||'&13'||lpad(TRADING_TRAN_TABLE.amount,17,'0')
||' '||lpad(substr(TRADING_TABLE.lotqty||''||TRADING_TABLE.securitycode||'@'||TRADING_TABLE.lotprice||'/'||
to_number(substr(TRADING_TABLE.clientcdsno,0,13))||substr(TRADING_TABLE.CLIENTCDSNO,14,3)
||'/'||TRADING_TABLE.contractdate,0,30),30,' ')||lpad(TRADING_TRAN_TABLE.CONTRACTNUMBER,8,'0')||lpad(TRADING_TRAN_TABLE.amount,25,'0')
||rpad('11',3,' ')||lpad(' ',9,' ')||rpad('001',6,' ')||rpad('68',6,' ')||'Y'||'N' l
from CUSTOM.TRADING_TRAN_TABLE,CUSTOM.TRADING_TABLE,TBAADM.gam
where TRADING_TRAN_TABLE.CONTRACTNUMBER=TRADING_TABLE.CONTRACTNUMBER
and TRADING_TRAN_TABLE.bank_id = TRADING_TABLE.bank_id
and gam.foracid=TRADING_TRAN_TABLE.DRCRACCOUNT
and gam.bank_id=TRADING_TRAN_TABLE.bank_id
and TRADING_TABLE.ordertype='Sale'
and TRADING_TRAN_TABLE.status='Y'
and acct_ownership!='O'
and TRADING_TRAN_TABLE.settlement_status='Prompt'
and TRADING_TRAN_TABLE.bank_id = '&2'
/
select rpad(TRADING_TRAN_TABLE.DRCRACCOUNT,16,' ')||'&13'||lpad(sum(TRADING_TRAN_TABLE.amount),17,'0')
||' '||lpad(substr('Sales For '||to_char(TRADING_TABLE.contractdate,'DD-MM-YYYY'),0,30),30,' ')||lpad('1111',8,'0')||lpad(sum(TRADING_TRAN_TABLE.amount),25,'0')
||rpad('11',3,' ')||lpad(' ',9,' ')||rpad('001',6,' ')||rpad('68',6,' ')||'Y'||'N' l
from CUSTOM.TRADING_TRAN_TABLE,CUSTOM.TRADING_TABLE,TBAADM.gam
where TRADING_TRAN_TABLE.CONTRACTNUMBER=TRADING_TABLE.CONTRACTNUMBER
and TRADING_TRAN_TABLE.bank_id = TRADING_TABLE.bank_id
and gam.foracid=TRADING_TRAN_TABLE.DRCRACCOUNT
and gam.bank_id = TRADING_TRAN_TABLE.bank_id
and TRADING_TABLE.ordertype='Sale'
and TRADING_TRAN_TABLE.status='Y'
and acct_ownership='O'
and TRADING_TRAN_TABLE.settlement_status='Prompt'
and TRADING_TRAN_TABLE.bank_id ='&2'
group by TRADING_TRAN_TABLE.DRCRACCOUNT,TRADING_TABLE.contractdate
/
spool off
/
Spool &v_nsalefile;
select rpad(TRADING_TRAN_TABLE.DRCRACCOUNT,16,' ')||'&13'||lpad(TRADING_TRAN_TABLE.amount,17,'0')
||' '||lpad(substr(TRADING_TABLE.lotqty||''||TRADING_TABLE.securitycode||'@'||TRADING_TABLE.lotprice||'/'||
to_number(substr(TRADING_TABLE.clientcdsno,0,13))||substr(TRADING_TABLE.CLIENTCDSNO,14,3)
||'/'||TRADING_TABLE.contractdate,0,30),30,' ')||lpad(TRADING_TRAN_TABLE.CONTRACTNUMBER,8,'0')||lpad(TRADING_TRAN_TABLE.amount,25,'0')
||rpad('11',3,' ')||lpad(' ',9,' ')||rpad('001',6,' ')||rpad('68',6,' ')||'Y'||'N' l
from CUSTOM.TRADING_TRAN_TABLE,CUSTOM.TRADING_TABLE,TBAADM.gam
where TRADING_TRAN_TABLE.CONTRACTNUMBER=TRADING_TABLE.CONTRACTNUMBER
and TRADING_TRAN_TABLE.bank_id=TRADING_TABLE.bank_id
and gam.foracid=TRADING_TRAN_TABLE.DRCRACCOUNT
and gam.bank_id=TRADING_TRAN_TABLE.bank_id
and TRADING_TABLE.ordertype='Sale'
and TRADING_TRAN_TABLE.status='Y'
and acct_ownership!='O'
and TRADING_TRAN_TABLE.bank_id = '&2'
and TRADING_TRAN_TABLE.settlement_status='Normal'
/
select rpad(TRADING_TRAN_TABLE.DRCRACCOUNT,16,' ')||'&13'||lpad(sum(TRADING_TRAN_TABLE.amount),17,'0')
||' '||lpad(substr('Sales For '||to_char(TRADING_TABLE.contractdate,'DD-MM-YYYY'),0,30),30,' ')||lpad('1111',8,'0')||lpad(sum(TRADING_TRAN_TABLE.amount),25,'0')
||rpad('11',3,' ')||lpad(' ',9,' ')||rpad('001',6,' ')||rpad('68',6,' ')||'Y'||'N' l
from CUSTOM.TRADING_TRAN_TABLE,CUSTOM.TRADING_TABLE,TBAADM.gam
where TRADING_TRAN_TABLE.CONTRACTNUMBER=TRADING_TABLE.CONTRACTNUMBER
and TRADING_TRAN_TABLE.bank_id=TRADING_TABLE.bank_id
and gam.foracid=TRADING_TRAN_TABLE.DRCRACCOUNT
and gam.bank_id=TRADING_TRAN_TABLE.bank_id
and TRADING_TABLE.ordertype='Sale'
and TRADING_TRAN_TABLE.status='Y'
and acct_ownership='O'
and TRADING_TRAN_TABLE.settlement_status='Normal'
and TRADING_TRAN_TABLE.bank_id = '&2'
group by TRADING_TRAN_TABLE.DRCRACCOUNT,TRADING_TABLE.contractdate
/
spool off
/
spool &14
select BRANCHCODE||'|'||DRCRACCOUNT||'|'||AMOUNT||'|'||DRCRIND||'|'||REMARKS||'|'||'&13'
from CUSTOM.TRADING_TRAN_TABLE
where status='Y'
and CUSTOM.TRADING_TRAN_TABLE.ordertype='Purchase'
and DRCRIND='D'
and TRADING_TRAN_TABLE.bank_id = '&2'
/
select BRANCHCODE||'|'||DRCRACCOUNT||'|'||sum(AMOUNT)||'|'||DRCRIND||'|'||
lpad(substr('Purchase For '||to_char(contractdate,'DD-MM-YYYY'),0,30),30,' ')||'|'||'&13'
from CUSTOM.TRADING_TRAN_TABLE
where status='Y'
and CUSTOM.TRADING_TRAN_TABLE.ordertype='Purchase'
and DRCRIND='C'
and TRADING_TRAN_TABLE.bank_id = '&2'
group by BRANCHCODE,DRCRACCOUNT,DRCRIND,contractdate
/
spool off	

