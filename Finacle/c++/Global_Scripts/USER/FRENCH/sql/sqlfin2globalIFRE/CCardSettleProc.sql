---------------------------------------------------------------------------------
--    File Name                  : CCardSettleProc.sql 
--    Tables Used                : CUSTOM.C_CCST
--    Date                       : 01.03.2013
--    Author                     : GOKULKRISHNA 
--    Assumptions                : NA
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>		<Description>
--       1.          01.03.2013     GOKULKRISHNA            Original Version
--	 2.          29.08.2013     Vijaya V 	for TOL -370084
-----------------------------------------------------------------------------------
set echo off
set feed off
set head off
set verify off
set term off
set pages 0
set linesize 861
set trims on
col ee  new_value v_remark noprint
col uu  new_value v_filename noprint
col fn  new_value v_newfilename noprint
col l new_value v_len
col inp new_value v_input

SELECT '&1' inp FROM DUAL
/
SELECT SUBSTR('&v_input',1,INSTR('&v_input','/') - 1) uu ,LENGTH(SUBSTR('&v_input',1,INSTR('&v_input','/') + 1 )) l FROM DUAL
/
SELECT SUBSTR('&v_input',&v_len) ee FROM DUAL
/
SELECT '&v_filename'||'.txt' fn FROM DUAL
/
DELETE FROM CUSTOM.C_CCST WHERE Row_Code IN ('FT','FH') and bank_id = '&2'
/
COMMIT
/
UPDATE CUSTOM.C_CCST SET Particulars ='&v_remark',UpldStatus='U',Valid='N',REMARKS='Not Processed'
WHERE BANK_ID = '&2'
/
COMMIT
/
exit
