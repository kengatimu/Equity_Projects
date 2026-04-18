--------------------------------------------------------------------------------
--    File Name                  : Images.sql
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
spool image.lst

select GAM.sol_id||'|'||GAM.foracid||'|'||SUBSTR(GAM.acct_name,1,30)||'|'||
(select to_char(db_stat_date) from tbaadm.gct where bank_id = '&2')
from tbaadm.gam
WHERE (SELECT count(1) FROM  SVSUSER.NSIGNOTHERINFO svs
	where  entityid= '&2'
	and foracid=svs.acctid) > 0
and bank_id= '&2'
and entity_cre_flg = 'Y'
and acct_cls_flg = 'N'
and del_flg = 'N'
and sol_id= '&1';

spool off;
exit;
