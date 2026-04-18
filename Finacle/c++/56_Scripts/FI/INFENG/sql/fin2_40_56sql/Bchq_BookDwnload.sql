#---------------------------------------------------------------------------------
#--    File Name                  : Bchq_BookDwnload.sql
#--    Date                       : 01.03.2013
#--    Author                     : Gokulkrishna
#--    Assumptions                : NIL
#--    Modification History    :
#--    <Serial No.>    <Date>        <Author Name>                <Description>
#--       1.          01.03.2013     Gokulkrishna                  Original Version
#-----------------------------------------------------------------------------------
set feedback off
set pages 0
set heading off
set linesize 861
set echo off
set verify off
set trims on
SET serveroutput ON SIZE 1000000

col tmp  new_value v_tmp noprint
col fn  new_value v_filename noprint
col df  new_value v_datefrm noprint
col dt  new_value v_dateto noprint
col dw  new_value v_dwnldid noprint
col dwdt  new_value v_dwnlddate noprint


select  '&1' tmp from dual
/
select SUBSTR('&v_tmp',1,instr('&v_tmp',',') - 1) fn,SUBSTR('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select SUBSTR('&v_tmp',1,instr('&v_tmp',',') - 1) df,SUBSTR('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select SUBSTR('&v_tmp',1,instr('&v_tmp',',') - 1) dt,SUBSTR('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select SUBSTR('&v_tmp',1,instr('&v_tmp',',') - 1) dw,SUBSTR('&v_tmp',instr('&v_tmp',',') + 1) tmp from dual
/
select '&v_tmp' dwdt from dual
/
spool &v_filename

set feedback off
declare

cursor cur is SELECT c_bchq.FORACID,BANK_CODE,BRANCH_CODE, BR_NAME, BR_ADDR_1, BEGIN_CHQ_NUM, NUM_OF_CHB,REQ_ID,CLG_REF_CODE,CLG_REP_CODE,
DECODE(gam.acct_crncy_code,'&13','&5','&14','&6','&15','&7','&16','&8') gamacctcrncycode,
DECODE(gam.acct_crncy_code,'&13','&9','&14','&10','&15','&11','&16','&12') gamacctcrncycodebook
                    FROM  CUSTOM.C_BCHQ,TBAADM.BCT,TBAADM.GAM
              WHERE  c_bchq.BRANCH_CODE=bct.BR_CODE
              AND c_bchq.FORACID=GAM.foracid
              AND REQ_DATE >= TO_DATE('&v_datefrm','DD-MM-YYYY')
              AND req_date <= TO_DATE('&v_dateto','DD-MM-YYYY')
              AND bct.BANK_CODE='&4'
              AND REQ_STATUS = 'A'
              AND c_bchq.del_flg!='Y'
			  AND c_bchq.bank_id = BCT.bank_id
			  AND c_bchq.bank_id = GAM.bank_id
			  AND c_bchq.bank_id = '&3'
              ORDER BY REQ_ID;
	
SORTCODE		VARCHAR2(15);
FORACID1		VARCHAR2(15);
CHQDIGIT		NUMBER;

 Begin
 
	for i in cur loop
	
	----if ('&3' = '55') then
	----SORTCODE	:= i.CLG_REF_CODE||i.BANK_CODE||i.BRANCH_CODE;
	if ('&3' = '56') then

		------SORTCODE    :=  CONCAT(CONCAT(i.BANKCODE,i.MICR_BRCODE),i.CLG_REF_CODE);
		------SORTCODE    :=  CONCAT(CONCAT(i.BANK_CODE,i.BRANCH_CODE),i.CLG_REF_CODE);
		SORTCODE    :=  CONCAT(CONCAT(i.BANK_CODE,SUBSTR(i.BRANCH_CODE,3,'2')),i.CLG_REF_CODE);
	else
		SORTCODE	:= i.BANK_CODE||i.BRANCH_CODE;
	end if;

	FORACID1	:= i.FORACID;
	
	begin
	
	----CUSTOM.EQUITYCommonPack.GETCHQDIGIT(FORACID1,SORTCODE,CHQDIGIT);
	CUSTOM.UGGETCHQDIGIT(FORACID1,SORTCODE,CHQDIGIT);
	
	end;
	
	UPDATE CUSTOM.c_bchq set req_status='S',DOWNLOAD_ID = '&v_dwnldid', DOWNLOAD_DATE = TO_DATE('&v_dwnlddate','DD-MM-YYYY') WHERE req_id=i.REQ_ID  AND  BANK_ID = '&3';
	COMMIT;

if ('&3' = '54') then
	DBMS_OUTPUT.PUT_LINE(i.BANK_CODE||'1'||'~'||i.BANK_CODE||rpad(FORACID1,13,'~')||CHQDIGIT||i.gamacctcrncycode||i.gamacctcrncycodebook||lpad(i.NUM_OF_CHB,2,'0')||lpad(i.BEGIN_CHQ_NUM,6,'0')||rpad(i.BR_NAME,80,'~')||rpad(i.BR_NAME,30,'~')||rpad(i.BR_ADDR_1,30,'~')||rpad(FORACID1,15,'~'));
end if;

if ('&3' = '11') then
	dbms_output.put_line(i.BANK_CODE||'1'||'~'||i.BANK_CODE||'2'||substr(FORACID1,3,2)||lpad(substr(FORACID1,4,13),10)||CHQDIGIT||i.gamacctcrncycode||i.gamacctcrncycodebook||lpad(i.NUM_OF_CHB,2,'0')||lpad(i.BEGIN_CHQ_NUM,6,'0')||rpad(i.BR_NAME,80,'~')||rpad(i.BR_NAME,30,'~')||rpad(i.BR_ADDR_1,30,'~')||rpad(FORACID1,15,'~'));
end if;

if ('&3' = '55') then
	dbms_output.put_line(i.BANK_CODE||'1'||''||i.CLG_REF_CODE||i.BANK_CODE||SUBSTR(i.BRANCH_CODE,3,'2')||SUBSTR(FORACID1,4)||i.CLG_REP_CODE||'12'||'13'||lpad(i.NUM_OF_CHB,2,'0')||lpad(i.BEGIN_CHQ_NUM,6,'0')||'BANKERS CHEQUE'||'~~~~~~~~~~~~~~~~~~~~~~~~~~'||'BANKERS CHEQUE'||'~~~~~~~~~~~~~~~~~~~~~~~~~~'||rpad(i.BR_NAME,30,'~')||rpad(i.BR_ADDR_1,30,'~')||rpad(FORACID1,15,'~')||'00000000');
end if;

if ('&3' = '50') then
	dbms_output.put_line(i.BANK_CODE||'1'||'~'||'~'||i.BANK_CODE||SUBSTR(i.BRANCH_CODE,2,'3')||CHQDIGIT||'~'||SUBSTR(FORACID1,4)||'~'||i.gamacctcrncycode||i.gamacctcrncycodebook||lpad(i.NUM_OF_CHB,2,'0')||lpad(i.BEGIN_CHQ_NUM,8,'0')||'~'||'BANKERS CHEQUE'||'~~~~~~~~~~~~~~~~~~~~~~~~~~'||'BANKERS CHEQUE'||'~~~~~~~~~~~~~~~~~~~~~~~~~~'||rpad(i.BR_NAME,30,'~')||rpad(i.BR_ADDR_1,30,'~')||rpad(FORACID1,15,'~')||'0000000');
end if;

if ('&3' = '56') then
	dbms_output.put_line(i.BANK_CODE||'1'||'~'||i.BANK_CODE||substr(FORACID1,3,2)||i.CLG_REF_CODE||lpad(substr(FORACID1,4,13),10)||lpad(CHQDIGIT,2,'0')||'16'||'17'||lpad(i.NUM_OF_CHB,2,'0')||lpad(i.BEGIN_CHQ_NUM,6,'0')||rpad(i.BR_NAME,80,'~')||rpad(i.BR_NAME,30,'~')||rpad(i.BR_ADDR_1,30,'~')||rpad(FORACID1,15,'~'));
end if;

end loop;  
end;
/
