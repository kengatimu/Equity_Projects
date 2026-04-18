---------------------------------------------------------------------------------
--    File Name                  : unzerocashgls.sql
--    Tables Used                : GAM
--    Date                       : 22.02.2013
--    Author                     : Gokulkrishna
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          22.02.2013     Gokulkrishna                  Original Version
--------------------------------------------------some ---------------------------------
set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool unzerocashgls.lst
select gam.sol_id||'|'||gam.FORACID||'|'||substr(gam.ACCT_NAME,1,30)||'|'||clr_bal_amt from TBAADM.gam
where CLR_BAL_AMT != 0
 AND INSTR('&3', concat(concat('!',gl_sub_head_code),'!')) > 0 
 AND bacid NOT LIKE concat(concat('%','ATMTELLER'),'%') AND (bacid LIKE concat(concat('%','&4'),'%')
 OR bacid LIKE concat(concat('%','&5'),'%')
 OR bacid = '&6'
 OR bacid = '&7'
 OR bacid = '&8')
 AND sol_id  = '&1'
 AND GAM.del_flg!='Y' 
 AND GAM.entity_cre_flg = 'Y' 
 AND GAM.bank_id = '&2';

spool off;
exit;
