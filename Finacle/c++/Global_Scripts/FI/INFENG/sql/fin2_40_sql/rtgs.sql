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
select SOL_ID||'|'||TRAN_ID||'|'||SENDER_REF_NUM||'|'||TRAN_DATE||'|'||TRAN_AMT||'|'||PAYSYS_ID||'|'||RCRE_USER_ID from tbaadm.SMH
where bank_id='&1'
and sol_id='&2' 
and STATUS= 'N'
and MT_NO='103'
and swift_msg like '%:201:RTO%';
spool off;
exit;
