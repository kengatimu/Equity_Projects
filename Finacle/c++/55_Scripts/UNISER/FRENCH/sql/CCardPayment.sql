---------------------------------------------------------------------------------

--    File Name                  : CCardPayment.sql 

--    Tables Used                : HTD

--    Date                       : 22.02.2013

--    Author                     : GOKULKRISHNA 

--    Assumptions                : NA

--    Modification History    :

--    <Serial No.>    <Date>        <Author Name>		<Description>

--       1.          22.02.2013     GOKULKRISHNA            Original Version

-----------------------------------------------------------------------------------
SET serveroutput ON SIZE 1000000
SET pages 0
SET heading off
SET feedback off
SET linesize 861
SET echo off
SET verify off
SET trims on
col inp new_value v_input noprint
col uu new_value  v_filename noprint
col nu new_value  v_filenumber noprint
col rem  new_value v_reminder noprint
col remle new_value v_len noprint
col l new_value v_lenn noprint
col ee  new_value v_date noprint
col fn new_value v_allfilename noprint

SELECT '&1' inp FROM DUAL
/
SELECT SUBSTR('&v_input',1,INSTR('&v_input','/') - 1) uu ,LENGTH(SUBSTR('&v_input',1,INSTR('&v_input','/') + 1 )) remle FROM DUAL
/
SELECT SUBSTR('&v_input',&v_len) rem FROM DUAL
/

SELECT SUBSTR('&v_reminder',1,INSTR('&v_reminder','/') - 1) ee ,LENGTH(SUBSTR('&v_reminder',1,INSTR('&v_reminder','/') + 1 )) l FROM DUAL
/
SELECT SUBSTR('&v_reminder',&v_lenn) nu FROM DUAL
/
SELECT '&v_filename'||'_ALL_'||'&v_date'||'_.TXT' fn FROM DUAL
/

spool &v_filename;



DECLARE
v_filename long ;
v_fileheader long ;
v_Batchheader long ;
v_Batchtrailer long ;
v_recorddetails long ;
v_filetrailer long ;
v_rownum NUMBER(20,2) := 0;
v_cnt NUMBER(20,2) := 0;
v_total NUMBER(20,2) := 0;
v_amount NUMBER(20,2) := 0;


BEGIN
    v_rownum :=v_rownum+1;
    SELECT 'FH'||LPAD(v_rownum,6,'0')||RPAD('PAYMENT',10,'~')||RPAD('12',3,'~')||RPAD('0068',6,'~')||
    TO_CHAR(SYSDATE,'YYYYMMDD')||TO_CHAR(SYSDATE,'HHMISS')||'00'||LPAD(&v_filenumber,2,'0')||RPAD('0068',6,'~')||'RCNBW N'||LPAD(' ',145,'~')||'*' 
    INTO v_fileheader FROM DUAL;  

	DBMS_OUTPUT.PUT_LINE(v_filename);
	DBMS_OUTPUT.PUT_LINE(v_fileheader);
    v_rownum :=v_rownum+1;
    SELECT 'BH'||LPAD(v_rownum,6,'0')||LPAD('1',10,'0')||RPAD('PAYCARD',12,'~')||'~'||RPAD(' ',4,'~')||'C'||'&4'||
    RPAD('PAYMENT TO CARD',32,'~')||RPAD(' ',100,'~')||RPAD(' ',16,'~')||RPAD(' ',8,'~')||RPAD('*',1,' ') INTO v_Batchheader FROM DUAL;
    DBMS_OUTPUT.PUT_LINE(v_Batchheader);
     v_rownum :=v_rownum+1;
    FOR i IN (SELECT HTD.tran_amt,ref_num contract FROM TBAADM.HTD 
             WHERE acid='&3' AND HTD.tran_date = TO_DATE('&v_date','DD-MM-YYYY') AND 
	     ref_num IS NOT NULL AND HTD.del_flg!='Y' AND HTD.pstd_flg='Y' AND htd.part_tran_type='C' AND bank_id = '&2')
         LOOP

        v_cnt:=v_cnt+1;
        v_total:= v_total + i.tran_amt;
        DBMS_OUTPUT.PUT_LINE('RD'||lpad(v_rownum,6,'0')||LPAD(v_cnt,6,'0')||LPAD((i.tran_amt*100),15,'0')||RPAD(i.contract,32,'~')||'~'||RPAD(' ',60,'~')||RPAD(' ',32,'~')||RPAD(' ',1,'~')||RPAD(' ',48,'~')||RPAD('*',34,' '));

        v_rownum :=v_rownum+1;
    end loop;

    SELECT 'BT'||LPAD(v_rownum,6,'0')||LPAD(v_cnt,6,'0')||LPAD((v_total*100),18,'0')||'~'||RPAD(' ',170,'~')||RPAD('*',1,' ')  INTo v_Batchtrailer  FROM DUAL;
    DBMS_OUTPUT.PUT_LINE(v_Batchtrailer);
      v_rownum :=v_rownum+1;
    SELECT 'FT'||LPAD(v_rownum,6,'0')||LPAD('1',6,'0')||LPAD((v_total*100),18,'0')||'~'||LPAD(' ',170,'~')||'*' INTO v_filetrailer FROM DUAL;  
    DBMS_OUTPUT.PUT_LINE(v_filetrailer);


END;
/

spool off  



