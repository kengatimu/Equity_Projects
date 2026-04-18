---------------------------------------------------------------------------------
--    File Name                  : rtgs.sql
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
spool rtgs.lst
select  sol_id||'|'||TRAN_ID||'|'||PYMT_REF_NUM||'|'||TRAN_DATE||'|'||REMIT_AMT||'|'||ROUTED_PAYSYS_ID||'|'||rcre_user_id  
 FROM tbaadm.PORD WHERE PORD.rcre_time IS NOT NULL AND  PORD.pymt_ref_num is not NULL AND PORD.lchg_time IS NOT NULL and  PORD.bank_id ='&1' 
 AND PORD.routed_paysys_id  in ('SWIFT' ,'RTGS')  AND  PORD.status =  'A' AND   PORD.sol_id = '&2' and  PORD.RCRE_USER_ID !='FIVUSR43'  and PORD.RCRE_TIME>'01-jan-2019';
spool off;
exit;
