set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool faces.lst

exec CUSTOM.Pack_Fin_Coll_Bod_Data_Mvmt.Case_Details_SU('&2','&1');
/
commit
/
exec CUSTOM.Pack_Fin_Coll_Bod_Data_Mvmt.Payments2('&2','&1');
/
commit
/
spool off;
exit;


