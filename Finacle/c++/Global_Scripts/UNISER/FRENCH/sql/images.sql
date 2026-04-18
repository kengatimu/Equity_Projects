--------------------------------------------------------------------------------
--    File Name                  : Images.sql
--    Tables Used                : GAM
--    Date                       : 22.02.2013
--    Author                     : Gokulkrishna
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--       1.          22.02.2013     Gokulkrishna                  Original Version
--       2.          22.08.2018     James Irungu                  Modified
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

select A.SOL_ID||'|'||a.ACCTID||'|'||a.acct_name||'|'||a.OCCUREDAT||'|'||a.user_id from 
(SELECT c.sol_id,  a.ACCTID, SUBSTR(d.acct_name,1,30)acct_name, max(to_date (cast (b.OCCUREDAT as date),'DD-MM-YY')) OCCUREDAT,
c.user_id, e.bank_id FROM  SVSUSER.NSIGNOTHERINFO a, SVSUSER.AUDITINFO b, tbaadm.upr c, tbaadm.gam d,
tbaadm.smt e where a.ENTITYID =b.ENTITYID and  a.ACCTID=d.foracid and a.ACCTID =b.ACCTID and a.SIGNID = b.SIGNID
and b.USERNAME =c.user_id and c.del_flg ='N' and d.acct_cls_flg='N' and e.bank_id =d.bank_id and
d.acid =e.acid  group by c.sol_id, a.ACCTID, acct_name, e.bank_id, c.user_id)a, 
( SELECT a.ACCTID,max(to_date (cast (b.OCCUREDAT as date),'DD-MM-YY')) OCCUREDAT FROM
  SVSUSER.NSIGNOTHERINFO a,  SVSUSER.AUDITINFO b where a.ENTITYID =b.ENTITYID and  
a.ACCTID =b.ACCTID and a.SIGNID = b.SIGNID and to_date (cast (b.OCCUREDAT as date),'DD-MM-YY') > '01-SEP-2018'  
group by  a.ACCTID)b where a.ACCTID =b.ACCTID and b.OCCUREDAT =a.OCCUREDAT
and  a.sol_id ='&1' and a.bank_id ='&2';

spool off;
exit;

