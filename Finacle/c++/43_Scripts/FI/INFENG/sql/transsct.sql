---------------------------------------------------------------------------------
--    File Name                  : trans.sql
--    Tables Used                : GAM
--    Date                       : 22.02.2013
--    Author                     : Gokulkrishna
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          22.02.2013     Gokulkrishna                  Original Version
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
spool transct.lst
SELECT GAM.sol_id||'|'||GAM.foracid||'|'||substr(GAM.acct_name,1,30)||'|'||
ADT.audit_bod_date||'|'||CONCAT( substr(table_key,0,instr(table_key,'/')-1),' HACXFRSC-Menu Option') FROM TBAADM.GAM,TBAADM.ADT,TBAADM.SCT
WHERE GAM.acid = SCT.acid 
AND substr(table_key,0,instr(table_key,'/')-1) = SCT.SRL_NUM
AND ADT.init_sol_id in (SELECT sol_id FROM TBAADM.SST WHERE set_id = '&1' AND bank_id = '&2')
AND ADT.table_name = 'SCT'
AND ENTERER_ID not in ('SK04908','JN05794')
AND ADT.auth_id = '!'
AND GAM.bank_id = ADT.bank_id
AND GAM.bank_id = SCT.bank_id
AND GAM.bank_id = '&2';
spool off;
exit;


