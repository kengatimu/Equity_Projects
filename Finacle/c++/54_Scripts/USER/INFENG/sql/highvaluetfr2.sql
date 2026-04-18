---------------------------------------------------------------------------------
--    File Name                  :highvaluetfr2.sql
--    Tables Used                : ADT,GAM,
--    Date                       : 02.06.2020
--    Author                     : Irungu James
--    Assumptions                : NIL
--    Modification History    :
--    <Serial No.>    <Date>        <Author Name>                <Description>
--      1.            02.06.2020     Irungu James                  Original Version
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
spool highvaluetfr2.lst

select init_sol_id||'|'|| FORACID  ||'|'||ACCT_NAME||'|'||ACCT_STATUS ||'|'|| TABLE_NAME ||'|'|| MOP_ID from ( select sol_id init_sol_id , foracid, clr_bal_amt ,
 acct_name,  schm_code TABLE_NAME, acct_status, acct_crncy_code,ACCT_STATUS_DATE,last_tran_date,  last_t_date, case when ACCT_STATUS_DATE>last_t_date then 
ACCT_STATUS_DATE  else   last_t_date  end MOP_ID   from (select sol_id , ACCT_NAME,foracid, clr_bal_amt, schm_code , acct_crncy_code, acct_status, ACCT_STATUS_DATE,last_tran_date,
   case when last_tran_date is null  then ACCT_STATUS_DATE  else   last_tran_date end last_t_date  from tbaadm.gam, tbaadm.smt where gam.schm_type in ('CAA','SBA') and(
(gam.schm_code not in ('SB199','CA299','SB130','SB135','SB136','SB137','SB145','SB146','SB198','CA216','VA301') and gam.future_un_clr_bal_amt ='0' and gam.clr_bal_amt > 100000 and acct_crncy_code ='&3') or 
 (gam.schm_code  in ('SB130','SB135','SB136','SB137','SB145','SB146') and gam.future_un_clr_bal_amt ='0' and gam.clr_bal_amt > 50000 and acct_crncy_code ='&3') or (gam.schm_code  not in
 ('SB199','CA299','SB135','SB136') and gam.future_un_clr_bal_amt ='0' and gam.clr_bal_amt >(select  100000/VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='USD' and  VAR_CRNCY_CODE='&3' 
and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='USD') or (gam.schm_code  not in ('SB199','CA299','SB135','SB136') and gam.future_un_clr_bal_amt ='0' and gam.clr_bal_amt >
 (select  100000/VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='GBP' and  VAR_CRNCY_CODE='&3' and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='GBP') or
  (gam.schm_code  not in ('SB199','CA299','SB135','SB136') and gam.future_un_clr_bal_amt ='0' and gam.clr_bal_amt > (select  100000/VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='EUR' and 
 VAR_CRNCY_CODE='&3' and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='EUR'))
and gam.bank_id ='&2' and smt.ACCT_STATUS='D' and smt.acid =gam.acid and smt.bank_id =gam.bank_id and sol_id ='&1' )) where MOP_ID < trunc (sysdate);

spool off;
exit;
