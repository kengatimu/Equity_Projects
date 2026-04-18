set head off
set verify off
set feed off
set term off
set pages 0
set linesize 250
set trims on
set maxdata 60000
set serveroutput on size 1000000
spool dailymv_adhoc.lst

exec CUSTOM.INSERT_DAILY_MOVE_DRC_ADHOC('&3')
/
commit
/
exec CUSTOM.INSERT_INTO_STAGE_DRC_ADHOC('&3')
/
commit;
/
spool off;
exit;
