set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool facesst.lst

exec CUSTOM.PACK_FIN_COLL_BOD_DATA_MVMT.Cust_Pers_Info('&2');
/
commit
/
exec CUSTOM.PACK_FIN_COLL_BOD_DATA_MVMT.branches_upload('&2');
/
commit
/
spool off;
exit;


