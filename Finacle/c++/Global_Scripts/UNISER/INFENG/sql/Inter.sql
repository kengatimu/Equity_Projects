---------------------------------------------------------------------------------
--    File Name                  : Inter.sql
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
set echo off
set linesize 250
set TRIMs on
set maxdata 60000
set serveroutput on size 1000000

spool Inter.lst

SELECT d.init_sol_id||'|'||TRIM(a.tran_id)||'|'||a.tran_date||'|'||a.tran_amt||'|'||
a.ref_num||'|'||SUBSTR(a.tran_rmks,1,20)||'|'||DECODE(c.bacid,'&3','SUDAN','&5','KENYA','&4','UGANDA')||'|'||
a.entry_user_id||'|'|| a.pstd_user_id 
FROM TBAADM.DTD a,TBAADM.GAM c,TBAADM.DTH d
WHERE a.acid = c.acid
AND a.tran_id = d.tran_id
AND a.tran_date = d.tran_date
AND c.bacid IN('&4','&5')
AND NOT EXISTS (SELECT 1 FROM CUSTOM.C_INTERCOUNTRY b
					WHERE a.tran_date = b.tran_date 
					AND a.TRAN_ID = b.tran_id 
					AND a.PART_TRAN_SRL_NUM = b.PART_TRAN_SRL_NUM)
AND d.init_sol_id IN (SELECT sol_id FROM TBAADM.SST WHERE set_id = '&1' AND bank_id = '&2')
AND c.bank_id = d.bank_id
AND c.bank_id = a.bank_id
AND c.bank_id = '&2'
UNION ALL 
SELECT init_sol_id||'|'||TRIM(tran_id)||'|'||tran_date||'|'||tran_amt||'|'||fcforacid||'|'||
SUBSTR(FCNAME,1,20)||'|'||DECODE(country_code,'SU','SUDAN','KE','KENYA','UG','UGANDA')||'|'||entry_user_id||'|'||
pstd_user_id 
FROM CUSTOM.C_INTERCOUNTRY
WHERE status = 'P'
AND init_sol_id IN(SELECT sol_id FROM TBAADM.SST WHERE set_id = '&1' AND bank_id = '&2')
AND tran_date IN(SELECT db_stat_date FROM TBAADM.GCT)
AND bank_id = '&2';

spool off;
exit;
