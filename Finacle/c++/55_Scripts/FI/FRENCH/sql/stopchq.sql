set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool stopchq.lst
select sol_ID||'|'||FORACID||'|'||trim(BEGIN_CHQ_NUM)||'|'||trim(END_CHQ_NUM) from tbaadm.spt, tbaadm.gam
where gam.acid=spt.acid
and gam.bank_id=spt.bank_id
and spt.ENTITY_CRE_FLG! = 'Y'
and (spt.del_flg !='Y' or spt.del_flg  is null)
and sol_ID in (select sol_id from sst where SET_ID = '&1' and bank_id='&2')
and gam.bank_id = '&2'
and gam.del_flg = 'N'; 
exit;
