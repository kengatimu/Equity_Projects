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
(gam.schm_code  not in ('SB199','CA299') and gam.clr_bal_amt >  ( case when schm_code='CA212' then  400000 when  schm_code!='CA212' then  2000000  end )  and acct_crncy_code ='&3') or 
(gam.schm_code  not in ('SB199','CA299') and gam.clr_bal_amt >(select   ( case when schm_code='CA212' then  400000 when  schm_code!='CA212' then  2000000  end ) /VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='ZAR' and  VAR_CRNCY_CODE='&3' and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='ZAR') or 
(gam.schm_code  not in ('SB199','CA299') and gam.clr_bal_amt >(select   ( case when schm_code='CA212' then  400000 when  schm_code!='CA212' then  2000000  end ) /VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='CAD' and  VAR_CRNCY_CODE='&3' and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='CAD') or
(gam.schm_code  not in ('SB199','CA299') and gam.clr_bal_amt >(select   ( case when schm_code='CA212' then  400000 when  schm_code!='CA212' then  2000000  end ) *VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='CNY' and  VAR_CRNCY_CODE='&3' and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='CNY') or 
(gam.schm_code  not in ('SB199','CA299') and gam.clr_bal_amt >(select   ( case when schm_code='CA212' then  400000 when  schm_code!='CA212' then  2000000  end ) /VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='USD' and  VAR_CRNCY_CODE='&3' and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='USD') or 
(gam.schm_code  not in ('SB199','CA299') and gam.clr_bal_amt >(select   ( case when schm_code='CA212' then  400000 when  schm_code!='CA212' then  2000000  end ) /VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='GBP' and  VAR_CRNCY_CODE='&3' and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='GBP') or
(gam.schm_code  not in ('SB199','CA299') and gam.clr_bal_amt > (select   ( case when schm_code='CA212' then  400000 when  schm_code!='CA212' then  2000000  end ) /VAR_CRNCY_UNITS from tbaadm.rtl where FXD_CRNCY_CODE ='EUR' and VAR_CRNCY_CODE='&3' and RATECODE ='MEAN' and bank_id ='&2') and acct_crncy_code ='EUR'))
and gam.bank_id ='&2' and smt.ACCT_STATUS='D' and smt.acid =gam.acid and smt.bank_id =gam.bank_id and sol_id ='&1' )) where MOP_ID < trunc (sysdate);

spool off;
exit;
