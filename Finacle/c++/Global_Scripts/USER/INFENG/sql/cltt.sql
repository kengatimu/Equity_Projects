set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool cltt.lst

/
delete from tbaadm.cltt where acid in
(
select acid from tbaadm.gam where acid in 
(
select acid from tbaadm.cltt where event_id ='PYOFF' 
and FUNC_CODE='P' 
and tran_type='T' 
and PREPAYMENT_TYPE='V' 
and RCRE_USER_ID ='FIVUSR54'
)
and bank_id ='54'
and acct_cls_flg ='N'
and schm_code  in ('LA527','LA526')
)
and event_id ='PYOFF' 
and FUNC_CODE='P' 
and tran_type='T' 
and PREPAYMENT_TYPE='V' 
and RCRE_USER_ID ='FIVUSR54'
/
commit
/
delete  FROM  tbaadm.cltt where EVENT_ID ='LSPAY'  AND  FUNC_CODE ='S'  AND  TRAN_TYPE ='T' AND RCRE_USER_ID='FIVUSR54' AND BANK_ID ='54'
/
commit
/
spool off;
exit;


