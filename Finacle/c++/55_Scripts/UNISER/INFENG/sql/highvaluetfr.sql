---------------------------------------------------------------------------------
--    File Name                  :highvaluetfr.sql
--    Tables Used                : ADT,GAM,SMT
--    Date                       : 28.05.2019
--    Author                     : Kim Mugambi
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--      1.            28.05.2019     Kim Mugambi                  Original Version
-----------------------------------------------------------------------------------
set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool highvaluetfr.lst
select ADT.init_sol_id||'|'|| gam.FORACID||'|'|| gam.ACCT_NAME||'|'||SMT.ACCT_STATUS||'|'||ADT.TABLE_NAME||'|'||ADT.MOP_ID
FROM TBAADM.ADT, tbaadm.SMT,tbaadm.gam
WHERE ADT.bank_id = SMT.bank_id
AND ADT.bank_id = gam.bank_id
AND gam.acid=SMT.acid
AND gam.acid=ADT.acid 
AND  gam.SCHM_CODE not in ('SB199','CA299')
AND ADT.init_sol_id ='&1'
AND ADT.bank_id ='&2'
AND SMT.ACCT_STATUS in ('D','I')
AND ADT.auth_id = '!'
AND ADT.FUNC_CODE <>'Z' 
AND adt.AUDIT_DATE>'01-jan-2020';
spool off;
exit;
