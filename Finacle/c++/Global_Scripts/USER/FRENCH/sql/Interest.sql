---------------------------------------------------------------------------------
--    File Name                  : Interes.sql
--    Tables Used                : ITC,GAM,ADT
--    Date                       : 19.05.2017
--    Author                     : Kim Mugambi
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          19.05.2017    Kim Mugambi                  Original Version
--       2.          30.04.2018    Irungu James                 Check even past dates
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
spool Interest.lst
select g.sol_id||'|'||g.foracid||'|'||g.acct_name||'|'||a.ENTERER_ID||'|'||a.mop_id||'|'||a.AUDIT_BOD_DATE
from tbaadm.gam g, tbaadm.itc i,tbaadm.adt a 
where  a.auth_id ='!' 
and a.table_name ='ITC' 
and a.acid = g.acid 
and a.acid = i.ENTITY_ID 
and a.bank_id = g.bank_id 
and a.bank_id = i.bank_id 
and i.ENTITY_TYPE ='ACCNT'  
and i.ENTITY_CRE_FLG ='N'  
and  a.MOP_ID IN ('HLINTTM','HINTTM') 
and g.bank_id ='&2'
and g.Sol_id ='&1';
spool off;
exit;

