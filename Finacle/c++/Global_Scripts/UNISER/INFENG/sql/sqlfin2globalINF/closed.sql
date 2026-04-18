---------------------------------------------------------------------------------
--    File Name                  : closed.sql
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
spool closed.lst
select gam.sol_id||'|'||gam.FORACID||'|'||substr(gam.ACCT_NAME,1,30)||'|'||adt.AUDIT_BOD_DATE from gam,adt
where gam.acid=adt.acid 
and gam.bank_id=adt.bank_id 
and adt.INIT_SOL_ID in (select sol_id from sst where SET_ID = '&1')
and adt.TABLE_NAME='GAM'
and adt.AUTH_ID='!'
and adt.FUNC_CODE='Z'
AND adt.ENTERER_ID not in ('JN05794','SM01534','CN01473')
and gam.acct_cls_flg='N';
spool off;
exit;
