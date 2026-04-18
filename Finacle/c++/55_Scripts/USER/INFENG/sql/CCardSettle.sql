---------------------------------------------------------------------------------

--    File Name                  : CCardSettle.sql 

--    Tables Used                : GAM,CUSTOM.C_CCST

--    Date                       : 01.03.2013

--    Author                     : GOKULKRISHNA 

--    Assumptions                : NA

--    Modification History    :

--    <Serial No.>    <Date>        <Author Name>		<Description>

--       1.          01.03.2013     GOKULKRISHNA            Original Version
--       2.          29.08.2013     Vijaya V 	for TOL -370084

-----------------------------------------------------------------------------------

set echo off
set feed off
set head off
set verify off
set term off
set pages 0
set linesize 861
set trims on
set serveroutput on



col ee  new_value v_remark noprint
col uu  new_value v_filename noprint
col fn  new_value v_newfilename1 noprint
col fnn  new_value v_newfilename2 noprint
col l new_value v_len
col inp new_value v_input



SELECT '&1' inp FROM DUAL
/
SELECT SUBSTR('&v_input',1,INSTR('&v_input','/') - 1) uu ,LENGTH(substr('&v_input',1,INSTR('&v_input','/') + 1 )) l FROM DUAL
/
SELECT SUBSTR('&v_input',&v_len) ee FROM DUAL
/
SELECT '&v_filename'||'.TXT' fn FROM DUAL
/
SELECT '&v_filename'||'.RPT' fnn FROM DUAL
/
spool '&4';

SELECT GAM.sol_id||'|'||DEBIT_ACCOUNT||'|'||gam.ACCT_CRNCY_CODE||'|'||'D'||'|'||(TRANSFER_AMOUNT/100)||'|'||TRANSFER_DESCRIPTOR 
FROM TBAADM.GAM,CUSTOM.C_CCST
WHERE GAM.foracid=TRIM(C_CCST.DEBIT_ACCOUNT)
AND GAM.acct_cls_flg='N'
AND GAM.del_flg = 'N'
AND GAM.entity_cre_flg = 'Y'
AND GAM.bank_id = C_CCST.bank_id
AND GAM.bank_id = '&2'
AND row_code = '&3'
UNION ALL
SELECT GAM.sol_id||'|'||CREDIT_ACCOUNT||'|'||gam.ACCT_CRNCY_CODE||'|'||'C'||'|'||(TRANSFER_AMOUNT/100)||'|'||TRANSFER_DESCRIPTOR
FROM TBAADM.GAM,CUSTOM.C_CCST
WHERE GAM.foracid=TRIM(C_CCST.CREDIT_ACCOUNT)
AND  GAM.acct_cls_flg='N'
AND GAM.del_flg = 'N'
AND GAM.entity_cre_flg = 'Y'
AND GAM.bank_id = C_CCST.bank_id
AND GAM.bank_id = '&2'
AND row_code = '&3'
/

spool off;

UPDATE CUSTOM.C_CCST SET UPLDSTATUS='P',Valid='Y',REMARKS='Processed'
WHERE CREDIT_ACCOUNT IN 
(SELECT CREDIT_ACCOUNT 
 FROM TBAADM.GAM,CUSTOM.C_CCST 
 WHERE GAM.foracid=TRIM(C_CCST.CREDIT_ACCOUNT)
AND GAM.acct_cls_flg='N'
AND GAM.del_flg = 'N'
AND GAM.entity_cre_flg = 'Y'
AND GAM.bank_id = C_CCST.bank_id
AND GAM.bank_id = '&2'
)
AND C_CCST.bank_id = '&2'

/
commit
/

spool &v_newfilename2;

select ROW_CODE||'|'||ROW_NUMBER||'|'||TRANSFER_NUMBER||'|'||TRANSFER_CODE||'|'||DEBIT_ACCOUNT||'|'||CREDIT_ACCOUNT||'|'||TRANSFER_AMOUNT||'|'||TRANSFER_LOCAL_AMOUNT||'|'||TRANSFER_DESCRIPTOR||'|'||AMOUNT_SIGN||'|'||GROUP_IDENTIFIER||'|'||TRANSFER_TYPE||'|'||REFERENCE_NUMBER||'|'||RESERVED||'|'||TERMINAL_SYMBOL||'|'||DELIMITER||'|'||PARTICULARS||'|'||UPLDSTATUS||'|'||VALID||'|'||REMARKS    
FROM CUSTOM.C_CCST
WHERE C_CCST.BANK_ID = '&2' 

/

spool off;



exit

