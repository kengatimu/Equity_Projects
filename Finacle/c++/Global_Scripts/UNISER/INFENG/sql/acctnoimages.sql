---------------------------------------------------------------------------------
--    File Name                  :acctnoimages.sql
--    Tables Used                : gam,smt,signcustinfo
--    Date                       : 22.04.2020
--    Author                     : jane ndirangu
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--      1.            22.04.2020     jane ndirangu                  Original Version
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
spool acctnoimages.lst
select sol_id||'|'|| foracid||'|'|| acct_name||'|'|| acct_opn_date||'|'||schm_code||'|'||acct_crncy_code
from tbaadm.gam g , tbaadm.smt s where s.acct_status ='A' and g.acid =s.acid and g.bank_id =s.bank_id and g.schm_type in ('SBA','CAA') and g.bank_id ='&1'
and g.ENTITY_CRE_FLG ='Y' and g.ACCT_CLS_FLG ='N'  and sol_id='&2'
and acct_opn_date= trunc (sysdate) and schm_code!='SB117' and g.foracid not in (SELECT b.ACCTID  FROM  SVSUSER.signcustinfo a,
SVSUSER.signotherinfo b  where  a.SIGNID =b.SIGNID and ACCTID in (select g.foracid from tbaadm.gam g ,tbaadm.smt s where s.acct_status ='A'
and g.acid =s.acid and g.bank_id =s.bank_id and g.schm_type in ('SBA','CAA') and g.bank_id ='&1' and g.ENTITY_CRE_FLG ='Y' and g.ACCT_CLS_FLG ='N'
and acct_opn_date= trunc (sysdate) and sol_id='&2' and schm_code!='SB117' )) order by g.sol_id;
spool off;
exit;
